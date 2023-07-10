codeunit 50134 "CSD Seminar Reg.-Show Ledger"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-10
{
    TableNo = "CSD Seminar Register";

    var
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";

    //This codeunit shows the ledger entries that result from a single journal posting.
    // the codeunit runs the CSD Seminar Ledger Entries page showing only those entries between the From Entry No.
    //field and the To Entry No. field on the Seminar Register
    trigger OnRun()
    begin
        SeminarLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        Page.Run(Page::"CSD Seminar Ledger Entries", SeminarLedgerEntry);
    end;
}