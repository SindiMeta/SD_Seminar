codeunit 50100 "CSD Seminar-Post"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 4-7
{
    // Posts the complete seminar registration that includes the resource posting and seminar posting. • The codeunit transfers
    // the comment records to new comment records that correspond to the posted document. The codeunit also copies charges
    // to new tables that contain posted charges. • The codeunit creates a new Posted Seminar Reg. Header record and
    // Posted SeminarReg. Line records. • The codeunit then runs the job journal posting, and posts seminar ledger entries
    // for each participant, for the instructor, and for the room. Finally,
    // the codeunit deletes the records from the document tables. This includes the header, lines, comment lines, and charges.

    TableNo = "CSD Seminar Reg. Header";

    trigger OnRun();
    begin
        ClearAll();
        SeminarRegHeader := Rec;

        SeminarRegHeader.TestField("Posting Date");
        SeminarRegHeader.TestField("Document Date");
        SeminarRegHeader.TestField("Seminar No.");
        SeminarRegHeader.TestField(Duration);
        SeminarRegHeader.TestField("Instructor Resource No.");
        SeminarRegHeader.TestField("Room Resource No.");
        SeminarRegHeader.TestField(Status, SeminarRegHeader.Status::Closed);

        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarRegLine.IsEmpty then
            Error(Text001);

        Window.Open('#1#################################\\' +
       Text002);
        Window.Update(1, StrSubstNo('%1 %2', Text003, SeminarRegHeader."No."));

        if SeminarRegHeader."Posting No." = '' then begin
            SeminarRegHeader.TestField("Posting No. Series");
            SeminarRegHeader."Posting No." := NoSeriesMgt.GetNextNo(SeminarRegHeader."Posting No. Series", SeminarRegHeader."Posting Date", true);
            SeminarRegHeader.Modify();
            Commit();
        end;
        SeminarRegLine.LockTable();

        SourceCodeSetup.Get();
        SourceCode := SourceCodeSetup."CSD Seminar";

        PstdSeminarRegHeader.Init();
        PstdSeminarRegHeader.TransferFields(SeminarRegHeader);
        PstdSeminarRegHeader."No." := SeminarRegHeader."Posting No.";
        PstdSeminarRegHeader."No. Series" := SeminarRegHeader."Posting No. Series";
        PstdSeminarRegHeader."Source Code" := SourceCode;
        PstdSeminarRegHeader."User Id" := UserId;
        PstdSeminarRegHeader.Insert();

        Window.Update(1, StrSubstNo(Text004, SeminarRegHeader."No.", PstdSeminarRegHeader."No."));

        CopyCommentLines(
        SeminarCommentLine."Table Name"::"Seminar Registration",
        SeminarCommentLine."Table Name"::"Posted Seminar Registration", SeminarRegHeader."No.", PstdSeminarRegHeader."No.");
        CopyCharges(SeminarRegHeader."No.", PstdSeminarRegHeader."No.");

        LineCount := 0;
        SeminarRegLine.Reset();
        SeminarRegLine.SetRange("Document No.", SeminarRegHeader."No.");
        if SeminarRegLine.FindSet() then begin
            repeat
            until SeminarRegLine.Next() = 0;

            Window.Update(2, LineCount);
            SeminarRegLine.TestField("Bill-to Customer No.");
            SeminarRegLine.TestField("Participant Contact No.");
            if not SeminarRegLine."To Invoice" then begin
                SeminarRegLine."Seminar Price" := 0;
                SeminarRegLine."Line Discount %" := 0;
                SeminarRegLine."Line Discount Amount" := 0;
                SeminarRegLine.Amount := 0;

                SeminarRegHeader.Delete(true);
            end;
            // Post seminar entry
            PostSeminarJnlLine(2); // Participant
                                   // Insert posted seminar registration line
            PstdSeminarRegLine.Init();
            PstdSeminarRegLine.TransferFields(SeminarRegLine);
            PstdSeminarRegLine."Document No." :=
            PstdSeminarRegHeader."No.";
            PstdSeminarRegLine.Insert();

            // Post charges to seminar ledger
            PostCharges();
            // Post instructor to seminar ledger
            PostSeminarJnlLine(0); // Instructor
                                   // Post seminar room to seminar ledger
            PostSeminarJnlLine(1); // Room
        end;
        Rec := SeminarRegHeader;
    end;

    var
        PstdSeminarCharge: Record "CSD Posted Seminar Charge";
        PstdSeminarRegHeader: Record "CSD Posted Seminar Reg. Header";
        PstdSeminarRegLine: Record "CSD Posted Seminar Reg. Line";
        SeminarCharge: Record "CSD Seminar Charge";
        SeminarCommentLine: Record "CSD Seminar Comment Line";
        SeminarCommentLine2: Record "CSD Seminar Comment Line";
        SeminarJnlLine: Record "CSD Seminar Journal Line";
        SeminarRegHeader: Record "CSD Seminar Reg. Header";
        SeminarRegLine: Record "CSD Seminar Registration Line";
        ResJnlLine: Record "Res. Journal Line";
        ResLedgEntry: Record "Res. Ledger Entry";
        Instructor: Record Resource;
        Room: Record Resource;
        SourceCodeSetup: Record "Source Code Setup";
        SeminarJnlPostLine: Codeunit "CSD Seminar Jnl.-Post Line";
        NoSeriesMgt: Codeunit NoSeriesManagement;
        ResJnlPostLine: Codeunit "Res. Jnl.-Post Line";
        SourceCode: Code[10];
        Window: Dialog;
        LineCount: Integer;
        Text001: Label 'There is no participant to post.';
        Text002: Label 'Posting lines              #2######\';
        Text003: Label 'Registration';
        Text004: Label 'Registration %1  -> Posted Reg. %2';

    local procedure CopyCommentLines(FromDocumentType: Integer; ToDocumentType: Integer; FromNumber: Code[20]; ToNumber: Code[20]);
    begin
        SeminarCommentLine.Reset();
        SeminarCommentLine.SetRange("Table Name",
        FromDocumentType);
        SeminarCommentLine.SetRange("No.", FromNumber);
        if SeminarCommentLine.FindSet() then
            repeat
                SeminarCommentLine2 := SeminarCommentLine;
                SeminarCommentLine2."Table Name" := ToDocumentType;
                SeminarCommentLine2."No." := ToNumber;
                SeminarCommentLine2.Insert();
            until SeminarCommentLine.Next() = 0;
    end;

    local procedure CopyCharges(FromNumber: Code[20]; ToNumber: Code[20]);
    begin
        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.", FromNumber);
        if SeminarCharge.FindSet() then
            repeat
                PstdSeminarCharge.TransferFields(SeminarCharge);
                PstdSeminarCharge."Document No." := ToNumber;
                PstdSeminarCharge.Insert();
            until SeminarCharge.Next() = 0;
    end;

    local procedure PostResJnlLine(Resource: Record Resource): Integer;
    begin
        ResJnlLine.Init();
        ResJnlLine."Entry Type" := ResJnlLine."Entry Type"::Usage;
        ResJnlLine."Document No." := PstdSeminarRegHeader."No.";
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        ResJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        ResJnlLine.Description := SeminarRegHeader."Seminar Name";
        ResJnlLine."Gen. Prod. Posting Group" :=
        SeminarRegHeader."Gen. Prod. Posting Group";
        ResJnlLine."Posting No. Series" := SeminarRegHeader."Posting No. Series";
        ResJnlLine."Source Code" := SourceCode;
        ResJnlLine."Resource No." := Resource."No.";
        ResJnlLine."Unit of Measure Code" :=
        Resource."Base Unit of Measure";
        ResJnlLine."Unit Cost" := Resource."Unit Cost";
        ResJnlLine."Qty. per Unit of Measure" := 1;

        ResJnlLine.Quantity := SeminarRegHeader.Duration * Resource."CSD Quantity Per Day";
        ResJnlLine."Total Cost" := ResJnlLine."Unit Cost" *
        ResJnlLine.Quantity;
        ResJnlLine."CSD Seminar No." := SeminarRegHeader."Seminar No.";
        ResJnlLine."CSD Seminar Registration No." :=
        PstdSeminarRegHeader."No.";
        ResJnlPostLine.RunWithCheck(ResJnlLine);

        ResLedgEntry.FindLast();
        exit(ResLedgEntry."Entry No.");
    end;

    local procedure PostSeminarJnlLine(ChargeType: Option Instructor,Room,Participant,Charge);
    begin
        SeminarJnlLine.Init();
        SeminarJnlLine."Seminar No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Posting Date" := SeminarRegHeader."Posting Date";
        SeminarJnlLine."Document Date" := SeminarRegHeader."Document Date";
        SeminarJnlLine."Document No." :=
        PstdSeminarRegHeader."No.";
        SeminarJnlLine."Charge Type" := ChargeType;
        SeminarJnlLine."Instructor Resource No." :=
        SeminarRegHeader."Instructor Resource No.";
        SeminarJnlLine."Starting Date" := SeminarRegHeader."Starting Date";
        SeminarJnlLine."Seminar Registration No." :=
        PstdSeminarRegHeader."No.";
        SeminarJnlLine."Room Resource No." :=
        SeminarRegHeader."Room Resource No.";
        SeminarJnlLine."Source Type" :=
        SeminarJnlLine."Source Type"::Seminar;
        SeminarJnlLine."Source No." := SeminarRegHeader."Seminar No.";
        SeminarJnlLine."Source Code" := SourceCode;
        SeminarJnlLine."Reason Code" := SeminarRegHeader."Reason Code";
        SeminarJnlLine."Posting No. Series" :=
        SeminarRegHeader."Posting No. Series";

        case ChargeType of
            ChargeType::Instructor:
                ;
            ChargeType::Room:
                ;
            ChargeType::Participant:
                ;
            ChargeType::Charge:
                ;
        end;

        case ChargeType of
            ChargeType::Instructor:
                begin
                    Instructor.Get(SeminarRegHeader."Instructor Resource No.");
                    SeminarJnlLine.Description := Instructor.Name;
                    SeminarJnlLine.Type :=
                    SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    SeminarJnlLine."Res. Ledger Entry No." :=
                    PostResJnlLine(Instructor);
                end;

            ChargeType::Room:
                begin
                    Room.Get(SeminarRegHeader."Room Resource No.");
                    SeminarJnlLine.Description := Room.Name;
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := false;
                    SeminarJnlLine.Quantity := SeminarRegHeader.Duration;
                    // Post to resource ledger
                    SeminarJnlLine."Res. Ledger Entry No." :=
                    PostResJnlLine(Room);
                end;

            ChargeType::Participant:
                begin
                    SeminarJnlLine."Bill-to Customer No." :=
                    SeminarRegLine."Bill-to Customer No.";
                    SeminarJnlLine."Participant Contact No." :=
                     SeminarRegLine."Participant Contact No.";
                    SeminarJnlLine."Participant Name" :=
                    SeminarRegLine."Participant Name";
                    SeminarJnlLine.Description :=
                    SeminarRegLine."Participant Name";
                    SeminarJnlLine.Type := SeminarJnlLine.Type::Resource;
                    SeminarJnlLine.Chargeable := SeminarRegLine."To Invoice";
                    SeminarJnlLine.Quantity := 1;
                    SeminarJnlLine."Unit Price" := SeminarRegLine.Amount;
                    SeminarJnlLine."Total Price" := SeminarRegLine.Amount;
                end;

            ChargeType::Charge:
                begin
                    SeminarJnlLine.Description :=
                    SeminarCharge.Description;
                    SeminarJnlLine."Bill-to Customer No." :=
                    SeminarCharge."Bill-to Customer No.";
                    SeminarJnlLine.Type := SeminarCharge.Type;
                    SeminarJnlLine.Quantity := SeminarCharge.Quantity;
                    SeminarJnlLine."Unit Price" :=
                    SeminarCharge."Unit Price";
                    SeminarJnlLine."Total Price" :=
                    SeminarCharge."Total Price";
                    SeminarJnlLine.Chargeable :=
                    SeminarCharge."To Invoice";
                end;
        end;

        SeminarJnlPostLine.RunWithCheck(SeminarJnlLine);
    end;

    local procedure PostCharges();
    begin
        SeminarCharge.Reset();
        SeminarCharge.SetRange("Document No.",
        SeminarRegHeader."No.");
        if SeminarCharge.FindSet(false, false) then
            repeat
                PostSeminarJnlLine(3); // Charge
            until SeminarCharge.Next() = 0;
    end;
}