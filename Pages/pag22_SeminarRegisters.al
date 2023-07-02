page 50122 "CSD Seminar Registers"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-11
{
    Caption = 'Seminar Registers';
    Editable = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Register";

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
                field("Creation Date"; Rec."Creation Date")
                {
                    ApplicationArea = All;

                }
                field("User ID"; Rec."User ID")
                {
                    ApplicationArea = All;

                }
                field("Source Code"; Rec."Source Code")
                {
                    ApplicationArea = All;

                }
                field("Journal Batch Name"; Rec."Journal Batch Name")
                {
                    ApplicationArea = All;

                }

            }
        }
        area(factboxes)
        {
            systempart("Record Links"; Links)
            {
                ApplicationArea = all;
                Caption = 'Links';
            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = all;
                Caption = 'Notes';
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Seminar Ledgers")
            {
                ApplicationArea = all;
                Caption = 'Seminar Ledgers';
                Image = WarrantyLedger;
                RunObject = codeunit "CSD Seminar Reg.-Show Ledger";
            }
        }
    }
}