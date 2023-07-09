//stores the setup configuration for seminars in the system
table 50100 "CSD Seminar Setup"

// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.2: Task 1
{
    Caption = 'Seminar Setup';


    fields
    {
        field(10; "Primary Key"; Code[10])
        {
            Caption = 'Primary Key';

        }
        field(20; "Seminar Nos."; Code[20])
        {
            Caption = 'Seminar Nos.';
            //lidhet me no. series te seminar table 
            //ndodhet ne secilën master table që mban gjurmët e serive të numrave nga e cila është caktuar fusha No. .
            TableRelation = "No. Series";

        }
        field(30; "Seminar Registration Nos."; Code[20])
        {
            Caption = 'Seminar Registration Nos.';
            TableRelation = "No. Series";

        }
        field(40; "Posted Seminar Reg. Nos."; Code[20])
        {
            Caption = 'Posted Seminar Reg. Nos.';
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



}