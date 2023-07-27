table 50107 "Nonconf Report Selections"
{
    Caption = 'Noncoformance Report Selections';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; Usage; Option)
        {
            Caption = 'Usage';
            OptionCaption = 'Registration';
            OptionMembers = Registration;
        }
        field(2; Sequence; Code[10])
        {
            Caption = 'Sequence';
            Numeric = true;
        }
        field(3; "Report ID"; Integer)
        {
            Caption = 'Report ID';
            TableRelation = AllObjWithCaption."Object ID" where("Object Type" = const(Report));

            trigger OnValidate();
            begin
                CalcFields("Report Name");
            end;
        }
        field(4; "Report Name"; Text[250])
        {
            CalcFormula = lookup(AllObjWithCaption."Object Caption" where("Object Type" = const(Report),
                                                                           "Object ID" = field("Report ID")));
            Caption = 'Report Name';
            FieldClass = FlowField;
        }
        field(5; "Type of nonconformity"; Enum "Type of nonconformity")
        {
            Caption = 'Type of nonconformity';

        }
        field(6; "Nonconformity Reason"; Enum "Nonconformity Reason")
        {
            Caption = 'Nonconformity Reason';

        }
        field(7; "CAQS Employee Number"; Text[50])
        {
            Caption = 'CAQS Employee Number';
            TableRelation = Employee;

            trigger OnValidate();
            begin
                CalcFields("CAQS Employee");
            end;
        }
        field(8; "CAQS Employee"; Text[250])
        {
            Caption = 'CAQS Employee';
            CalcFormula = lookup(Employee."Search Name" where("No." = field("CAQS Employee Number")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(9; "Posting Date"; Date)
        {
            Caption = 'Posting Date';
            Editable = false;


        }
        field(10; "Item No"; Code[20])
        {
            Caption = 'Item No';
            TableRelation = Item;

            trigger OnValidate();
            begin
                CalcFields(Description)
            end;
        }
        field(11; "Description"; Text[100])
        {
            Caption = 'Description';
            CalcFormula = lookup(Item.Description where("No." = field("Item No")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(12; "Quantity"; Text[20])
        {
            Caption = 'Quantity';
        }
        field(13; "Lot"; Text[30])
        {
            Caption = 'Lot';
        }
        field(14; "Nonconformity Description"; Text[600])
        {
            Caption = 'Nonconformity Description';
        }
        field(15; "Proposal for corr/prev action"; Boolean)
        {
            Caption = 'Proposal for corrective or preventive anction';
            DataClassification = ToBeClassified;


        }
        field(16; "Comments"; Text[600])
        {
            Caption = 'Comments';
        }
        field(17; "Penalty"; Boolean)
        {
            Caption = 'Penalty';
        }
        field(18; "Actions taken"; Text[600])
        {
            Caption = 'Actions taken';
        }
        field(19; "Status"; Enum Status)
        {
            Caption = 'Status';

            trigger OnValidate();
            begin
                TestField(Status, Status::Closed);
                "Closing Nonconformity Date" := Today;

            end;
        }
        field(20; "Closing Nonconformity Date"; Date)
        {
            Caption = 'Closing Nonconformity Date';
            Editable = false;

        }


    }

    keys
    {
        key(Key1; Usage, Sequence)
        {
            Clustered = true;
        }
    }

    var
        ReportSelection2: Record "Nonconf Report Selections";

    procedure NewRecord();
    begin
        ReportSelection2.SetRange(Usage, Usage);
        if ReportSelection2.Find('+') and (ReportSelection2.Sequence <> '') then
            Sequence := IncStr(ReportSelection2.Sequence)
        else
            Sequence := '1';
    end;

    procedure PrintReportSelection(inUsage: Integer; NonConf: Record "Nonconf Quality Report");
    var
        SemReportSelection: Record "CSD Seminar Report Selections";
    begin
        SemReportSelection.SetRange(Usage, inUsage);
        if SemReportSelection.FindFirst() then
            Report.Run(SemReportSelection."Report ID", true, false, NonConf);
    end;
}
