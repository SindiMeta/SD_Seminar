table 50141 "“CSD My Seminars"
{
    DataClassification = ToBeClassified;
    Caption = 'My Seminars';

    fields
    {
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = ToBeClassified;


        }
        field(20; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = User;
            DataClassification = ToBeClassified;

        }

    }

    keys
    {
        key(Pk; "User ID", "Seminar No.")
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