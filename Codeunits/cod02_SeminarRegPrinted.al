codeunit 50102 "CSD SeminarRegPrinted"
// Chapter 9 - Lab 1-2
// - Added Codeunit
{

    //Create a codeunit to increment the No. Printed field just added to the Seminar Registration Header table
    TableNo = "CSD Seminar Reg. Header";
    trigger OnRun()
    begin
        Rec.Find;
        Rec."No. Printed" += 1;
        Rec.Modify;
        Commit;

    end;
}