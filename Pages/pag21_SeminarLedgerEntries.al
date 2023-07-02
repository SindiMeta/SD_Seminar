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
                    ApplicationArea = all;
                }
                field("Document No."; Rec."Document No.")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                    Visible = false;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = all;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = all;
                }
                field(Description; Rec.Description)
                {
                    ApplicationArea = all;
                }
                field("Bill-to Customer No."; Rec."Bill-to Customer No.")
                {
                    ApplicationArea = all;
                }
                field("Charge Type"; Rec."Charge Type")
                {
                    ApplicationArea = all;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = all;
                }
                field(Quantity; Rec.Quantity)
                {
                    ApplicationArea = all;
                }
                field("Unit Price"; Rec."Unit Price")
                {
                    ApplicationArea = all;
                }
                field("Total Price"; Rec."Total Price")
                {
                    ApplicationArea = all;
                }
                field(Chargeable; Rec.Chargeable)
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
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = all;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Seminar Registration No."; Rec."Seminar Registration No.")
                {
                    ApplicationArea = all;
                }
                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            systempart("Record Links"; Links)
            {
                ApplicationArea = all;
                Caption = 'Record Links';
            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = all;
                Caption = 'Notes';
            }
        }
    }
}