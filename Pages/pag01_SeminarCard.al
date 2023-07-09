page 50101 "CSD Seminar Card"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-4 & Lab 2-5
{
    PageType = Card;
    Caption = 'Seminar Card';
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

                    //per te mbesht funks e serise se numrave
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
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    ApplicationArea = All;
                    RunObject = page "CSD Seminar Comment Sheet";
                    RunPageLink = "Table Name" = const(Seminar), "No." = field("No.");
                    Image = Comment;
                    Promoted = true;
                    PromotedIsBig = true;
                    PromotedOnly = true;
                }

                // >> Lab 8 1-2
                action("Ledger Entries")
                {
                    ApplicationArea = All;
                    Caption = 'Ledger Entries';
                    RunObject = page "CSD Seminar Ledger Entries";
                    RunPageLink = "Seminar No." = field("No.");
                    Promoted = true;
                    PromotedCategory = Process;
                    ShortcutKey = "Ctrl+F7";
                    Image = WarrantyLedger;
                }
                // >> Lab 8 1-2
                action("&Registrations")
                {
                    ApplicationArea = All;
                    Caption = '&Registrations';
                    RunObject = page "CSD Seminar Registration List";
                    RunPageLink = "Seminar No." = field("No.");
                    Image = Timesheet;
                    Promoted = true;
                    PromotedCategory = Process;
                }
                // << Lab 8 1-2

            }
        }
        // >> Lab 8 1-2
        area(Processing)
        {
            action("Seminar Registration")
            {
                Caption = 'Seminar Registration';
                ApplicationArea = All;
                RunObject = page "CSD Seminar Registration";
                RunPageLink = "Seminar No." = field("No.");
                RunPageMode = Create;
                Image = NewTimesheet;
                Promoted = true;
                PromotedCategory = New;
            }
        }
        // << Lab 8 1-2
    }


}