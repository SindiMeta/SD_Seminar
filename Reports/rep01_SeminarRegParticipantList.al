report 50101 SeminarRegParticipantList
{
    ApplicationArea = All;
    Caption = 'Seminar Registration Participant List';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/SeminarRegParticipantList.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("CSD Seminar Reg. Header"; "CSD Seminar Reg. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";
            column(No_; "No.")
            {
            }
            column(Seminar_No_; "Seminar No.")
            {
            }
            column(Seminar_Name; "Seminar Name")
            {
            }
            column(Starting_Date; "Starting Date")
            {
            }
            column(Duration; Duration)
            {
            }
            column(Instructor_Name; "Instructor Name")
            {
            }
            column(Room_Name; "Room Name")
            {
            }
            dataitem("CSD Seminar Registration Line"; "CSD Seminar Registration Line")
            {
                DataItemLink = "Document No." = field("No.");
                DataItemTableView = sorting("Document No.", "Line No.");

                column(Bill_to_Customer_No_; "Bill-to Customer No.")
                {
                }
                column(Participant_Contact_No_; "Participant Contact No.")
                {
                }
                column(Participant_Name; "Participant Name")
                {
                }
            }
            dataitem("Company Information"; "Company Information")
            {
                column(Company_Name; Name)
                {
                }
            }
        }
    }
    labels
    {
        SeminarRegistrationHeaderCap = 'Seminar Registration List';
    }
    trigger OnPreReport()
    begin
        "Company Information".Get();
    end;
}