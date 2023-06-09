pageextension 50103 "CSD SourceCodeSetupExt" extends "Source Code Setup"
// CSD1.00 - 2012-06-15 - D. E. Veloper
// Chapter 7 - Lab 1-8
{
    layout
    {
        addafter("Cost Accounting")
        {
            group(SeminarGroup)
            {
                Caption = 'Seminar';
            }
        }
        addfirst(SeminarGroup)
        {
            field(Seminar; Rec."CSD Seminar")
            {
                ApplicationArea = All;
            }
        }
    }
}