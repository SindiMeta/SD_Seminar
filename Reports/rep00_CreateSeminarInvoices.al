report 50100 "Create Seminar Invoices"
{
    ApplicationArea = All;
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 9 - Lab 2
    //     - Created new report

    Caption = 'Create Seminar Invoices';
    ProcessingOnly = true;
    UsageCategory = ReportsAndAnalysis;

    dataset
    {
        dataitem("Seminar Ledger Entry"; "CSD Seminar Ledger Entry")
        {
            DataItemTableView = sorting("Bill-to Customer No.", "Seminar No.");
            trigger OnAfterGetRecord();
            begin
                if "Bill-to Customer No." <> Customer."No." then
                    Customer.Get("Bill-to Customer No.");

                if Customer.Blocked in [Customer.Blocked::All, Customer.Blocked::Invoice] then
                    NoofSalesInvErrors := NoofSalesInvErrors + 1
                else begin
                    if "Seminar Ledger Entry"."Bill-to Customer No." <> SalesHeader."Bill-to Customer No." then begin
                        Window.Update(1, "Bill-to Customer No.");
                        if SalesHeader."No." <> '' then
                            FinalizeSalesInvoiceHeader();
                        InsertSalesInvoiceHeader();
                    end;
                    Window.Update(2, "Seminar Registration No.");

                    case Type of
                        Type::Resource:
                            begin
                                SalesLine.Type := SalesLine.Type::Resource;
                                case "Charge Type" of
                                    "Charge Type"::Instructor:
                                        SalesLine."No." := "Instructor Resource No.";
                                    "Charge Type"::Room:
                                        SalesLine."No." := "Room Resource No.";
                                    "Charge Type"::Participant:
                                        SalesLine."No." := "Instructor Resource No.";
                                end;
                            end;
                    end;

                    SalesLine."Document Type" := SalesHeader."Document Type";
                    SalesLine."Document No." := SalesHeader."No.";
                    SalesLine."Line No." := NextLineNo;
                    SalesLine.Validate("No.");
                    Seminar.Get("Seminar No.");
                    if "Seminar Ledger Entry".Description <> '' then
                        SalesLine.Description := "Seminar Ledger Entry".Description
                    else
                        SalesLine.Description := Seminar.Name;

                    SalesLine."Unit Price" := "Unit Price";
                    if SalesHeader."Currency Code" <> '' then begin
                        SalesHeader.TestField("Currency Factor");
                        SalesLine."Unit Price" :=
                          Round(
                            CurrencyExchRate.ExchangeAmtLCYToFCY(
                            WorkDate(), SalesHeader."Currency Code",
                            SalesLine."Unit Price", SalesHeader."Currency Factor"));
                    end;
                    SalesLine.Validate(Quantity, Quantity);
                    SalesLine.Insert();
                    NextLineNo := NextLineNo + 10000;
                end;
            end;

            trigger OnPostDataItem();
            begin
                Window.Close();
                if SalesHeader."No." = '' then
                    Message(Text007)
                else begin
                    FinalizeSalesInvoiceHeader();
                    if NoofSalesInvErrors = 0 then
                        Message(
                          Text005,
                          NoofSalesInv)
                    else
                        Message(
                          Text006,
                          NoofSalesInvErrors)
                end;
            end;

            trigger OnPreDataItem();
            begin
                if PostingDateReq = 0D then
                    Error(Text000);
                if docDateReq = 0D then
                    Error(Text001);

                Window.Open(
                  Text002 +
                  Text003 +
                  Text004);
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(Content)
            {
                group(Options)
                {
                    Caption = 'Options';
                    field(PostingDateReq; PostingDateReq)
                    {
                        Caption = 'Posting Date';
                    }
                    field(docDateReq; docDateReq)
                    {
                        Caption = 'document Date';
                    }
                    field(CalcInvoiceDiscount; CalcInvoiceDiscount)
                    {
                        Caption = 'Calc. Inv. Discount';
                    }
                    field(PostInvoices; PostInvoices)
                    {
                        Caption = 'Post Invoices';
                    }
                }
            }
        }

        trigger OnOpenPage();
        begin
            if PostingDateReq = 0D then
                PostingDateReq := WorkDate();
            if docDateReq = 0D then
                docDateReq := WorkDate();
            SalesSetup.Get();
            CalcInvoiceDiscount := SalesSetup."Calc. Inv. Discount";
        end;
    }

    labels
    {
    }

    var
        Seminar: Record "CSD Seminar";
        CurrencyExchRate: Record "Currency Exchange Rate";
        Customer: Record Customer;
        SalesSetup: Record "Sales & Receivables Setup";
        SalesHeader: Record "Sales Header";
        SalesLine: Record "Sales Line";
        SalesCalcDiscount: Codeunit "Sales-Calc. Discount";
        SalesPost: Codeunit "Sales-Post";
        CalcInvoiceDiscount: Boolean;
        PostInvoices: Boolean;
        OldSeminarNo: Code[20];
        docDateReq: Date;
        PostingDateReq: Date;
        Window: Dialog;
        NextLineNo: Integer;
        NoofSalesInv: Integer;
        NoofSalesInvErrors: Integer;
        Text000: Label 'Please enter the posting date.';
        Text001: Label 'Please enter the document date.';
        Text002: Label 'Creating Seminar Invoices...\\';
        Text003: Label 'Customer No.      #1##########\';
        Text004: Label 'Registration No.   #2##########\';
        Text005: Label 'The number of invoice(s) created is %1.';
        Text006: Label 'not all the invoices were posted. A total of %1 invoices were not posted.';
        Text007: Label 'There is nothing to invoice.';

    local procedure FinalizeSalesInvoiceHeader();
    begin
        if CalcInvoiceDiscount then
            SalesCalcDiscount.Run(SalesLine);
        SalesHeader.Get(SalesHeader."Document Type", SalesHeader."No.");
        Commit();
        Clear(SalesCalcDiscount);
        Clear(SalesPost);
        NoofSalesInv := NoofSalesInv + 1;
        if PostInvoices then begin
            Clear(SalesPost);
            if not SalesPost.Run(SalesHeader) then
                NoofSalesInvErrors := NoofSalesInvErrors + 1;
        end;
    end;

    local procedure InsertSalesInvoiceHeader();
    begin
        SalesHeader.Init();
        SalesHeader."Document Type" := SalesHeader."Document Type"::Invoice;
        SalesHeader."No." := '';
        SalesHeader.Insert(true);
        SalesHeader.Validate("Sell-to Customer No.", "Seminar Ledger Entry"."Bill-to Customer No.");
        if SalesHeader."Bill-to Customer No." <> SalesHeader."Sell-to Customer No." then
            SalesHeader.Validate("Bill-to Customer No.", "Seminar Ledger Entry"."Bill-to Customer No.");
        SalesHeader.Validate("Posting Date", PostingDateReq);
        SalesHeader.Validate("Document Date", docDateReq);
        SalesHeader.Validate("Currency Code", '');
        SalesHeader.Modify();
        Commit();

        NextLineNo := 10000;
        OldSeminarNo := '';
    end;

    local procedure InsertSeminarHeaderLine()
    begin
        if "Seminar Ledger Entry"."Seminar No." <> OldSeminarNo then begin
            SalesLine.Init();
            SalesLine."Document No." := SalesHeader."No.";
            SalesLine."Document Type" := SalesHeader."Document Type";
            SalesLine."Line No." := NextLineNo;
            NextLineNo += 10000;
            Seminar.Get("Seminar Ledger Entry"."Seminar No.");
            if "Seminar Ledger Entry".Description <> '' then
                SalesLine.Description := "Seminar Ledger Entry".Description
            else
                SalesLine.Description := Seminar.Name;
            SalesLine.Insert();
            OldSeminarNo := "Seminar Ledger Entry"."Seminar No.";
        end;
    end;
}
