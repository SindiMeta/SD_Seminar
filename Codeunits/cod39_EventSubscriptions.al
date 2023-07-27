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

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Sales-Post", 'OnBeforePostLines', '', true, true)]
    local procedure "Sales-Post_OnBeforePostLines"
    (
        var SalesLine: Record "Sales Line";
        SalesHeader: Record "Sales Header";
        CommitIsSuppressed: Boolean;
        PreviewMode: Boolean
    )
    var

        ItemRegHeader: Record "CSD Item Reg. Header";
        Item: Record Item;
        ErrorMsg: Text;
        MinimumErr: Label 'Kujdes ju keni tejkaluar sasine minimum te inventarit per artikullin %1 ne magazinen %2.';
        MinimumNoLocationErr: Label 'Kujdes ju keni tejkaluar sasine minimum te inventarit per artikullin %1.';
    begin

        if SalesLine.Type <> SalesLine.Type::Item then
            exit;
        if not ItemRegHeader.Get(SalesLine."No.", SalesLine."Location Code") then
            exit;
        Item.Get(SalesLine."No.");

        if SalesLine."Location Code" <> '' then begin
            Item.SetFilter("Location Filter", SalesLine."Location Code");
            ErrorMsg := StrSubstNo(MinimumErr, SalesLine."No.", SalesLine."Location Code");
        end else
            ErrorMsg := StrSubstNo(MinimumNoLocationErr, SalesLine."No.");
        if Item.Inventory - SalesLine.Quantity < ItemRegHeader."Minimum Quantity" then
            Error(ErrorMsg);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Purch.-Post", 'OnBeforePostLines', '', true, true)]
    local procedure "Purch.-Post_OnBeforePostLines"
    (
        var PurchLine: Record "Purchase Line";
        PurchHeader: Record "Purchase Header";
        PreviewMode: Boolean;
        CommitIsSupressed: Boolean;
        var TempPurchLineGlobal: Record "Purchase Line"
    )
    var

        ItemRegHeader: Record "CSD Item Reg. Header";

        Item: Record Item;

        ErrorMsg: Text;
        MaximumErr: Label 'Kujdes ju keni tejkaluar sasine Maximum te inventarit per artikullin %1 ne magazinen %2.';
        MaximumNoLocationErr: Label 'Kujdes ju keni tejkaluar sasine Maximum te inventarit per artikullin %1.';
    begin
        if PurchLine.Type <> PurchLine.Type::Item then
            exit;
        if not ItemRegHeader.Get(PurchLine."No.", PurchLine."Location Code") then
            exit;
        Item.Get(PurchLine."No.");

        if PurchLine."Location Code" <> '' then begin
            Item.SetFilter("Location Filter", PurchLine."Location Code");
            ErrorMsg := StrSubstNo(MaximumErr, PurchLine."No.", PurchLine."Location Code");
        end else
            ErrorMsg := StrSubstNo(MaximumNoLocationErr, PurchLine."No.");

        Item.CalcFields(Inventory);

        if Item.Inventory + PurchLine.Quantity > ItemRegHeader."Maximum Quantity" then
            Error(ErrorMsg);
    end;

    [EventSubscriber(ObjectType::Codeunit, Codeunit::"Item Jnl.-Post Line", 'OnBeforePostItemJnlLine', '', true, true)]
    local procedure "Item Jnl.-Post Line_OnBeforePostItemJnlLine"
        (
            var ItemJournalLine: Record "Item Journal Line";
            CalledFromAdjustment: Boolean;
            CalledFromInvtPutawayPick: Boolean;
            var ItemRegister: Record "Item Register";
            var ItemLedgEntryNo: Integer;
            var ValueEntryNo: Integer;
            var ItemApplnEntryNo: Integer
        )
    var
        ItemRegHeader: Record "CSD Item Reg. Header";
        Item: Record Item;
        ErrorMsg: Text;
        MinimumErr: Label 'Kujdes ju keni tejkaluar sasine minimum te inventarit per artikullin %1 ne magazinen %2.';
        MinimumNoLocationErr: Label 'Kujdes ju keni tejkaluar sasine minimum te inventarit per artikullin %1.';
        MaximumErr: Label 'Kujdes ju keni tejkaluar sasine Maximum te inventarit per artikullin %1 ne magazinen %2.';
        MaximumNoLocationErr: Label 'Kujdes ju keni tejkaluar sasine Maximum te inventarit per artikullin %1.';
    begin

        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Sale then begin
            Item.SetRange("No.", ItemJournalLine."Item No.");
            if item.FindSet() then begin

                if ItemJournalLine."Location Code" <> '' then begin
                    ErrorMsg := StrSubstNo(MinimumErr, ItemJournalLine."Item No.", ItemJournalLine."Location Code");
                end else
                    ErrorMsg := StrSubstNo(MinimumNoLocationErr, ItemJournalLine."Item No.");
                Item.CalcFields(Inventory);

                ItemRegHeader.SetRange("Item Code", Item."No.");
                ItemRegHeader.SetRange("Location Code", ItemJournalLine."Location Code");
                if ItemRegHeader.FindSet() then
                    if Item.Inventory - ItemJournalLine.Quantity < ItemRegHeader."Minimum Quantity" then
                        Error(ErrorMsg);
            end;
        end;

        if ItemJournalLine."Entry Type" = ItemJournalLine."Entry Type"::Purchase then begin
            Item.SetRange("No.", ItemJournalLine."Item No.");
            if item.FindSet() then begin


                if ItemJournalLine."Location Code" <> '' then begin

                    ErrorMsg := StrSubstNo(MaximumErr, ItemJournalLine."Item No.", ItemJournalLine."Location Code");
                end else
                    ErrorMsg := StrSubstNo(MaximumNoLocationErr, ItemJournalLine."Item No.");
                Item.CalcFields(Inventory);

                ItemRegHeader.SetRange("Item Code", Item."No.");
                ItemRegHeader.SetRange("Location Code", ItemJournalLine."Location Code");
                if ItemRegHeader.FindSet() then
                    if Item.Inventory + ItemJournalLine.Quantity > ItemRegHeader."Maximum Quantity" then
                        Error(ErrorMsg);
            end;
        end;
    end;










}
