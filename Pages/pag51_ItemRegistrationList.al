page 50132 "CSD Item Registration List"
{
    ApplicationArea = all;
    Caption = 'Item Registration List';
    PageType = List;
    SourceTable = "CSD Item Reg. Header";
    UsageCategory = lists;

    layout
    {
        area(Content)
        {
            repeater(Group)
            {
                field("Item Code"; Rec."Item Code")
                {
                    ApplicationArea = all;
                }
                field("Location Code"; Rec."Location Code")
                {
                    ApplicationArea = all;
                }
                field("Minimum Order Quantity"; Rec."Minimum Quantity")
                {
                    ApplicationArea = all;
                }
                field("Maximum Order Quantity"; Rec."Maximum Quantity")
                {
                    ApplicationArea = all;
                }
            }
        }
    }
}