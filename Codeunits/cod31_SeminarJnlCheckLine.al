codeunit 50131 "CSD Seminar Jnl.-Check Line"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 2-1
//Verifies the data validity of a seminar journal line before the posting routine posts it bydoing the following:
//• The codeunit checks that thejournal line is not empty and that there are values for the Posting Date, Instructor Resource
//No., and Seminar No.fields.
//• Depending on whether the line is posting an Instructor, a Room, or a Participant, the codeunit checks that the applicable
//fields are not blank. The codeunit also verifies that the dates are valid.
{
    //This codeunit checks each line before posting. which is called from the Seminar Jnl.- Post Line codeunit
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin
        RunCheck(Rec);
    end;

    var
        GlSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClosingDateTxt: Label 'cannot be a closing date.';
        PostingDateTxt: Label 'is not within your range of allowed posting dates.';

    procedure RunCheck(var SemJnLine: Record "CSD Seminar Journal Line");
    begin
        if SemJnLine.EmptyLine() then
            exit;

        SemJnLine.TestField("Posting Date");
        SemJnLine.TestField("Instructor Resource No.");
        SemJnLine.TestField("Seminar No.");

        case SemJnLine."Charge Type" of
            SemJnLine."Charge Type"::Instructor:
                SemJnLine.TestField("Instructor Resource No.");
            SemJnLine."Charge Type"::Room:
                SemJnLine.TestField("Room Resource No.");
            SemJnLine."Charge Type"::Participant:
                SemJnLine.TestField("Participant Contact No.");
        end;
        if SemJnLine.Chargeable then
            SemJnLine.TestField("Bill-to Customer No.");
        if SemJnLine."Posting Date" = ClosingDate(SemJnLine."Posting Date") then
            SemJnLine.FieldError("Posting Date", ClosingDateTxt);

        if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D) then begin
            if UserId <> '' then
                if UserSetup.Get(UserId) then begin
                    AllowPostingFrom := UserSetup."Allow Posting From";
                    AllowPostingTo := UserSetup."Allow Posting To";
                end;
            if (AllowPostingFrom = 0D) and (AllowPostingTo = 0D)
            then begin
                GlSetup.Get();
                AllowPostingFrom := GlSetup."Allow Posting From";
                AllowPostingTo := GlSetup."Allow Posting To";
            end;
            if AllowPostingTo = 0D then
                AllowPostingTo := DMY2Date(31, 12, 9999);
        end;
        if (SemJnLine."Posting Date" < AllowPostingFrom) or
        (SemJnLine."Posting Date" > AllowPostingTo) then
            SemJnLine.FieldError("Posting Date", PostingDateTxt);

        if (SemJnLine."Document Date" <> 0D) then
            if (SemJnLine."Document Date" = ClosingDate(SemJnLine."Document Date")) then
                SemJnLine.FieldError("Document Date", PostingDateTxt);
    end;

    procedure test()
    var
    begin
    end;

    procedure test(var saleshed: Record "Sales Header")
    var
    begin
    end;
}