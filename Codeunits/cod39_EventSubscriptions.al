codeunit 50139 "CSD EventSubscriptions"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 4-4
{
    //This event subscriber method ensures that when a new record is inserted into the "Res. Ledger Entry" table, 
    // the fields CSD Seminar No. and CSD Seminar Registration No. are populated with the corresponding values 
    // from the "Res. Journal Line" record.

    [EventSubscriber(ObjectType::Codeunit, 212, 'OnBeforeResLedgEntryInsert', '', true, true)]
    local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry";
  ResJournalLine: Record "Res. Journal Line");
    begin
        ResLedgerEntry."CSD Seminar No." := ResJournalLine."CSD Seminar No.";
        ResLedgerEntry."CSD Seminar Registration No." := ResJournalLine."CSD Seminar Registration No.";
    end;
    //Add code to the procedure to enable Navigate to find records from the Posted Seminar Reg. Header table
    [EventSubscriber(ObjectType::Page, 344, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry";
    DocNoFilter: Text;
    PostingDateFilter: Text);
    var
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
        PostedSeminerRegHeader: Record "CSD Posted Seminar Reg. Header";
        DocNoOfRecords: Integer;
        NextEntryNo: Integer;
    begin
        if PostedSeminerRegHeader.ReadPermission then begin
            PostedSeminerRegHeader.Reset;
            PostedSeminerRegHeader.SetFilter("No.", DocNoFilter);
            PostedSeminerRegHeader.SetFilter("Posting Date", PostingDateFilter);
            DocNoOfRecords := PostedSeminerRegHeader.Count;

            with DocumentEntry do begin
                if DocNoOfRecords = 0 then
                    exit;
                if FindLast then
                    NextEntryNo := "Entry No." + 1
                else
                    NextEntryNo := 1;
                Init;
                "Entry No." := NextEntryNo + 1;
                "Table ID" := Database::"CSD Posted Seminar Reg. Header";
                "Document Type" := 0;
                "Table Name" := CopyStr(PostedSeminerRegHeader.TableCaption, 1, MaxStrLen("Table Name"));
                "No. of Records" := DocNoOfRecords;
                Insert;
            end;
        end;
    end;
    //Add code to the procedure to enable Navigate to show records from both the
    // Seminar Ledger Entries and the Posted Seminar Reg. Header tables
    // filtered with the DocNoFilter and PostingDateFilter.
    [EventSubscriber(ObjectType::Page, 344, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateShowRecords
    (TableID: Integer;
    DocNoFilter: Text;
    PostingDateFilter: Text;
    ItemTrackingSearch: Boolean);
    var
        SeminarLedgerEntry: record "CSD Seminar Ledger Entry";
        PostedSeminarRegHeader: record "CSD Posted Seminar Reg. Header";
    begin
        case TableID of
            Database::"CSD Posted Seminar Reg. Header":
                begin
                    PostedSeminarRegHeader.SetFilter("No.", DocNoFilter);
                    PostedSeminarRegHeader.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, PostedSeminarRegHeader);
                end;
            Database::"CSD Seminar Ledger Entry":
                begin
                    SeminarLedgerEntry.SetFilter("Document No.", DocNoFilter);
                    SeminarLedgerEntry.SetFilter("Posting Date", PostingDateFilter);
                    Page.Run(0, SeminarLedgerEntry);
                end;
        end;
    end;
}