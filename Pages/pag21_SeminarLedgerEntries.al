page 50121 "CSD Seminar Ledger Entries"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-9
{
    Caption = 'Seminar Ledger Entries';
    Editable = false;
    PageType = Card;
    ApplicationArea = All;
    UsageCategory = Lists;
    SourceTable = "CSD Seminar Ledger Entry";

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Posting Date"; Rec."Posting Date")
                {

                }
                field("Document No."; Rec."Document No.")
                {

                }
                field("Document Date"; Rec."Document Date")
                {
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {

                }
                field("Seminar No."; Rec."Seminar No.")
                {

                }
                field(Description; Rec.Description)
                {

                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {

                }
                field("Charge Type"; Rec."Charge Type")
                {

                }
                field(Type; Rec.Type)
                {

                }
                field(Quantity; Rec.Quantity)
                {

                }
                field("Unit Price"; Rec."Unit Price")
                {

                }
                field("Total Price"; Rec."Total Price")
                {

                }
                field(Chargeable; Rec.Chargeable)
                {

                }
                field("Participant Contact No."; Rec."Participant Contact No.")
                {

                }
                field("Participant Name"; Rec."Participant Name")
                {

                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {

                }
                field("Room Resource No."; Rec."Room Resource No.")
                {

                }
                field("Starting Date"; Rec."Starting Date")
                {

                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {

                }
                field("Entry No."; Rec."Entry No.")
                {

                }
            }
        }
        area(factboxes)
        {
            systempart("Record Links"; Links)
            {

            }
            systempart("Notes"; Notes)
            {

            }
        }
    }

    actions
    {
        area(Processing)
        {
            action(ActionName)
            {
                ApplicationArea = All;

                trigger OnAction()
                begin

                end;
            }
        }
    }

    var
        myInt: Integer;
}