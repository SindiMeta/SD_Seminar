page 50136 "CSD Posted Seminar Reg. List"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    Caption = 'Posted Seminar Registration List';
    CardPageID = "CSD Posted Seminar Reg.";
    Editable = false;
    PageType = List;
    SourceTable = "CSD Posted Seminar Reg. Header";
    UsageCategory = Documents;
    ApplicationArea = all;

    layout
    {
        area(content)
        {
            repeater(Group)
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
                field(Status; Rec.Status)
                {
                    ApplicationArea = all;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = all;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = all;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = all;
                }
            }
        }
        area(factboxes)
        {
            // part(; 50117)
            // {
            //     SubPageLink = No.=Field(Seminar No.);
            // }
            // systempart(; Links)
            // {
            // }
            // systempart(; Notes)
            // {
            // }
            part("Seminar Details FactBox"; "CSD Seminar Details FactBox")
            {
                ApplicationArea = all;
                SubPageLink = "No." = Field("Seminar No.");
            }
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
                    RunObject = Page 50106;
                    RunPageLink = "No." = Field("No.");
                    //RunPageView = where(Document Type=const(Posted Seminar Registration));
                    RunPageView = where("Table Name" = const("Posted Seminar Registration"));

                }
                action("&Charges")
                {
                    Caption = '&Charges';
                    ApplicationArea = all;
                    Image = Costs;
                    RunObject = Page 50139;
                    //RunPageLink = Document No.=Field(No.);
                    RunPageLink = "Document No." = field("No.");



                }
            }
        }
        area(Processing)
        {
            action("&Navigate")
            {
                Caption = '&Navigate';
                Image = Navigate;
                Promoted = true;
                PromotedCategory = Process;
                ApplicationArea = All;

                trigger OnAction();
                var
                    Navigate: page Navigate;
                begin
                    Navigate.SetDoc(Rec."Posting Date", Rec."No.");
                    Navigate.Run();
                end;
            }
        }
    }
}