codeunit 50103 "NoncoformanceRegPrinted"

{

    TableNo = "Nonconf Quality Report";
    trigger OnRun()
    begin
        Rec.Find();
        Rec."No. Printed" += 1;
        Rec.Modify();
        Commit();
    end;
}