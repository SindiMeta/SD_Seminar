codeunit 50132 "CSD Seminar Jnl.-Post Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-8
{
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin

    end;

    var
        SeminarJnlLine: Record "CSD Seminar Journal Line";
        SeminarLegderEntry: Record "CSD Seminar Ledger Entry";
        SeminarRegister: Record "CSD Seminar Register";
        SeminarCheckJnlLine: Codeunit "CSD Seminar Jnl.-Check Line";
        NextEntryNo: Integer;

    procedure RunWithCheck(var SeminarJnlLine2: Record "CSD Seminar Journal Line");
    var
        myInt: Integer;
    begin
        with SeminarJnlLine2 do begin

            SeminarJnlLine := SeminarJnlLine2;
            Code();
            SeminarJnlLine2 := SeminarJnlLine;
        end;
    end;

    local procedure Code()
    var
        myInt: Integer;
    begin
        with SeminarJnlLine do begin
            if EmptyLine() then
                exit;
            SeminarCheckJnlLine.RunCheck(SeminarJnlLine);
            if NextEntryNo = 0 then begin
                SeminarLegderEntry.LockTable();
                if SeminarLegderEntry.FindLast() then
                    NextEntryNo := SeminarLegderEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;

                if SeminarRegister."No." = 0 then begin
                    SeminarRegister.LockTable;
                    if (not SeminarRegister.FindLast) or
                    (SeminarRegister."To Entry No." <> 0) then begin
                        SeminarRegister.INIT;
                        SeminarRegister."No." := SeminarRegister."No." + 1;
                        SeminarRegister."From Entry No." := NextEntryNo;
                        SeminarRegister."To Entry No." := NextEntryNo;
                        SeminarRegister."Creation Date" := TODAY;
                        SeminarRegister."Source Code" := "Source Code";
                        SeminarRegister."Journal Batch Name" :=
                        "Journal Batch Name";
                        SeminarRegister."User ID" := USERID;
                        SeminarRegister.Insert;
                    end;

                end;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister.Modify;
            end;
            SeminarLegderEntry.Init();

            SeminarLegderEntry."Seminar No." := "Seminar No.";
            SeminarLegderEntry."Posting Date" := "Posting Date";
            SeminarLegderEntry."Document Date" := "Document Date";
            SeminarLegderEntry."Entry Type" := "Entry Type";
            SeminarLegderEntry."Document No." := "Document No.";
            SeminarLegderEntry.Description := Description;
            SeminarLegderEntry."Bill-to Customer No." :=
            "Bill-to Customer No.";
            SeminarLegderEntry."Charge Type" := "Charge Type";
            SeminarLegderEntry.Type := Type;
            SeminarLegderEntry.Quantity := Quantity;
            SeminarLegderEntry."Unit Price" := "Unit Price";
            SeminarLegderEntry."Total Price" := "Total Price";
            SeminarLegderEntry."Participant Contact No." :=
            "Participant Contact No.";
            SeminarLegderEntry."Participant Name" :=
            "Participant Name";
            SeminarLegderEntry.Chargeable := Chargeable;
            SeminarLegderEntry."Room Resource No." :=
            "Room Resource No.";
            SeminarLegderEntry."Instructor Resource No." :=
            "Instructor Resource No.";
            SeminarLegderEntry."Starting Date" := "Starting Date";
            SeminarLegderEntry."Seminar Registration No." :=
            "Seminar Registration No.";
            SeminarLegderEntry."Res. Ledger Entry No." :=
            "Res. Ledger Entry No.";
            SeminarLegderEntry."Source Type" := "Source Type";
            SeminarLegderEntry."Source No." := "Source No.";
            SeminarLegderEntry."Journal Batch Name" :=
            "Journal Batch Name";
            SeminarLegderEntry."Source Code" := "Source Code";
            SeminarLegderEntry."Reason Code" := "Reason Code";
            SeminarLegderEntry."No. Series" :=
            "Posting No. Series";
            SeminarLegderEntry."Entry No." := NextEntryNo;
            NextEntryNo += 1;
            SeminarLegderEntry.Insert;



        end;
    end;

}