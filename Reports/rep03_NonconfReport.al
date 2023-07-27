report 50130 NonconfReport
{
    ApplicationArea = All;
    Caption = 'NonconfReport';
    DefaultLayout = RDLC;
    RDLCLayout = './Layouts/NonconfReport.rdl';
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Nonconf Quality Report"; "Nonconf Quality Report")
        {
            DataItemTableView = sorting(no);
            RequestFilterFields = No;
            column(No; No)
            {
            }
            column(Picture; CompanyInfor.Picture)
            {

            }
            column(PhoneNo; CompanyInfor."Phone No.") { }
            column(EMail; CompanyInfor."E-Mail") { }

            column(Type_of_nonconformity; "Type of nonconformity")
            {
            }
            column(CAQS_Employee; "CAQS Employee")
            {
            }
            column(Nonconformity_Reason; "Nonconformity Reason")
            {
            }
            column(Posting_Date; "Posting Date")
            {
            }

            column(Item_No; "Item No")
            {
            }
            column(Quantity; Quantity)
            {
            }
            column(Unit_of_Measure; "Unit of Measure")
            {
            }
            column(Nonconformity_Description; "Nonconformity Description")
            {
            }
            column(Description; Description)
            {
            }
            column(Lot; Lot)
            {
            }
            column(Proposal_for_corr_prev_action; "Proposal for corr/prev action")
            {
            }
            column(Comments; Comments)
            {
            }
            column(Penalty; Penalty)
            {
            }
            column(Actions_taken; "Actions taken")
            {
            }
            column(Closing_Nonconformity_Date; "Closing Nonconformity Date")
            {
            }
            dataitem("Responsible Employee Line"; "Responsible Employee Line")
            {
                DataItemLink = "Document No." = field(No);
                DataItemLinkReference = "Nonconf Quality Report";


                column(No_; "No.")
                {
                }
                column(Employee; Employee)
                {
                }

            }

        }
    }
    labels
    {
        NonconfHeaderCap = 'Nonconformance';
    }
    trigger OnPreReport()
    begin
        CompanyInfor.Get();
        CompanyInfor.CalcFields(Picture);
    end;

    var
        CompanyInfor: Record "Company Information";
}
