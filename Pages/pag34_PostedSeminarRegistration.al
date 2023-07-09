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
        area(content)
        {
            group(General)
            {
                field("No."; Rec."No.")
                {
                    ApplicationArea = all;
                }
                field("Starting Date"; Rec."Starting Date")
                {
                    ApplicationArea = all;
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                    ApplicationArea = all;
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                    ApplicationArea = all;
                }
                field("Instructor Resource No."; Rec."Instructor Resource No.")
                {
                    ApplicationArea = all;
                }
                field("Instructor Name"; Rec."Instructor Name")
                {
                    ApplicationArea = all;
                }
                field("Posting Date"; Rec."Posting Date")
                {
                    ApplicationArea = all;
                }
                field("Document Date"; Rec."Document Date")
                {
                    ApplicationArea = all;
                }
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = all;
                }
                field("Minimum Participants"; Rec."Minimum Participants")
                {
                    ApplicationArea = all;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = all;
                }
            }
            part(SeminarRegistrationLines; "CSD Post Seminar Reg. Subpage")
            {
                Caption = 'SeminarRegistrationLines';
                ApplicationArea = all;
                //SubPageLink = Document No.=Field(No.);
                SubPageLink = "Document No." = Field("No.");
            }
            group("Seminar Room")
            {
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = all;
                }
                field("Room Name"; Rec."Room Name")
                {
                    ApplicationArea = all;
                }
                field("Room Address"; Rec."Room Address")
                {
                    ApplicationArea = all;
                }
                field("Room Address 2"; Rec."Room Address 2")
                {
                    ApplicationArea = all;
                }
                field("Room Post Code"; Rec."Room Post Code")
                {
                    ApplicationArea = all;
                }
                field("Room City"; Rec."Room City")
                {
                    ApplicationArea = all;
                }
                field("Room Country/Reg. Code"; Rec."Room Country/Reg. Code")
                {
                    ApplicationArea = all;
                }
                field("Room County"; Rec."Room County")
                {
                    ApplicationArea = all;
                }
            }
            group(Invoicing)
            {
                field("Gen. Prod. Posting Group"; Rec."Gen. Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("VAT Prod. Posting Group"; Rec."VAT Prod. Posting Group")
                {
                    ApplicationArea = all;
                }
                field("Seminar Price"; Rec."Seminar Price")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            // part(;50117)
            // {
            //     SubPageLink = No.=Field(Seminar No.);
            // }
            part("Seminar Details Factbox"; "CSD Seminar Details FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = Field("Seminar No.");
            }

            // part(;9084)
            // {
            //     Provider = SeminarRegistrationLines;
            //     SubPageLink = No.=Field(Bill-to Customer No.);
            // }
            part("Customer Details FactBox"; "Customer Details FactBox")
            {
                ApplicationArea = all;
                Provider = SeminarRegistrationLines;
                SubPageLink = "No." = Field("Bill-to Customer No.");
            }

            // systempart(;Links)
            // {
            // }
            // systempart(;Notes)
            // {
            // }
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
        area(navigation)
        {
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    ApplicationArea = all;
                    Image = Comment;
                    RunObject = Page "CSD Seminar Comment List";
                    //RunPageLink = No.=Field(No.);
                    RunPageLink = "No." = Field("No.");
                    //RunPageView = where("Document Type"=const(Posted Seminar Registration));
                    RunPageView = where("Table Name" = const("Posted Seminar Registration"));

                }
                action("&Charges")
                {
                    ApplicationArea = all;
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = Page "CSD Posted Seminar Charges";
                    //RunPageLink = Document No.=Field(No.);
                    RunPageLink = "Document No." = Field("No.");
                }
            }
        }
        area(Processing)
        {
            action("&Navigate")
            {
                ApplicationArea = all;
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;

                trigger OnAction();
                var
                    Navigate: page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                    Navigate.RUN;
                end;
            }
        }
    }
}
