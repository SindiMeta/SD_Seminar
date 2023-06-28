page 50136 "CSD Posted Seminar Reg. List"
{
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 7 - Lab 3
    //     - Created new page

    Caption = 'Seminar Registration List';
    CardPageID = "CSD Posted Seminar Reg.";
    Editable = false;
    PageType = List;
    SourceTable = "CSD Posted Seminar Reg. Header";

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("No."; Rec."No.")
                {
                }
                field("Starting Date"; Rec."Starting Date")
                {
                }
                field("Seminar No."; Rec."Seminar No.")
                {
                }
                field("Seminar Name"; Rec."Seminar Name")
                {
                }
                field(Status; Rec.Status)
                {
                }
                field(Duration; Rec.Duration)
                {
                }
                field("Maximum Participants"; Rec."Maximum Participants")
                {
                }
                field("Room Resource No."; Rec."Room Resource No.")
                {
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
            part("CSD Seminar Details FactBox"; "CSD Seminar Details FactBox")
            {
                SubPageLink = "No." = Field("Seminar No.");
            }
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
        area(navigation)
        {
            group("&Seminar Registration")
            {
                Caption = '&Seminar Registration';
                action("Co&mments")
                {
                    Caption = 'Co&mments';
                    Image = Comment;
                    RunObject = Page 50106;
                    RunPageLink = "No." = Field("No.");
                    //RunPageView = where(Document Type=const(Posted Seminar Registration));
                    RunPageView = where("Table Name" = const("Posted Seminar Registration"));

                }
                action("&Charges")
                {
                    Caption = '&Charges';
                    Image = Costs;
                    RunObject = Page 50139;
                    //RunPageLink = Document No.=Field(No.);
                    RunPageLink = "Document No." = field("No.");



                }
            }
        }
    }
}

