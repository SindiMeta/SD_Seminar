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

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {
                }
                field("Participant Name"; Rec."Participant Name")
                {
                }
                field(Participated; Rec.Participated)
                {
                }
                field("Registration Date"; Rec."Registration Date")
                {
                }
                field("Confirmation Date"; Rec."Confirmation Date")
                {
                }
                field("To Invoice"; Rec."To Invoice")
                {
                }
                field(Registered; Rec.Registered)
                {
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                }
                field("Line Discount %"; Rec."Line Discount %")
                {
                }
                field("Line Discount Amount"; Rec."Line Discount Amount")
                {
                }
                field(Amount; Rec.Amount)
                {
                }
            }
        }
    }

    actions
    {
    }
}

