report 50101 "SeminarRegParticipantList"
{
    Caption = 'Seminar Registration Participant List';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    RDLCLayout = './Layouts/SeminarRegParticipantList.rdl';
    DefaultLayout = RDLC;

    dataset
    {
        dataitem("CSD Seminar Reg. Header"; "CSD Seminar Reg. Header")
        {
            DataItemTableView = sorting("No.");
            RequestFilterFields = "No.", "Seminar No.";
            // column(ColumnName; SourceFieldName)
            // {

            // }
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
                DataItemTableView = sorting("Document No.", "Line No.");
                DataItemLink = "Document No." = field("No.");

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
                    // 
                }
            }
        }
    }
    labels
    {
        SeminarRegistrationHeaderCap = 'Seminar Registration List';
    }
    trigger OnPreReport()
    var
        myInt: Integer;
    begin
        "Company Information".get;
    end;

    // requestpage

    // {
    //     layout
    //     {
    //         area(Content)
    //         {
    //             group(GroupName)
    //             {
    //                 field(Name; SourceExpression)
    //                 {
    //                     ApplicationArea = All;

    //                 }
    //             }
    //         }
    //     }

    //     actions
    //     {
    //         area(processing)
    //         {
    //             action(ActionName)
    //             {
    //                 ApplicationArea = All;

    //             }
    //         }
    //     }
    // }

    // rendering
    // {
    //     layout(LayoutName)
    //     {
    //         Type = RDLC;
    //         LayoutFile = 'mylayout.rdl';
    //     }
    // }

}
