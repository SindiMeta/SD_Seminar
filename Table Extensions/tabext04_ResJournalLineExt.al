tableextension 50104 "CSD ResJournalLineExt" extends "Res. Journal Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 4-2

//Add fields to support posting of seminar information during resource journal posting.
{
    fields
    {
        //To post any new fields to a Ledger Entry table, you must first add those fields to the matching Journal Line table.
        field(50100; "CSD Seminar No."; Code[20])
        {
            Caption = 'Seminar No';
            TableRelation = "CSD Seminar";
        }
        field(50101; "CSD Seminar Registration No."; Code[20])
        {
            Caption = 'Seminar Registration No';
            TableRelation = "CSD Seminar Reg. Header";
        }
    }
}