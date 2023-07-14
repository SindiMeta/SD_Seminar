page 50100 "CSD Seminar Setup"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 5 - Lab 2-3
{
    ApplicationArea = All;
    Caption = 'Seminar Setup';
    DeleteAllowed = false;
    InsertAllowed = false;
    PageType = Card;
    SourceTable = "CSD Seminar Setup";
    UsageCategory = Administration;

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
        //Merr një rekord bazuar në vlerat e ruajtura ne primary key
        if not Rec.Get() then begin
            //nese nuk gjen Inicializon një rekord te ri në tabelë.
            Rec.Init();
            //dhe i fut ne tabele
            Rec.Insert();
        end;
    end;
}
