codeunit 50139 "CSD EventSubscriptions"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 7 - Lab 4-4
{
    //This event subscriber method ensures that when a new record is inserted into the "Res. Ledger Entry" table,
    // the fields CSD Seminar No. and CSD Seminar Registration No. are populated with the corresponding values
    // from the "Res. Journal Line" record.

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Res. Jnl.-Post Line", 'OnBeforeResLedgEntryInsert', '', true, true)]
    local procedure PostResJnlLineOnBeforeResLedgEntryInsert(var ResLedgerEntry: Record "Res. Ledger Entry"; ResJournalLine: Record "Res. Journal Line");
    begin
        ResLedgerEntry."CSD Seminar No." := ResJournalLine."CSD Seminar No.";
        ResLedgerEntry."CSD Seminar Registration No." := ResJournalLine."CSD Seminar Registration No.";
    end;

    //Add code to the procedure to enable Navigate to find records from the Posted Seminar Reg. Header table
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateFindRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateFindRecords(var DocumentEntry: Record "Document Entry";
    DocNoFilter: Text;
    PostingDateFilter: Text);
    var
        PostedSeminerRegHeader: Record "CSD Posted Seminar Reg. Header";
        DocNoOfRecords: Integer;
        NextEntryNo: Integer;
    begin
        if PostedSeminerRegHeader.ReadPermission then begin
            PostedSeminerRegHeader.Reset();
            PostedSeminerRegHeader.SetFilter("No.", DocNoFilter);
            PostedSeminerRegHeader.SetFilter("Posting Date", PostingDateFilter);
            DocNoOfRecords := PostedSeminerRegHeader.Count;

            if DocNoOfRecords = 0 then
                exit;
            if DocumentEntry.FindLast() then
                NextEntryNo := DocumentEntry."Entry No." + 1
            else
                NextEntryNo := 1;
            DocumentEntry.Init();
            DocumentEntry."Entry No." := NextEntryNo + 1;
            DocumentEntry."Table ID" := Database::"CSD Posted Seminar Reg. Header";
            DocumentEntry."Document Type" := DocumentEntry."Document Type"::" ";
            DocumentEntry."Table Name" := CopyStr(PostedSeminerRegHeader.TableCaption, 1, MaxStrLen(DocumentEntry."Table Name"));
            DocumentEntry."No. of Records" := DocNoOfRecords;
            //e ranon kodin brenda me true
            DocumentEntry.Insert();
        end;
    end;

    //Add code to the procedure to enable Navigate to show records from both the
    // Seminar Ledger Entries and the Posted Seminar Reg. Header tables
    // filtered with the DocNoFilter and PostingDateFilter.
    [EventSubscriber(ObjectType::Page, Page::Navigate, 'OnAfterNavigateShowRecords', '', true, true)]
    local procedure ExtendNavigateOnAfterNavigateShowRecords
    (TableID: Integer;
    DocNoFilter: Text;
    PostingDateFilter: Text;
    ItemTrackingSearch: Boolean);
    var
        PostedSeminarRegHeader: Record "CSD Posted Seminar Reg. Header";
        SeminarLedgerEntry: Record "CSD Seminar Ledger Entry";
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