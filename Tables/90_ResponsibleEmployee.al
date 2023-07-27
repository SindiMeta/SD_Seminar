table 50129 "Responsible Employee Line"
{
    Caption = 'Responsible Employee';

    fields
    {
        field(10; "Document No."; Code[20])
        {
            Caption = 'Document No.';
            TableRelation = "Nonconf Quality Report";
        }
        field(20; "Line No."; Integer)
        {
            Caption = 'Line No.';

        }
        field(1; "No."; Code[20])
        {
            Caption = 'No.';
            TableRelation = Employee;


            trigger OnValidate();
            begin
                CalcFields("Employee");
            end;
        }
        field(2; "Employee"; Text[250])
        {
            Caption = 'Employee';
            CalcFormula = lookup(Employee."Search Name" where("No." = field("No.")));
            Editable = false;
            FieldClass = FlowField;
        }
    }

    keys
    {
        key(Key1; "Document No.", "Line No.")
        {
            Clustered = true;
        }
    }

    var
        myInt: Integer;

    trigger OnInsert()
    begin

    end;

    trigger OnModify()
    begin

    end;

    trigger OnDelete()
    begin

    end;

    trigger OnRename()
    begin

    end;

}