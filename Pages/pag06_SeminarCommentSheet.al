//lejon users te fusin dhe ndryshojne te dhena ne Seminar Comment Line table
page 50106 "CSD Seminar Comment Sheet"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.3: Task 2
{
    AutoSplitKey = true;
    Caption = 'Seminar Comment Sheet';
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";
    UsageCategory = Lists;

    layout
    {
        area(Content)

        {
            repeater(Group)
            {
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Code; Rec.Code)
                {
                    Visible = false;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    trigger OnNewRecord(BelowxRec: Boolean)

    begin
        Rec.SetupNewLine();
    end;
}