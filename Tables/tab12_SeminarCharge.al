table 50112 "CSD Seminar Charge"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 1
    //     - Created new table
    Caption = 'Seminar Charge';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            DataClassification = AccountData;
            NotBlank = true;
            TableRelation = "CSD Seminar Reg. Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';
            DataClassification = AccountData;
        }
        field(3; Type; Option)
        {
            Caption = 'Type';
            DataClassification = AccountData;
            OptionCaption = 'Resource,G/L Account';
            OptionMembers = Resource,"G/L Account";
            //Ai ruan vlerën aktuale të fushës "Type" në një variabël të quajtur "OldType".
            //Ai thërret procedurën "Init" për të inicializuar fushat e regjistrimit në vlerat e tyre të paracaktuara.
            //Ai cakton vlerën e ruajtur të "OldType" përsëri në fushën "Type", duke rivendosur vlerën e saj origjinale.
            //Qëllimi i këtij aktivizimi është të rivendosë fushat e regjistrimit në gjendjen e tyre fillestare nëse ndryshohet fusha "Type"
            trigger OnValidate();
            var
                OldType: Integer;
            begin
                if Type <> xRec.Type then begin
                    OldType := Type;
                    Init();
                    Type := OldType;
                end;
            end;
        }
        field(4; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = if (Type = const(Resource)) Resource."No."
            else
            if (Type = const("G/L Account")) "G/L Account"."No.";
            //Ky aktivizues është përgjegjës për plotësimin e fushave përkatëse bazuar në "Lloji" i zgjedhur në regjistrim, pavarësisht nëse është një burim ose një llogari G/L.
            //Kryen vërtetime dhe kopjon vlerat e fushës në përputhje me rrethanat për të siguruar konsistencën dhe saktësinë e të dhënave.
            trigger OnValidate();
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            Resource.TestField(Blocked, false);
                            Resource.TestField("Gen. Prod. Posting Group");
                            Description := Resource.Name;
                            "Gen. Prod. Posting Group" := Resource."Gen. Prod. Posting Group";
                            "VAT Prod. Posting Group" := Resource."VAT Prod. Posting Group";
                            "Unit of Measure Code" := Resource."Base Unit of Measure";
                            "Unit Price" := Resource."Unit Price";
                        end;
                    Type::"G/L Account":
                        begin
                            GLAccount.Get("No.");
                            GLAccount.CheckGLAcc();
                            GLAccount.TestField("Direct Posting", true);
                            Description := GLAccount.Name;
                            "Gen. Prod. Posting Group" := GLAccount."Gen. Bus. Posting Group";
                            "VAT Prod. Posting Group" := GLAccount."VAT Bus. Posting Group";
                        end;
                end;
            end;
        }
        field(5; Description; Text[50])
        {
            Caption = 'Description';
            DataClassification = AccountData;
        }
        //quantity, unit price dhe total price jane te nderlidhura
        //- Kur përdoruesi ndryshon ose sasinë ose çmimin për njësi, sistemi llogarit Çmimin Total.
        //Kur përdoruesi ndryshon Çmimin Total, sistemi llogarit çmimin për njësi.
        field(6; Quantity; Decimal)
        {
            Caption = 'Quantity';
            DataClassification = AccountData;
            DecimalPlaces = 0 : 5;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(7; "Unit Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Unit Price';
            DataClassification = AccountData;
            MinValue = 0;

            trigger OnValidate();
            begin
                "Total Price" := Round("Unit Price" * Quantity, 0.01);
            end;
        }
        field(8; "Total Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Total Price';
            DataClassification = AccountData;
            Editable = false;

            trigger OnValidate();
            begin
                if (Quantity <> 0) then
                    "Unit Price" := Round("Total Price" / Quantity, 0.01)
                else
                    "Unit Price" := 0;
            end;
        }
        field(9; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            DataClassification = AccountData;
            InitValue = true;
        }
        field(10; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            DataClassification = AccountData;
            TableRelation = Customer."No.";
        }
        field(11; "Unit of Measure Code"; Code[10])
        {
            Caption = 'Unit of Measure Code';
            DataClassification = AccountData;
            TableRelation = if (Type = const(Resource)) "Resource Unit of Measure".Code where("Resource No." = field("No."))
            else
            "Unit of Measure".Code;

            trigger OnValidate();
            begin
                case Type of
                    Type::Resource:
                        begin
                            Resource.Get("No.");
                            if "Unit of Measure Code" = '' then
                                "Unit of Measure Code" := Resource."Base Unit of Measure";
                            ResourceUofM.Get("No.", "Unit of Measure Code");
                            "Qty. per Unit of Measure" := ResourceUofM."Qty. per Unit of Measure";
                            "Total Price" := Round(Resource."Unit Price" * "Qty. per Unit of Measure");
                        end;
                    Type::"G/L Account":

                        "Qty. per Unit of Measure" := 1;
                end;
                if CurrFieldNo = FieldNo("Unit of Measure Code") then
                    Validate("Unit Price");
            end;
        }
        field(12; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(13; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = AccountData;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(14; "Qty. per Unit of Measure"; Decimal)
        {
            Caption = 'Qty. per Unit of Measure';
            DataClassification = AccountData;
        }
        field(15; Registered; Boolean)
        {
            Caption = 'Registered';
            DataClassification = AccountData;
            Editable = false;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
        }
    }

    trigger OnDelete();
    begin
        TestField(Registered, false);
    end;

    trigger OnInsert();
    begin
        SeminarRegistrationHeader.Get("Document No.");
    end;

    var
        SeminarRegistrationHeader: Record "CSD Seminar Reg. Header";
        GLAccount: Record "G/L Account";
        Resource: Record Resource;
        ResourceUofM: Record "Resource Unit of Measure";
}
