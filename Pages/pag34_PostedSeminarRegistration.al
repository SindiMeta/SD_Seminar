page 50134 "CSD Posted Seminar Reg."
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page
    // Chapter 8 - Lab 2 - 4
    // Added Action Navigate

    Caption = 'Posted Seminar Registration';
    Editable = false;
    PageType = Document;
    SourceTable = "CSD Posted Seminar Reg. Header";

    layout
    {
        area(Content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = All;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = All;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = All;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = All;
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = All;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = All;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = All;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
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
            part(SeminarRegistrationLines; "CSD Post Seminar Reg. Subpage")
            {
                ApplicationArea = All;
                Caption = 'SeminarRegistrationLines';
                //SubPageLink = Document No.=Field(No.);
                SubPageLink = "Document No." = field("No.");
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = All;
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = All;
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = All;
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = All;
                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = All;
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = All;
                }
                field("Room County"; Rec."Room County")
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
            // part(;50117)
            // {
            //     SubPageLink = No.=Field(Seminar No.);
            // }
            part("Seminar Details Factbox"; "CSD Seminar Details FactBox")
            {
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
            }

            // part(;9084)
            // {
            //     Provider = SeminarRegistrationLines;
            //     SubPageLink = No.=Field(Bill-to Customer No.);
            // }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = All;
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = field("Bill-to Customer No.");
            }

            // systempart(;Links)
            // {
            // }
            // systempart(;Notes)
            // {
            // }
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
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    ApplicationArea = All;
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = page "CSD Seminar Comment List";
                    //RunPageLink = No.=Field(No.);
                    RunPageLink = "No." = field("No.");
                    //RunPageView = where("Document Type"=const(Posted Seminar Registration));
                    RunPageView = where("Table Name" = const("Posted Seminar Registration"));
                }
                action("&Charges")
                {
                    ApplicationArea = All;
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = page "CSD Posted Seminar Charges";
                    //RunPageLink = Document No.=Field(No.);
                    RunPageLink = "Document No." = field("No.");
                }
            }
        }
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = All;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    Navigate: Page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                    Navigate.Run();
                end;
            }
        }
    }
}
