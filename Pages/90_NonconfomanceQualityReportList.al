page 50148 "NonconfQuality Report List"
{
    Caption = 'Nonconformance Quality Report List';
    PageType = List;
    ApplicationArea = All;
    UsageCategory = lists;
    Editable = false;
    SourceTable = "Nonconf Quality Report";
    CardPageId = "Nonconformance Quality Report";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Type of nonconformity"; Rec."Type of nonconformity")
                {
                    ApplicationArea = All;

                }
                field("CAQS Employee Number"; Rec."CAQS Employee Number")
                {
                    ApplicationArea = All;

                }
                field("CAQS Employee"; Rec."CAQS Employee")
                {
                    ApplicationArea = All;

                }
                field("Nonconformity Reason"; Rec."Nonconformity Reason")
                {
                    ApplicationArea = All;

                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;

                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }

            }
        }
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {
                ApplicationArea = All;
            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = All;
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
                        NonconfReportSelection: Record "Nonconf Report Selections";
                    begin
                        NonconfReportSelection.PrintReportSelection
                         (NonconfReportSelection.Usage::Registration, Rec);
                    end;
                }
            }
        }
    }
}