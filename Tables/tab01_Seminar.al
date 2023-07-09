table 50101 "CSD Seminar"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.2: Task 2
{
    Caption = 'Seminar';
    LookupPageId = "CSD Seminar List";
    DrillDownPageId = "CSD Seminar List";

    fields
    {
        field(10; "No."; Code[20])
        {
            Caption = 'No';

            //kur përdoruesi ndryshon vlerën No., validoni që seria e numrave që përdoret për caktimin e numrit lejon numra manualë. 
            //Pastaj vendoseni fushën Nr. Series bosh.
            trigger OnValidate();
            begin
                if "No." <> xRec."No." then begin
                    SeminarSetup.GET;
                    NoSeriesMgt.TestManual(SeminarSetup."Seminar Nos.");
                    "No. Series" := '';
                end;
            end;

        }

        field(20; "Name"; Text[50])
        {
            Caption = 'Name';
            //vendosni kodin që përcakton Search Name field nëse ishte e barabartë me shkronjat e mëdha të vlerës së mëparshme të Name fiel.
            trigger OnValidate();
            begin
                if ("Search Name" = UpperCase(xRec.Name)) or
                ("Search Name" = '') then
                    "Search Name" := Name;
            end;


        }
        field(30; "Seminar Duration"; Decimal)
        {
            Caption = 'Seminar Duration';
            DecimalPlaces = 0 : 1;


        }
        field(40; "Minimum Participants"; Integer)
        {
            Caption = 'Minimum Participants';


        }
        field(50; "Maximum Participants"; Integer)
        {
            Caption = 'Maximum Participants';


        }
        field(60; "Search Name"; Code[50])
        {
            Caption = 'Search Name';


        }
        field(70; "Blocked"; Boolean)
        {
            Caption = 'Blocked';


        }
        field(80; "Last Date Modified"; Date)
        {
            Caption = 'Last Date Modified';
            Editable = false;


        }
        field(90; "Comment"; Boolean)
        {
            Caption = 'Comment';
            Editable = false;
            FieldClass = FlowField;
            CalcFormula = exist("CSD Seminar Comment Line"
            where("Table Name" = const(Seminar),
            "No." = Field("No.")));


        }
        field(100; "Seminar Price"; Decimal)
        {
            Caption = 'Seminar Price';
            //sigurohet që vlera të jetë gjithmonë e formatuar si shumë
            AutoFormatType = 1;



        }
        field(110; "Gen. Prod. Posting Group"; Code[10])
        {
            Caption = 'General Production Posting Group';
            TableRelation = "Gen. Product Posting Group";

            //nëse funksioni ValidateVatProdPostingGroup i tabelës Gen.ProductPostingGroup kthen true, 
            //vendosni VATProd.PostingGroup në vlerën e fushës Def.VATProd.PostingGroup nga tabela Gen.ProductPosting Group
            trigger OnValidate();
            begin
                if (xRec."Gen. Prod. Posting Group" <>
                "Gen. Prod. Posting Group") then begin
                    if GenProdPostingGroup.ValidateVatProdPostingGroup
                    (GenProdPostingGroup, "Gen. Prod. Posting Group") then
                        Validate("VAT Prod. Posting Group",
                        GenProdPostingGroup."Def. VAT Prod. Posting Group");
                end;
            end;
        }
        field(120; "VAT Prod. Posting Group"; Code[10])
        {
            Caption = 'VAT Production Posting Group';
            TableRelation = "VAT Product Posting Group";

        }
        field(130; "No. Series"; Code[10])
        {
            Editable = false;
            Caption = 'No. Series';
            TableRelation = "No. Series";

        }


    }

    keys
    {
        key(PK; "No.")
        {
            Clustered = true;
        }
        key(key1; "Search Name")
        {

        }
    }

    trigger OnInsert()

    begin
        //nese nuk ka nje vlere ne No. caktoni vleren tjeter nga seria e numrave e specifikuar ne Seminar Nos. ne Seminar Table
        if "No." = '' then begin
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            NoSeriesMgt.InitSeries(SeminarSetup."Seminar Nos.", xRec."No. Series", 0D, "No.", "No. Series");
        end;
    end;


    trigger OnModify()

    begin
        "Last Date Modified" := Today;
    end;


    trigger OnRename()

    begin
        "Last Date Modified" := Today;
    end;


    trigger OnDelete();
    begin
        //për të fshirë çdo rresht komenti për regjistrimin e seminarit që po fshihet.
        CommentLine.Reset;
        CommentLine.SetRange("Table Name", CommentLine."Table Name"::Seminar);
        CommentLine.SetRange("No.", "No.");
        CommentLine.DeleteAll;
    end;





    var
        SeminarSetup: Record "CSD Seminar Setup";
        CommentLine: Record "CSD Seminar Comment Line";
        Seminars: Record "CSD Seminar";

        GenProdPostingGroup: Record "Gen. Product Posting Group";
        NoSeriesMgt: Codeunit NoSeriesManagement;

    procedure AssistEdit(): Boolean;

    begin
        // that makes sure there is a value in the Seminar Nos. field in the Seminar Setup table, 
        //and then calls the SelectSeries function in the NoSeriesManagement codeunit to check the series number. 
        //If this function returns True, call the SetSeries function in the NoSeriesManagement codeunit to set the No. field, 
        //and then return True.

        Seminars.Reset();
        if Seminars.FindFirst() then begin
            //with Seminars do begin
            Seminars := Rec;
            SeminarSetup.get;
            SeminarSetup.TestField("Seminar Nos.");
            if NoSeriesMgt.SelectSeries(SeminarSetup."Seminar Nos."
            , xRec."No. Series", Seminars."No. Series") then begin
                NoSeriesMgt.SetSeries(Seminars."No.");
                Rec := Seminars;
                exit(true);
            end;
        end;
    end;

}