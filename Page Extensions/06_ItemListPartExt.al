pageextension 50132 "CSD ItemListPartExt" extends "Item Avail. by Location Lines"
{
    layout
    {
        addafter("Item.Inventory")
        {
            field("Available Quantity"; Rec."Available Quantity")
            {
                Caption = 'Available Quantity';
                ApplicationArea = All;
            }
        }
    }


}
