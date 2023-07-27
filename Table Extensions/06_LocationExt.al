tableextension 50135 "CSD LocationExt" extends Location
{
    fields
    {
        field(50001; "Available Quantity"; Decimal)
        {
            Caption = 'Available Quantity';
            DataClassification = CustomerContent;
            Editable = false;
        }
    }

}