table 50141 "“CSD My Seminars"
{
    //Contains the list of seminars that each user has included in the My Seminars list.
    DataClassification = ToBeClassified;
    Caption = 'My Seminars';

    fields
    {
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
            TableRelation = User;
            DataClassification = ToBeClassified;
            ;


        }
        field(20; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            TableRelation = "CSD Seminar";
            DataClassification = ToBeClassified;
            ;

        }

    }

    keys
    {
        key(Pk; "User ID", "Seminar No.")
        {
            Clustered = true;
        }
    }
}