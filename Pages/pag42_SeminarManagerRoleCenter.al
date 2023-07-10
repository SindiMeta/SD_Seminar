page 50142 "CSD Seminar Manager RoleCenter"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 10 - Lab 1 - 5
// - Created new page
{
    Caption = 'Seminar Manager RoleCenter';
    PageType = RoleCenter;

    layout
    {
        area(RoleCenter)
        {
            group(Column1)
            {
                part(Activities; "CSD Seminar Manager Activities")
                {
                    ApplicationArea = All;
                }
                part(MySeminars; "CSD My Seminars")
                {
                    ApplicationArea = All;
                }
            }
            group(Column2)
            {
                part(MyCustomers; "My Customers")
                {
                    ApplicationArea = All;
                }
                systempart(MyNotifications; MyNotes)
                {
                    ApplicationArea = All;
                }
                part(ReportInbox; "Report Inbox Part")
                {
                    ApplicationArea = All;
                }
            }
        }
    }

    actions
    {
        area(Embedding)
        {
            action(SeminarRegistrations)
            {
                ApplicationArea = All;
                Caption = 'Seminar Registrations';
                Image = List;
                RunObject = page "CSD Posted Seminar Reg. List";
                ToolTip = 'Create seminar registrations';
            }

            action(Seminars)
            {
                ApplicationArea = All;
                Caption = 'Seminars';
                Image = List;
                RunObject = page "CSD Seminar List";
                ToolTip = 'View all seminars';
            }

            action(Instructors)
            {
                ApplicationArea = All;
                Caption = 'Instructors';
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Person));
                ToolTip = 'View all resources registeres as persons';
            }

            action(Rooms)
            {
                ApplicationArea = All;
                Caption = 'Rooms';
                RunObject = page "Resource List";
                RunPageView = where(Type = const(Machine));
                ToolTip = 'View all resources registeres as machines';
            }

            action("Sales Invoices")
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Sales Invoices';
                Image = Invoice;
                RunObject = page "Sales Invoice List";
                ToolTip = 'Register your sales to customers';
            }

            action("Sales Credit Memos")
            {
                ApplicationArea = All;
                Caption = 'Sales Credit Memos';
                RunObject = page "Sales Credit Memos";
                ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase';
            }

            action(Customers)
            {
                ApplicationArea = Basic, Suite;
                Caption = 'Customers';
                Image = Customer;
                RunObject = page "Customer List";
                ToolTip = 'View or edit detailed information for the customers that you trade with';
            }
        }
        area(Sections)
        {
            group("Posted Documents")
            {
                Caption = 'Posted Documents';
                Image = FiledPosted;
                ToolTip = 'View history for sales, shipments, and inventory.';

                action("Posted Seminar Registrations")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Seminar Registrations';
                    Image = Timesheet;
                    RunObject = page "CSD Posted Seminar Reg. List";
                    ToolTip = 'Open the list of posted Registrations.';
                }
                action("Posted Sales Invoices")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }
                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = All;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }
                action(Registers)
                {
                    ApplicationArea = All;
                    Caption = 'Seminar Registers';
                    Image = PostedShipment;
                    RunObject = page "CSD Seminar Registers";
                    ToolTip = 'Open the list of Seminar Registers.';
                }
            }
        }
        area(Creation)
        {
            action(NewSeminarRegistration)
            {
                ApplicationArea = All;
                Caption = 'Seminar Registration';
                Image = NewTimesheet;
                RunObject = page "CSD Seminar Registration";
                RunPageMode = Create;
            }

            action(NewSalesInvoice)
            {
                ApplicationArea = All;
                Caption = 'Sales Invoice';
                Image = NewSalesInvoice;
                RunObject = page "Sales Invoice";
                RunPageMode = Create;
            }
        }
        area(Processing)
        {
            action(CreateInvoices)
            {
                ApplicationArea = All;
                Caption = 'Create Invoices';
                Image = CreateJobSalesInvoice;
                RunObject = report "Create Seminar Invoices";
            }

            action(Navigate)
            {
                ApplicationArea = All;
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = page Navigate;
                RunPageMode = Edit;
            }
        }
    }
}