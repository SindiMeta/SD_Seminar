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
        field(20; "Planned"; Integer)
        {
            Caption = 'Planned';
            FieldClass = FlowField;
            CalcFormula = count("CSD Seminar Reg. Header" where(Status = const(Planning)));



        }
        field(30; "Registered"; Integer)
        {
            Caption = 'Registered';
            FieldClass = FlowField;
            CalcFormula = Count("CSD Seminar Reg. Header" where(Status = const(Registration)));


        }
        field(40; "Closed"; Integer)
        {
            Caption = 'Closed';
            FieldClass = FlowField;
            CalcFormula = Count("CSD Seminar Reg. Header" where(Status = const(Closed)));

        }
    }

    keys
    {
        key(PK; "Primary Key")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

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