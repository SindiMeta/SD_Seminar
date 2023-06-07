page 50100 "CSD Seminar Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.2: Task 4
{
    PageType = Card;
    InsertAllowed = false;
    ApplicationArea = All;
    DeleteAllowed = false;
    UsageCategory = Administration;
    SourceTable = "CSD Seminar Setup";
    Caption = 'Seminar Setup';

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Seminar Nos."; Rec."Seminar Nos.")
                {

                    ApplicationArea = All;

                }
                field("Seminar Registration Nos."; Rec."Seminar Registration Nos.")
                {
                    ApplicationArea = All;

                }
                field("Posted Seminar Reg. Nos."; Rec."Posted Seminar Reg. Nos.")
                {
                    ApplicationArea = All;

                }

            }

        }

    }
    trigger OnOpenPage()

    begin
        if not Rec.get then begin
            Rec.Init();
            Rec.Insert();
        end;

    end;
}












