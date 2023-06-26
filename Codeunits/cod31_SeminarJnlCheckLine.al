codeunit 50131 "CSD Seminar Jnl.-Check Line"
{
    TableNo = "CSD Seminar Journal Line";

    trigger OnRun()
    begin

    end;

    var
        GlSetup: Record "General Ledger Setup";
        UserSetup: Record "User Setup";
        AllowPostingFrom: Date;
        AllowPostingTo: Date;
        ClosingDateTxt: Label 'cannot be a closing date.';
        PostingDateTxt: label 'is not within your range of allowed posting dates.';

    procedure RunCheck(var SemJnLine: Record "CSD Seminar Journal Line");
    var
        myInt: Integer;
    begin
        with SemJnLine do begin

        end;


    end;
}