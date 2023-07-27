table 50130 "CSD Item Reg. Header"
{
    Caption = 'Item Registration Header';


    fields
    {
        field(1; "Item Code"; Code[20])
        {
            Caption = 'Item Code';
            TableRelation = Item;
        }
        field(2; "Location Code"; Code[10])
        {
            Caption = 'Location Code';
            TableRelation = Location;
        }
        field(3; "Minimum Quantity"; Decimal)
        {
            Caption = 'Minimum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
        field(4; "Maximum Quantity"; Decimal)
        {
            Caption = 'Maximum Quantity';
            DecimalPlaces = 0 : 5;
            MinValue = 0;
        }
    }

    keys
    {
        key(Key1; "Item Code", "Location Code")
        {
            Clustered = true;
        }
    }
}