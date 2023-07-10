codeunit 50132 "CSD Seminar Jnl.-Post Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-8

//• Performs the posting of the Seminar Journal Line. The codeunit creates a Seminar Ledger Entry for each Seminar
//Journal Line and creates a Seminar Register to track which entries are created during the posting
{

    //This codeunit posts each line. run the checkline codeunit
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin
        RunWithCheck(Rec);
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
        SeminarJnlLine2.Reset();
        if SeminarJnlLine2.FindFirst() then begin
            ;
            //with SeminarJnlLine2 do begin

            SeminarJnlLine := SeminarJnlLine2;
            Code();
            SeminarJnlLine2 := SeminarJnlLine;
        end;
    end;

    local procedure Code()
    var
        myInt: Integer;
    begin
        SeminarJnlLine.Reset();
        if SeminarJnlLine.FindFirst() then begin
            ;
            //with SeminarJnlLine do begin
            if SeminarJnlLine.EmptyLine() then
                exit;
            SeminarCheckJnlLine.RunCheck(SeminarJnlLine);
            //In this section, if NextEntryNo is equal to 0, it locks the SeminarLegderEntry table, finds the 
            //last entry, and assigns the value of the last entry's "Entry No." field to NextEntryNo. 
            //Then it increments NextEntryNo by 1.
            if NextEntryNo = 0 then begin
                SeminarLegderEntry.LockTable();
                if SeminarLegderEntry.FindLast() then
                    NextEntryNo := SeminarLegderEntry."Entry No.";
                NextEntryNo := NextEntryNo + 1;
                //In this section, if the "No." field of SeminarRegister is equal to 0, it locks the table, checks if it's the last entry 
                // or if the "To Entry No." field is not equal to 0. If either condition is true, it initializes a new record, assigns values 
                // to the relevant fields, and inserts the record. 
                // After that, it sets the "To Entry No." field of SeminarRegister to the value of NextEntryNo and modifies the record.
                if SeminarRegister."No." = 0 then begin
                    SeminarRegister.LockTable;
                    if (not SeminarRegister.FindLast) or
                    (SeminarRegister."To Entry No." <> 0) then begin
                        SeminarRegister.INIT;
                        SeminarRegister."No." := SeminarRegister."No." + 1;
                        SeminarRegister."From Entry No." := NextEntryNo;
                        SeminarRegister."To Entry No." := NextEntryNo;
                        SeminarRegister."Creation Date" := TODAY;
                        SeminarRegister."Source Code" := SeminarJnlLine."Source Code";
                        SeminarRegister."Journal Batch Name" :=
                        SeminarJnlLine."Journal Batch Name";
                        SeminarRegister."User ID" := USERID;
                        SeminarRegister.Insert;
                    end;

                end;
                SeminarRegister."To Entry No." := NextEntryNo;
                SeminarRegister.Modify;
            end;
            //Create a new SeminarLedgerEntry record, populate the fields from the
            // SeminarJnlLine record, set the Entry No. field to the NextEntryNo
            // variable, insert the new record, and then increment the NextEntryNo
            // variable by one and the record is inserted into the table.
            SeminarLegderEntry.Init();

            SeminarLegderEntry."Seminar No." := SeminarJnlLine."Seminar No.";
            SeminarLegderEntry."Posting Date" := SeminarJnlLine."Posting Date";
            SeminarLegderEntry."Document Date" := SeminarJnlLine."Document Date";
            SeminarLegderEntry."Entry Type" := SeminarJnlLine."Entry Type";
            SeminarLegderEntry."Document No." := SeminarJnlLine."Document No.";
            SeminarLegderEntry.Description := SeminarJnlLine.Description;
            SeminarLegderEntry."Bill-to Customer No." :=
            SeminarJnlLine."Bill-to Customer No.";
            SeminarLegderEntry."Charge Type" := SeminarJnlLine."Charge Type";
            SeminarLegderEntry.Type := SeminarJnlLine.Type;
            SeminarLegderEntry.Quantity := SeminarJnlLine.Quantity;
            SeminarLegderEntry."Unit Price" := SeminarJnlLine."Unit Price";
            SeminarLegderEntry."Total Price" := SeminarJnlLine."Total Price";
            SeminarLegderEntry."Participant Contact No." :=
           SeminarJnlLine."Participant Contact No.";
            SeminarLegderEntry."Participant Name" :=
            SeminarJnlLine."Participant Name";
            SeminarLegderEntry.Chargeable := SeminarJnlLine.Chargeable;
            SeminarLegderEntry."Room Resource No." :=
            SeminarJnlLine."Room Resource No.";
            SeminarLegderEntry."Instructor Resource No." :=
            SeminarJnlLine."Instructor Resource No.";
            SeminarLegderEntry."Starting Date" := SeminarJnlLine."Starting Date";
            SeminarLegderEntry."Seminar Registration No." :=
            SeminarJnlLine."Seminar Registration No.";
            SeminarLegderEntry."Res. Ledger Entry No." :=
            SeminarJnlLine."Res. Ledger Entry No.";
            SeminarLegderEntry."Source Type" := SeminarJnlLine."Source Type";
            SeminarLegderEntry."Source No." := SeminarJnlLine."Source No.";
            SeminarLegderEntry."Journal Batch Name" :=
            SeminarJnlLine."Journal Batch Name";
            SeminarLegderEntry."Source Code" := SeminarJnlLine."Source Code";
            SeminarLegderEntry."Reason Code" := SeminarJnlLine."Reason Code";
            SeminarLegderEntry."No. Series" :=
            SeminarJnlLine."Posting No. Series";
            SeminarLegderEntry."Entry No." := NextEntryNo;
            NextEntryNo += 1;
            SeminarLegderEntry.Insert;



        end;
    end;

}