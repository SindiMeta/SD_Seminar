page 50101 "CSD Seminar Card"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.2: Task 5
{
    PageType = Card;
    Caption = 'Seminar Card';
    ApplicationArea = All;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                    AssistEdit = true;

                    trigger OnAssistEdit()
                    begin
                        if Rec.AssistEdit() then
                            CurrPage.Update();
                    end;

                }
                field(Name; Rec.Name)
                {
                    ApplicationArea = All;

                }
                field("Search Name"; Rec."Search Name")
                {
                    ApplicationArea = All;
                }
                field("Seminar Duration"; Rec."Seminar Duration")
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
                field(Blocked; Rec.Blocked)
                {
                    ApplicationArea = All;

                }
                field("Last Date Modified"; Rec."Last Date Modified")
                {
                    ApplicationArea = All;

                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = All;

                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = All;

                }
            }

        }
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {

            }
            systempart("Notes"; Notes)
            {

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


                    //RunObject = page "CSD Seminar Comment Sheet";
                    //RunObject = page "CSD Seminar Comment Sheet ";
                    //RunPageLink = "Table Name"=const(Seminar),"No."=field("No.");
                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }


            }
        }
    }


}