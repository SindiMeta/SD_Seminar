table 50102 "Nonconformance Setup"

{
    Caption = 'Nonconformance Setup';



    fields
    {

        field(1; "Primary Key"; Code[20])

        {

            Caption = 'Primary Key';
            DataClassification = ToBeClassified;

        }

        field(2; "Nonconformance Nos."; Code[20])

        {

            Caption = 'Nonconformance Nos.';

            TableRelation = "No. Series";

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