page 50113 "CSD Seminar Registration List"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 6 - Lab 3
    //     - Created new page
    // Chapter 7 - Lab 4-8
    // Added Action Post

    Caption = 'Seminar Registration List';
    CardPageId = "CSD Seminar Registration";
    Editable = false;
    PageType = List;
    SourceTable = "CSD Seminar Reg. Header";
    UsageCategory = lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
                field("Room Resource No."; Rec."Room Resource No.")
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
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = page "CSD Seminar Comment Sheet";
                    RunPageLink = "No." = field("No.");
                    RunPageView = where("Table Name" = const("Seminar Registration"));
                }
                action("&Charges")
                {
                    ApplicationArea = All;
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = page "CSD Seminar Charges";
                    RunPageLink = "Document No." = field("No.");
                }
                action("&Post")
                {
                    ApplicationArea = All;
                    Caption = '&Post';
                    Image = PostDocument;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    RunObject = codeunit "CSD Seminar-Post (Yes/No)";
                    ShortcutKey = F9;
                }
                action("&Print")
                {
                    ApplicationArea = All;
                    Caption = '&Print';
                    Image = Print;
                    Promoted = true;
                    PromotedCategory = Process;
                    PromotedIsBig = true;
                    trigger OnAction();
                    var
                        SeminarReportSelection: Record "CSD Seminar Report Selections";
                    begin
                        SeminarReportSelection.PrintReportSelection
                        (SeminarReportSelection.Usage::Registration, Rec);
                    end;
                }
            }
        }
    }
}
