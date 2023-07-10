page 50102 "CSD Seminar List"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-6
{
    ApplicationArea = All;
    Caption = 'Seminar List';
    CardPageId = "CSD Seminar Card";
    Editable = false;
    PageType = List;
    SourceTable = "CSD Seminar";
    UsageCategory = Lists;

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
            group("&Seminar")
            {
                action("&Comments")
                {
                    ApplicationArea = All;
                    Caption = '&Comments';
                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                    RunObject = page "CSD Seminar Comment Sheet";
                    RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                }
                // >> Lab 8-2
                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    Image = WarrantyLedger;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "CSD Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    ShortcutKey = "Ctrl+F7";
                }
                action("&Registrations")
                {
                    ApplicationArea = All;
                    Caption = '&Registrations';
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                    RunObject = page "CSD Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                }
                // << Lab 8-2
            }
        }
        // >> Lab 8-2
        area(Processing)
        {
            action("Seminar Registration")
            {
                ApplicationArea = All;
                Caption = 'Seminar Registration';
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
                RunObject = page "CSD Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
            }
        }
        // << Lab 8-2
    }
}