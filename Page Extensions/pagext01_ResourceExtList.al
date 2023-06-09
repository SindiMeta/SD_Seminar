pageextension 50110 "CSD ResourceListExt" extends "Resource List"

// CSD1.00 - 2018-02-01 - D. E. Veloper
// Chapter 5 - Lab 1-3

{
    layout
    {
        modify(Type)
        {
            Visible = ShowType;
        }
        addafter(Type)
        {
            field("CSD Resource Type"; Rec."CSD Resource Type")
            {
                ApplicationArea = all;
            }
            field("CSD Maximum Participants"; Rec."CSD Maximum Participants")
            {
                ApplicationArea = all;
                Visible = ShowMaxField;

            }
        }
    }

    trigger OnOpenPage();
    begin


        ShowType := (Rec.GetFilter(Type) = '');
        ShowMaxField := (Rec.GetFilter(Type) = format(Rec.Type::Machine));

    end;

    var
        [InDataSet]
        ShowMaxField: Boolean;
        [InDataSet]
        ShowType: Boolean;
}
