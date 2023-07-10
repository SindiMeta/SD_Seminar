page 50122 "CSD Seminar Registers"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-11
{
    //displays the registers that are created when seminar registrations are posted.
    Caption = 'Seminar Registers';
    Editable = false;
    PageType = List;
    SourceTable = "CSD Seminar Register";
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
                field("From Entry No."; Rec."From Entry No.")
                {
                    ApplicationArea = All;
                }
                field("To Entry No."; Rec."To Entry No.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Navigation)
        {
            action("Seminar Ledgers")
            {
                ApplicationArea = All;
                Caption = 'Seminar Ledgers';
                Image = WarrantyLedger;
                RunObject = codeunit "CSD Seminar Reg.-Show Ledger";
            }
        }
    }
}