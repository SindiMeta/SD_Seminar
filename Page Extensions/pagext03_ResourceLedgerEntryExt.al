pageextension 50104 "CSD ResourceLedgerEntryExt" extends "Resource Ledger Entries"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 4-3
{
    layout
    {
        //You typically want to show the new fields in the Ledger Entries page
        addlast(Content)
        {
            field("CSD Seminar No."; Rec."CSD Seminar No.")
            {

            }
            field("CSD Seminar Registration No."; Rec."CSD Seminar Registration No.")
            {
            }
        }
    }
}