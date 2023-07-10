//header information for seminar registrations This includes information about the seminar, the room, and the instructor.

table 50110 "CSD Seminar Reg. Header"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//   Chapter 6 - Lab 1-3 & Lab 1-4
//     - Created new table
// Chapter 9 - Lab 1-1
// - Added new field "No. Printed

{
    Caption = 'Seminar Registration Header';
    DrillDownPageId = "CSD Seminar Registration List";
    LookupPageId = "CSD Seminar Registration List";

    fields
    {
        field(1; "No."; Code[20])

        {
            Caption = 'No';
            DataClassification = AccountData;
            //Ai kontrollon nëse seria e caktuar në fushë lejon hyrjen manuale dhe rivendos fushën "Nr. Seria" nëse lejohet futja manuale.
            trigger OnValidate()
            begin
                //kontrollon nese e para ndryshe nga vlera e vjeter e ruajtur ne rekord
                if "No." <> xRec."No." then begin
                    //merr rekordin nga CSD Seminar Setup dhe e ruan ne variabel
                    SeminarSetup.Get();
                    //nese seria e nr ne Seminar Nos. field e rekordit te seminar setup lejon futjen manuale te nr
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Registration Nos.");
                    "No. Series" := '';
                end;
            end;
        }
        field(2; "Starting Date"; Date)
        {
            Caption = 'Starting Date';
            DataClassification = AccountData;
            //Nëse data e fillimit ndryshohet, ajo kontrollon dhe zbaton që statusi të jetë vendosur në "Planifikimi"
            trigger OnValidate();
            begin
                if "Starting Date" <> xRec."Starting Date" then
                    TestField(Status, Status::Planning);
            end;
        }
        field(3; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = AccountData;
            TableRelation = "CSD Seminar";
            //te kryeje validime dhe te plotesoje fushat kur modifikohet seminar no.
            //to understand how it makes sure that you cannot change the Seminar No. if there are participants in the seminar.
            //??????????????????????????????
            //??????????????????????????????
            trigger OnValidate();
            begin
                if "Seminar No." <> xRec."Seminar No." then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, true);
                    if not SeminarRegLine.IsEmpty then
                        Error(
                          Text002,
                          FieldCaption("Seminar No."),
                          SeminarRegLine.TableCaption,
                          SeminarRegLine.FieldCaption(Registered),
                          true);

                    Seminar.Get("Seminar No.");
                    Seminar.TestField(Blocked, false);
                    Seminar.TestField("Gen. Prod. Posting Group");
                    Seminar.TestField("VAT Prod. Posting Group");
                    "Seminar Name" := Seminar.Name;
                    Duration := Seminar."Seminar Duration";
                    "Seminar Price" := Seminar."Seminar Price";
                    "Gen. Prod. Posting Group" := Seminar."Gen. Prod. Posting Group";
                    "VAT Prod. Posting Group" := Seminar."VAT Prod. Posting Group";
                    "Minimum Participants" := Seminar."Minimum Participants";
                    "Maximum Participants" := Seminar."Maximum Participants";
                end;
            end;
        }
        field(4; "Seminar Name"; Text[50])
        {
            Caption = 'Seminar Name';
            DataClassification = AccountData;
        }
        // field(5; "Instructor Code"; Code[10])
        // {
        //     TableRelation = Resource where (Type = const (Person));

        //     trigger OnValidate();
        //     begin
        //         CalcFields("Instructor Name");
        //     end;
        // }
        field(5; "Instructor Resource No."; Code[20])
        {
            Caption = 'Instructor Resource No.';
            DataClassification = AccountData;
            TableRelation = Resource where(Type = const(Person));

            trigger OnValidate();
            begin
                CalcFields("Instructor Name");
            end;
        }
        field(6; "Instructor Name"; Text[100])
        {
            CalcFormula = lookup(Resource.Name where("No." = field("Instructor Resource No."), Type = const(Person)));
            Caption = 'Instructor Name';
            Editable = false;
            //e nxjerre vleren ne menyre dinamike
            FieldClass = FlowField;
        }
        field(7; Status; Option)
        {
            Caption = 'Status';
            DataClassification = AccountData;
            OptionCaption = 'Planning,Registration,Closed,Canceled';
            OptionMembers = Planning,Registration,Closed,Canceled;
        }
        field(8; Duration; Decimal)
        {
            Caption = 'Duration';
            DataClassification = AccountData;
            DecimalPlaces = 0 : 1;
        }
        field(9; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';
            DataClassification = AccountData;
        }
        field(10; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';
            DataClassification = AccountData;
        }
        //field(11;"Room Code";Code[10])
        field(11; "Room Resource No."; Code[20])
        {
            Caption = 'Room Resource No.';
            DataClassification = AccountData;
            TableRelation = Resource where(Type = const(Machine));

            trigger OnValidate();
            begin
                if "Room Resource No." = '' then begin
                    "Room Name" := '';
                    "Room Address" := '';
                    "Room Address 2" := '';
                    "Room Post Code" := '';
                    "Room City" := '';
                    "Room County" := '';
                    "Room Country/Reg. Code" := '';
                end else begin
                    SeminarRoom.Get("Room Resource No.");
                    "Room Name" := SeminarRoom.Name;
                    "Room Address" := SeminarRoom.Address;
                    "Room Address 2" := SeminarRoom."Address 2";
                    "Room Post Code" := SeminarRoom."Post Code";
                    "Room City" := SeminarRoom.City;
                    "Room County" := SeminarRoom.County;
                    "Room Country/Reg. Code" := SeminarRoom."Country/Region Code";
                    //checks whether the seminar can register more participants if the room has more capacity than the maximum that is defined by the seminar master record.
                    if (CurrFieldNo <> 0) then
                        if (SeminarRoom."CSD Maximum Participants" <> 0) and
                           (SeminarRoom."CSD Maximum Participants" < "Maximum Participants")
                        then
                            if Confirm(Text004, true,
                                 "Maximum Participants",
                                 SeminarRoom."CSD Maximum Participants",
                                 FieldCaption("Maximum Participants"),
                                 "Maximum Participants",
                                 SeminarRoom."CSD Maximum Participants")
                            then
                                "Maximum Participants" := SeminarRoom."CSD Maximum Participants";
                end;
            end;
        }
        field(12; "Room Name"; Text[30])
        {
            Caption = 'Room Name';
            DataClassification = AccountData;
        }
        field(13; "Room Address"; Text[30])
        {
            Caption = 'Room Address';
            DataClassification = AccountData;
        }
        field(14; "Room Address 2"; Text[30])
        {
            Caption = 'Room Address 2';
            DataClassification = AccountData;
        }
        field(15; "Room Post Code"; Code[20])
        {
            Caption = 'Room Post Code';
            DataClassification = AccountData;
            TableRelation = "Post Code".Code;
            ValidateTableRelation = false;

            trigger OnValidate();
            begin
                PostCode.ValidatePostCode("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code",
                (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(16; "Room City"; Text[30])
        {
            Caption = 'Room City';
            DataClassification = AccountData;

            trigger OnValidate();
            begin
                PostCode.ValidateCity("Room City", "Room Post Code", "Room County", "Room Country/Reg. Code", (CurrFieldNo <> 0) and GuiAllowed);
            end;
        }
        field(17; "Room Country/Reg. Code"; Code[10])
        {
            Caption = 'Room Country/Reg';
            DataClassification = AccountData;
            TableRelation = "Country/Region";
        }
        field(18; "Room County"; Text[30])
        {
            Caption = 'Room County';
            DataClassification = AccountData;
        }
        field(19; "Seminar Price"; Decimal)
        {
            AutoFormatType = 1;
            Caption = 'Seminar Price';
            //DataClassification = AccountData;

            trigger OnValidate();
            begin
                if ("Seminar Price" <> xRec."Seminar Price") and
                   (Status <> Status::Canceled)
                then begin
                    SeminarRegLine.Reset();
                    SeminarRegLine.SetRange("Document No.", "No.");
                    SeminarRegLine.SetRange(Registered, false);
                    if SeminarRegLine.FindSet(false, false) then
                        if Confirm(Text005, false,
                             FieldCaption("Seminar Price"),
                             SeminarRegLine.TableCaption)
                        then begin
                            repeat
                                SeminarRegLine.Validate("Seminar Price", "Seminar Price");
                                SeminarRegLine.Modify();
                            until SeminarRegLine.Next() = 0;
                            Modify();
                        end;
                end;
            end;
        }
        field(20; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'Gen. Prod. Posting Group';
            DataClassification = AccountData;
            TableRelation = "Gen. Product Posting Group".Code;
        }
        field(21; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Prod. Posting Group';
            DataClassification = AccountData;
            TableRelation = "VAT Product Posting Group".Code;
        }
        field(22; Comment; Boolean)
        {
            CalcFormula = exist("CSD Seminar Comment Line" where("Table Name" = const("Seminar Registration"),
            "No." = field("No.")));
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
        }
        field(23; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            DataClassification = AccountData;
        }
        field(24; "Document Date"; Date)
        {
            Caption = 'Document Date';
            DataClassification = AccountData;
        }
        field(25; "Reason Code"; Code[10])
        {
            Caption = 'Reason Code';
            DataClassification = AccountData;
            TableRelation = "Reason Code".Code;
        }
        field(26; "No. Series"; Code[10])
        {
            Caption = 'No. Series';
            DataClassification = AccountData;
            Editable = false;
            TableRelation = "No. Series".Code;
        }
        field(27; "Posting No. Series"; Code[10])
        {
            Caption = 'Posting No. Series';
            DataClassification = AccountData;
            TableRelation = "No. Series".Code;

            trigger OnLookup();
            begin
                SeminarRegHeader.Reset();
                if SeminarRegHeader.FindFirst() then begin
                    //with SeminarRegHeader do begin
                    SeminarRegHeader := Rec;
                    SeminarSetup.Get();
                    SeminarSetup.TestField("Seminar Registration Nos.");
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                    if NoSeriesMgt.LookupSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series")
                    then
                        Validate("Posting No. Series");
                    Rec := SeminarRegHeader;
                end;
            end;

            trigger OnValidate();
            begin
                if "Posting No. Series" <> '' then begin
                    SeminarSetup.Get();
                    SeminarSetup.TestField("Seminar Registration Nos.");
                    SeminarSetup.TestField("Posted Seminar Reg. Nos.");
                    NoSeriesMgt.TestSeries(SeminarSetup."Posted Seminar Reg. Nos.", "Posting No. Series");
                end;
                TestField("Posting No.", '');
            end;
        }
        field(28; "Posting No."; Code[20])
        {
            Caption = 'Posting No.';
            DataClassification = AccountData;
        }
        field(40; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            DataClassification = AccountData;
            Editable = false;
        }
    }

    keys
    {
        key(PK; "No.")
        {
        }
        key(Key2; "Room Resource No.")
        {
            //duke mundësuar llogaritje ose operacione efikase që përfshijnë kohëzgjatjen e seminareve të lidhura
            //me një burim të caktuar dhome.
            SumIndexFields = Duration;
        }
    }

    var
        Seminar: Record "CSD Seminar";
        SeminarCharge: Record "CSD Seminar Charge";
        SeminarCommentLine: Record "CSD Seminar Comment Line";
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        SeminarRegLine: Record "CSD Seminar Registration Line";
        SeminarSetup: Record "CSD Seminar Setup";
        PostCode: Record "Post Code";
        SeminarRoom: Record Resource;
        NoSeriesMgt: Codeunit NoSeriesManagement;
        Text004: Label 'This Seminar is for %1 participants. \The selected Room has a maximum of %2 participants \Do you want to change %3 for the Seminar from %4 to %5?';
        Text005: Label 'Should the new %1 be copied to all %2 that are not yet invoiced?';
        Text006: Label 'You cannot delete the Seminar Registration, because there is at least one %1.';
        Text001: TextConst ENU = 'You cannot delete the Seminar Registration, because there is at least one %1 where %2=%3.';
        Text002: TextConst ENU = 'You cannot change the %1, because there is at least one %2 with %3=%4.';

    //Në përgjithësi, ky aktivizues siguron që kur një rekord fshihet, ai kryen vërtetimet e nevojshme dhe fshin të dhënat shoqëruese në tabela të tjera
    //such as registered seminar lines, seminar charges, and seminar comment lines
    trigger OnDelete();
    begin
        if (CurrFieldNo > 0) then
            TestField(Status, Status::Canceled);
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", "No.");
        SeminarRegLine.SetRange(Registered, true);
        if SeminarRegLine.Find('-') then
            Error(
              Text001,
              SeminarRegLine.TableCaption,
              SeminarRegLine.FieldCaption(Registered),
              true);
        SeminarRegLine.SetRange(Registered);
        SeminarRegLine.DeleteAll(true);

        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", "No.");
        if not SeminarCharge.IsEmpty then
            Error(Text006, SeminarCharge.TableCaption);

        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Table Name", SeminarCommentLine."Table Name"::"Seminar Registration");
        SeminarCommentLine.SetRange("No.", "No.");
        SeminarCommentLine.DeleteAll();
    end;
    //executed when insert new values
    //Overall, the trigger initializes fields,
    //retrieves data from related tables, sets default values, and includes a custom modification specific to Lab 8 1-1 exercise.
    trigger OnInsert();
    begin
        if "No." = '' then begin
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Registration Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
        InitRecord();

        // >> Lab 8 1-1
        if GetFilter("Seminar No.") <> '' then
            if GetRangeMin("Seminar No.") = GetRangeMax("Seminar No.")
            then
                Validate("Seminar No.", GetRangeMin("Seminar No."));
        // << Lab 8 1-1
    end;
    //In summary, the InitRecord procedure sets default values for the "Posting Date" and "Document Date" fields, retrieves
    //the Seminar Setup record, and sets the default series for a specific series code using the value from the Seminar Setup record.
    local procedure InitRecord()

    begin

        if "Posting Date" = 0D then
            "Posting Date" := WorkDate();
        "Document Date" := WorkDate();
        SeminarSetup.Get();
        NoSeriesMgt.SetDefaultSeries("Posting No. Series",
        SeminarSetup."Posted Seminar Reg. Nos.");
    end;

    procedure AssistEdit(OldSeminarRegHeader: Record "CSD Seminar Reg. Header"): Boolean;
    begin
        SeminarRegHeader.Reset();
        if SeminarRegHeader.FindFirst() then begin
            ;
            //with SeminarRegHeader do begin
            SeminarRegHeader := Rec;
            SeminarSetup.Get();
            SeminarSetup.TestField("Seminar Registration Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Registration Nos.", OldSeminarRegHeader."No. Series", "No. Series") then begin
                SeminarSetup.Get();
                SeminarSetup.TestField("Seminar Registration Nos.");
                NoSeriesMgt.SetSeries("No.");
                Rec := SeminarRegHeader;
                exit(true);
            end;
        end;
    end;
    //end;
}
