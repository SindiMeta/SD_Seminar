table 50149 "Nonconf Quality Report"

{
    Caption = 'Nonconformance Quality Report';
    DrillDownPageId = "NonconfQuality Report List";
    LookupPageId = "NonconfQuality Report List";

    fields
    {
        field(1; "No"; Code[20])
        {
            Caption = 'No.';
            trigger OnValidate()

            begin

                IF No <> xRec.No THEN BEGIN

                    NonconfSetup.Get();

                    NoSeriesMgt.TestManual(NonconfSetup."Nonconformance Nos.");

                END;

            end;
        }
        field(2; "Type of nonconformity"; Enum "Type of nonconformity")
        {
            Caption = 'Type of nonconformity';

        }
        field(3; "Nonconformity Reason"; Enum "Nonconformity Reason")
        {
            Caption = 'Nonconformity Reason';

        }
        field(4; "CAQS Employee Number"; Text[50])
        {
            Caption = 'CAQS Employee Number';
            TableRelation = Employee;

            trigger OnValidate();
            begin
                CalcFields("CAQS Employee");
            end;
        }
        field(5; "CAQS Employee"; Text[250])
        {
            Caption = 'CAQS Employee';
            CalcFormula = lookup(Employee."Search Name" where("No." = field("CAQS Employee Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(6; "Posting Date"; DateTime)
        {
            Caption = 'Posting Date';
            Editable = false;


        }
        field(7; "Item No"; Code[20])
        {
            Caption = 'Item No';
            TableRelation = Item;

            trigger OnValidate();
            begin
                CalcFields(Description)
            end;
        }
        field(8; "Description"; Text[100])
        {
            Caption = 'Description';
            CalcFormula = lookup(Item.Description where("No." = field("Item No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Quantity"; Text[20])
        {
            Caption = 'Quantity';
        }
        field(30; "Unit of Measure"; Text[50])
        {
            Caption = 'Unit of Measure';
            TableRelation = "Unit of Measure";
        }
        field(10; "Lot"; Text[30])
        {
            Caption = 'Lot';
        }
        field(11; "Nonconformity Description"; Text[600])
        {
            Caption = 'Nonconformity Description';
        }
        field(12; "Proposal for corr/prev action"; Boolean)
        {
            Caption = 'Proposal for corrective or preventive action';
            DataClassification = ToBeClassified;


        }
        field(13; "Comments"; Text[600])
        {
            Caption = 'Comments';
        }
        field(14; "Penalty"; Boolean)
        {
            Caption = 'Penalty';
        }
        field(15; "Actions taken"; Text[600])
        {
            Caption = 'Actions taken';
        }
        field(16; "Status"; Enum Status)
        {
            Caption = 'Status';


            trigger OnValidate();
            begin
                if Status = Status::Closed then
                    "Closing Nonconformity Date" := CurrentDateTime;




            end;
        }
        field(17; "Closing Nonconformity Date"; DateTime)
        {
            Caption = 'Closing Nonconformity Date';
            Editable = false;

        }
        field(40; "No. Printed"; Integer)
        {
            Caption = 'No. Printed';
            Editable = false;
        }


    }

    keys
    {
        key(Key1; No)
        {
            Clustered = true;
        }
    }

    var
        ResponsibleEmployeeLine: Record "Responsible Employee Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        NonconfSetup: Record "Nonconformance Setup";
        NoSeriesG: Code[20];



    trigger OnInsert()

    begin

        IF No = '' THEN BEGIN

            NonconfSetup.GET;

            NonconfSetup.TESTFIELD("Nonconformance Nos.");

            NoSeriesMgt.InitSeries(NonconfSetup."Nonconformance Nos.", '', 0D, No, NoSeriesG);

        END;

    end;

    trigger OnModify()
    begin
        "Posting Date" := CurrentDateTime;
    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin
        "Posting Date" := CurrentDateTime;
    end;


}