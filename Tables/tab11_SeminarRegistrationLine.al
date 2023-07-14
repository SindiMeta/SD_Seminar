//the information about the participants in the seminar.
table 50111 "CSD Seminar Registration Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//   Chapter 6 - Lab 1-5
//     - Created new table
{
    Caption = 'Seminar Registration Line';

    fields
    {
        field(1; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "CSD Seminar Reg. Header";
        }
        field(2; "Line No."; Integer)
        {
            Caption = 'Line No.';

        }
        field(3; "Bill-to Customer No."; Code[20])
        {
            Caption = 'Bill-to Customer No.';
            TableRelation = Customer;

            //makes sure that you cannot change the customer for the registered line.
            trigger OnValidate();
            begin
                if "Bill-to Customer No." <> xRec."Bill-to Customer No." then
                    if Registered then
                        Error(RegisteredErrorTxt,
                          FieldCaption("Bill-to Customer No."),
                          FieldCaption(Registered),
                          Registered);
            end;
        }
        field(4; "Participant Contact No."; Code[20])
        {
            Caption = 'Participant Contact No.';
            TableRelation = Contact;
            // The OnValidate trigger in the Participant Contact No. field makes sure that the contact selected by the user is related 
            // to the customer that is specified in the Bill-to Customer No. field. It filters the information in the 
            // Contact Business Relation table to determine whether the contact that the user has specified is related to 
            // the customer that is referenced in the Bill-to Customer No. field. If the contact is not related to the customer, 
            // an error that describes the problem is thrown. The trigger also calls the CalcField function to retrieve the 
            // Participant Name field from the Contact table. 
            // The Participant Name field is a FlowField that uses the Lookup method to dynamically calculate the value of the field.
            trigger OnLookup();
            begin
                ContactBusinessRelation.Reset();
                ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                if ContactBusinessRelation.FindFirst() then begin
                    Contact.SetRange("Company No.", ContactBusinessRelation."Contact No.");
                    if Page.RunModal(Page::"Contact List", Contact) = "Action"::LookupOK then
                        "Participant Contact No." := Contact."No.";
                end;

                CalcFields("Participant Name");
            end;
            
            trigger OnValidate();
            begin
                if ("Bill-to Customer No." <> '') and
                   ("Participant Contact No." <> '')
                then begin
                    Contact.Get("Participant Contact No.");
                    ContactBusinessRelation.Reset();
                    ContactBusinessRelation.SetCurrentKey("Link to Table", "No.");
                    ContactBusinessRelation.SetRange("Link to Table", ContactBusinessRelation."Link to Table"::Customer);
                    ContactBusinessRelation.SetRange("No.", "Bill-to Customer No.");
                    if ContactBusinessRelation.FindFirst() then
                        if ContactBusinessRelation."Contact No." <> Contact."Company No." then
                            Error(WrongContactErrorTxt, Contact."No.", Contact.Name, "Bill-to Customer No.");
                end;
            end;
        }
        field(5; "Participant Name"; Text[100])
        {
            CalcFormula = lookup(Contact.Name where("No." = field("Participant Contact No.")));
            Caption = 'Participant Name';
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Registration Date"; Date)
        {
            Caption = 'Registration Date';
            Editable = false;
        }
        field(7; "To Invoice"; Boolean)
        {
            Caption = 'To Invoice';
            InitValue = true;
        }
        field(8; Participated; Boolean)
        {
            Caption = 'Participated';
        }
        field(9; "Confirmation Date"; Date)
        {
            Caption = 'Confirmation Date';
            Editable = false;
        }
        field(10; "Seminar Price"; Decimal)
        {
            AutoFormatType = 2;
            Caption = 'Seminar Price';

            trigger OnValidate();
            begin
                Validate("Line Discount %");
            end;
        }
        field(11; "Line Discount %"; Decimal)
        {
            Caption = 'Line Discount %';
            DecimalPlaces = 0 : 5;
            MaxValue = 100;
            MinValue = 0;

            trigger OnValidate();
            begin
                if "Seminar Price" = 0 then
                    "Line Discount Amount" := 0
                else begin
                    //konfigurimi i librit kryesor
                    GLSetup.Get();
                    "Line Discount Amount" := Round("Line Discount %" * "Seminar Price" * 0.01, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount();
            end;
        }
        field(12; "Line Discount Amount"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Line Discount Amount';

            trigger OnValidate();
            begin
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else begin
                    GLSetup.Get();
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
                end;
                UpdateAmount();
            end;
        }
        field(13; Amount; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Amount';

            trigger OnValidate();
            begin
                TestField("Bill-to Customer No.");
                TestField("Seminar Price");
                GLSetup.Get();
                Amount := Round(Amount, GLSetup."Amount Rounding Precision");
                "Line Discount Amount" := "Seminar Price" - Amount;
                if "Seminar Price" = 0 then
                    "Line Discount %" := 0
                else
                    "Line Discount %" := Round("Line Discount Amount" / "Seminar Price" * 100, GLSetup."Amount Rounding Precision");
            end;
        }
        field(14; Registered; Boolean)
        {
            Caption = 'Registered';
            Editable = true;
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
        GetSeminarRegHeader();
        "Registration Date" := WorkDate();
        "Seminar Price" := SeminarRegHeader."Seminar Price";
        Amount := SeminarRegHeader."Seminar Price";
    end;

    var
        Contact: Record Contact;
        ContactBusinessRelation: Record "Contact Business Relation";
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        GLSetup: Record "General Ledger Setup";
        RegisteredErrorTxt: Label 'You cannot change the %1, because %2 is %3.';
        WrongContactErrorTxt: Label 'Contact %1 %2 is related to a different company than customer %3.';

    //mban vleren te perditesuar
    local procedure GetSeminarRegHeader();
    begin
        if SeminarRegHeader."No." <> "Document No." then
            SeminarRegHeader.Get("Document No.");
    end;

    local procedure CalculateAmount();
    begin
        Amount := Round(("Seminar Price" / 100) * (100 - "Line Discount %"));
    end;

    local procedure UpdateAmount();
    begin
        GLSetup.Get();
        Amount := Round("Seminar Price" - "Line Discount Amount", GLSetup."Amount Rounding Precision");
    end;
}
