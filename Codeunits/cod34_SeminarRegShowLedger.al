codeunit 50134 "CSD Seminar Reg.-Show Ledger"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-10
{

    //This codeunit shows the ledger entries that result from a single journal posting.
    // The transaction is defined by the Seminar Register record that this function receives through the Rec parameter 
    // of the OnRun trigger.

    TableNo = "CSD Seminar Register";
    // the codeunit runs the CSD Seminar Ledger Entries page showing only those entries between the From Entry No. 
    //field and the To Entry No. field on the Seminar Register
    trigger OnRun()
    begin
        SeminarLedgerEntry.SetRange("Entry No.", Rec."From Entry No.", Rec."To Entry No.");
        page.Run(Page::"CSD Seminar Ledger Entries", SeminarLedgerEntry);
    end;

    var
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
}