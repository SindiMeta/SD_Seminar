page 50123 "CSD Seminar Report Selection"
{
    ApplicationArea = All;
    // CSD1.00 - 2018-01-01 - D. E. Veloper
    //   Chapter 9 - Lab 1
    //     - Created new page

    Caption = 'Seminar Report Selection';
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "CSD Seminar Report Selections";
    UsageCategory = Administration;

    layout
    {
        area(Content)
        {
            field(ReportUsage2; ReportUsage2)
            {
                ApplicationArea = All;
                Caption = 'Usage';
                OptionCaption = 'Registration';

                trigger OnValidate();
                begin
                    SetUsageFilter();
                    ReportUsage2OnAfterValidate();
                end;
            }
            repeater(General)
            {
                field(Sequence; Rec.Sequence)
                {
                    ApplicationArea = All;
                }
                field("Report ID"; Rec."Report ID")
                {
                    ApplicationArea = All;
                    LookupPageId = Objects;
                }
                field("Report Name"; Rec."Report Name")
                {
                    ApplicationArea = All;
                    DrillDown = false;
                    LookupPageId = Objects;
                }
            }
        }
        area(FactBoxes)
        {
            systempart("Links"; Links)
            {
                ApplicationArea = All;
                Caption = 'Links';
                Visible = false;
            }
            systempart("Notes"; Notes)
            {
                ApplicationArea = All;
                Caption = 'Notes';
                Visible = false;
            }
        }
    }

    trigger OnNewRecord(BelowxRec: Boolean);
    begin
        Rec.NewRecord();
    end;

    trigger OnOpenPage();
    begin
        SetUsageFilter();
    end;

    var
        ReportUsage2: Option Registration;

    local procedure SetUsageFilter();
    begin
        Rec.FilterGroup(2);
        case ReportUsage2 of
            ReportUsage2::Registration:
                Rec.SetRange(Usage, Rec.Usage::Registration);
        end;
        Rec.FilterGroup(0);
    end;

    local procedure ReportUsage2OnAfterValidate();
    begin
        CurrPage.Update();
    end;
}
