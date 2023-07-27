pageextension 50140 "CSD TransferOrder" extends "Transfer Order"
{
    layout
    {

    }

    actions
    {

        modify(Post)
        {
            trigger OnBeforeAction()
            var
                TransferLine: Record "Transfer Line";
                ItemRegHeader: Record "CSD Item Reg. Header";
                Item: Record Item;
                MinimumErr: Label 'Kujdes ju keni tejkaluar sasine minimum te inventarit per artikullin %1 ne magazinen %2.';
                MaximumErr: Label 'Kujdes ju keni tejkaluar sasine Maximum te inventarit per artikullin %1 ne magazinen %2.';


            begin
                TransferLine.Reset();
                TransferLine.SetRange("Document No.", Rec."No.");
                if TransferLine.FindSet() then begin
                    Item.SetRange("No.", TransferLine."Item No.");
                    if Item.FindSet() then begin
                        ItemRegHeader.SetRange("Item Code", Item."No.");
                        ItemRegHeader.SetRange("Location Code", Rec."Transfer-from Code");
                        if ItemRegHeader.FindSet() then begin
                            if Item.Inventory - TransferLine.Quantity < ItemRegHeader."Minimum Quantity" then
                                error(MinimumErr, TransferLine."Item No.", Rec."Transfer-from Code");
                        end;

                        ItemRegHeader.SetRange("Item Code", Item."No.");
                        ItemRegHeader.SetRange("Location Code", Rec."Transfer-to Code");
                        if ItemRegHeader.FindSet() then begin
                            if Item.Inventory + TransferLine.Quantity > ItemRegHeader."Minimum Quantity" then
                                error(MaximumErr, TransferLine."Item No.", Rec."Transfer-to Code")
                        end;
                        ;

                    end;
                end;
            end;
        }
    }

    var
        myInt: Integer;
}