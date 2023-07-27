page 50147 "Nonconformance Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-3
{
    ApplicationArea = All;
    Caption = 'Nonconformance Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "Nonconformance Setup";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            group(Numbering)
            {
                field("Nonconformance Nos."; Rec."Nonconformance Nos.")
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnOpenPage()

    begin

        if not Rec.Get() then begin

            Rec.Init();

            Rec.Insert();
        end;
    end;
}
