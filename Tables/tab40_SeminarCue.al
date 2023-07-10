table 50140 "CSD Seminar Cue"
{
    //Contains the flow fields for the cues on the Activities page part of the Role Center page.
    Caption = 'Seminar Cue';
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';
            DataClassification = ToBeClassified;
        }
        field(20; Planned; Integer)
        {
            CalcFormula = count("CSD Seminar Reg. Header" where(Status = const(Planning)));
            Caption = 'Planned';
            FieldClass = FlowField;
        }
        field(30; Registered; Integer)
        {
            CalcFormula = count("CSD Seminar Reg. Header" where(Status = const(Registration)));
            Caption = 'Registered';
            FieldClass = FlowField;
        }
        field(40; Closed; Integer)
        {
            CalcFormula = count("CSD Seminar Reg. Header" where(Status = const(Closed)));
            Caption = 'Closed';
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    trigger OnInsert()
    begin
    end;

    trigger OnModify()
    begin
    end;

    trigger OnDelete()
    begin
    end;

    trigger OnRename()
    begin
    end;
}