page 50136 "CSD Posted Seminar Reg. List"
{
    ApplicationArea = All;
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    Caption = 'Posted Seminar Registration List';
    CardPageId = "CSD Posted Seminar Reg.";
    Editable = false;
    PageType = List;
    SourceTable = "CSD Posted Seminar Reg. Header";
    UsageCategory = Documents;

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
                field(Status; Rec.Status)
                {
                    ApplicationArea = All;
                }
                field(Duration; Rec.Duration)
                {
                    ApplicationArea = All;
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                    ApplicationArea = All;
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
                    ApplicationArea = All;
                }
            }
        }
        area(FactBoxes)
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
                ApplicationArea = All;
                SubPageLink = "No." = field("Seminar No.");
            }
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
                    RunObject = page "CSD Seminar Comment Sheet";
                    RunPageLink = "No." = field("No.");
                    //RunPageView = where(Document Type=const(Posted Seminar Registration));
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