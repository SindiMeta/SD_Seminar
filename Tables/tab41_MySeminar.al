table 50141 "“CSD My Seminars"
{
    Caption = 'My Seminars';
    //Contains the list of seminars that each user has included in the My Seminars list.
    DataClassification = ToBeClassified;

    fields
    {
        field(10; "User ID"; Code[50])
        {
            Caption = 'User ID';
            DataClassification = ToBeClassified;
            TableRelation = User;
            ;
        }
        field(20; "Seminar No."; Code[20])
        {
            Caption = 'Seminar No.';
            DataClassification = ToBeClassified;
            TableRelation = "CSD Seminar";
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