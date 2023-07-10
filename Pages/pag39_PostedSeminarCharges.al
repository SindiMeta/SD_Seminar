page 50139 "CSD Posted Seminar Charges"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    AutoSplitKey = true;
    Caption = 'Posted Seminar Charges';
    Editable = false;
    PageType = List;
    SourceTable = "CSD Posted Seminar Charge";

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
                field(Description; Rec.Description)
                {
                    ApplicationArea = All;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure Code"; Rec."Unit of Measure Code")
                {
                    ApplicationArea = All;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = All;
                }
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = All;
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = All;
                }
                field("To Invoice"; Rec."To Invoice")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
}
