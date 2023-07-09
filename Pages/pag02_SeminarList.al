page 50102 "CSD Seminar List"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-6
{
    PageType = List;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar";
    Caption = 'Seminar List';
    Editable = false;
    CardPageId = 50101;



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
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field("Seminar Duration"; Rec."Seminar Duration")
                {
                    ApplicationArea = All;

                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;

                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {

                    ApplicationArea = All;

                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;

                }
            }
        }
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {
                ApplicationArea = all;

            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = all;

            }
        }
    }

    actions
    {
        area(Navigation)
        {
            group("&Seminar")
            {
                action("&Comments")
                {
                    Caption = '&Comments';
                    ApplicationArea = All;
                    RunObject = page "CSD Seminar Comment Sheet";

                    RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }
                // >> Lab 8-2
                action("Ledger Entries")
                {
                    Caption = 'Ledger Entries';
                    ApplicationArea = All;
                    RunObject = page "CSD Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = "Ctrl+F7";
                    Image = WarrantyLedger;
                }
                action("&Registrations")
                {
                    ApplicationArea = all;
                    Caption = '&Registrations';
                    RunObject = page "CSD Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                // << Lab 8-2


            }
        }
        // >> Lab 8-2
        area(Processing)
        {
            action("Seminar Registration")
            {
                Caption = 'Seminar Registration';
                ApplicationArea = all;
                RunObject = page "CSD Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
            }
        }
        // << Lab 8-2
    }
}