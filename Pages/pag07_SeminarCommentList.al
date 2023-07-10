page 50107 "CSD Seminar Comment List"
// CSD1.00 - 2018-01-01 - D. E. Veloper
//Lab 5.3: Task 2
{
    Caption = 'Seminar Comment List';
    Editable = false;
    PageType = List;
    SourceTable = "CSD Seminar Comment Line";

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
}