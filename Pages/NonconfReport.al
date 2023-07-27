page 50125 "Nonconfor Report Selection"
{

    Caption = 'Nonconformance Report Selection';
    PageType = Worksheet;
    SaveValues = true;
    SourceTable = "Nonconf Report Selections";


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
                Visible = false;
            }
            systempart("Notes"; Notes)
            {
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
