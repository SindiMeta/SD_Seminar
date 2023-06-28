page 50135 "CSD Post Seminar Reg. Subpage"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    AutoSplitKey = true;
    Caption = 'Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "CSD Posted Seminar Reg. Line";
    UsageCategory = Tasks;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                    ApplicationArea = all;
                }
                field("Participant Name"; Rec."Participant Name")
                {
                    ApplicationArea = all;
                }
                field(Participated; Rec.Participated)
                {
                    ApplicationArea = all;
                }
                field("Registration Date"; Rec."Registration Date")
                {
                    ApplicationArea = all;
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                    ApplicationArea = all;
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = all;
                }
                field(Registered; Rec.Registered)
                {
                    ApplicationArea = all;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = all;
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                    ApplicationArea = all;
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                    ApplicationArea = all;
                }
                field(Amount; Rec.Amount)
                {
                    ApplicationArea = all;
                }
            }
        }
    }

    actions
    {
    }
}

