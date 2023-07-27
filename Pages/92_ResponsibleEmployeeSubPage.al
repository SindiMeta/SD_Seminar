page 50109 "Responsible Employee SubPage"
{
    Caption = 'Employee Lines';
    DelayedInsert = true;
    PageType = ListPart;
    SourceTable = "Responsible Employee Line";
    AutoSplitKey = true;
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
                field(Employee; Rec.Employee)
                {
                    ApplicationArea = all;
                }
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
}