page 50104 "Nonconformance Quality Report"
{
    Caption = 'Nonconformance Quality Report';
    PageType = Card;
    SourceTable = "Nonconf Quality Report";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("Type of nonconformity"; Rec."Type of nonconformity")
                {

                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field("CAQS Employee Number"; Rec."CAQS Employee Number")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;

                }
                field("CAQS Employee"; Rec."CAQS Employee")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field("Nonconformity Reason"; Rec."Nonconformity Reason")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;

                }
            }
            part(ResponsibleReportLines; "Responsible Employee SubPage")
            {
                ApplicationArea = all;
                Caption = 'Responsible Employee';
                SubPageLink = "Document No." = field(No);
                Editable = EditableProperty;

            }

            group("Nonconformity Details")
            {
                field("Item No"; Rec."Item No")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field(Lot; Rec.Lot)
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field("Nonconformity Description"; Rec."Nonconformity Description")
                {
                    ApplicationArea = all;
                    Editable = EditableProperty;
                }
            }

            group("Corrective/Preventive action")
            {
                field("Proposal for corr/prev action"; Rec."Proposal for corr/prev action")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field(Comments; Rec.Comments)
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field(Penalty; Rec.Penalty)
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
                field("Actions taken"; Rec."Actions taken")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
            }

            group(Closed)
            {
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                    trigger OnValidate()
                    var
                        myInt: Integer;
                    begin
                        if Rec.Status = Status::Closed then
                            EditableProperty := false
                        else
                            EditableProperty := true;


                    end;

                }
                field("Closing Nonconformity Date"; Rec."Closing Nonconformity Date")
                {
                    ApplicationArea = All;
                    Editable = EditableProperty;
                }
            }

        }
    }
    actions
    {
        area(Navigation)
        {
            group("&Nonconformance")
            {
                Caption = 'Nonconf';

                action("&Print")
                {
                    ApplicationArea = all;
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction();
                    var
                        NonconfReport: Record "Nonconf Quality Report";
                        NonConf: Report NonconfReport;
                    begin
                        CurrPage.SetSelectionFilter(NonconfReport);
                        Report.Run(Report::NonconfReport, true, false, NonconfReport);
                    end;
                }
            }
        }
    }
    // trigger OnAfterGetCurrRecord();
    // begin
    //     if Rec.Status = Rec.Status::Closed then
    //         EditableProperty := false;
    //     if Rec.Status = Rec.Status::Open then
    //         EditableProperty := true;
    // end;

    var
        EditableProperty: Boolean;





}