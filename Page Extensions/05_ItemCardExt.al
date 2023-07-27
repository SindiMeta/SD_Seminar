pageextension 50130 "CSD ItemCardExt" extends "Item Card"
{
    layout
    {
        addafter(Inventory)
        {
            field("Available Quantity"; Rec."Available Quantity")
            {
                ApplicationArea = All;
            }
        }
    }
    trigger OnAfterGetCurrRecord()
    var
        myInt: Integer;
    begin
        Rec."Available Quantity" := Rec.Inventory;
    end;

}