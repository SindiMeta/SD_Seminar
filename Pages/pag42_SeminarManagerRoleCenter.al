page 50142 "CSD Seminar Manager RoleCenter"
// CSD1.00 - 2018-01-01 - D. E. Veloper
// Chapter 10 - Lab 1 - 5
// - Created new page
{
    Caption = 'Seminar Manager RoleCenter';
    PageType = RoleCenter;
    UsageCategory = Administration;
    ApplicationArea = all;



    layout
    {
        area(RoleCenter)
        {
            group(Column1)
            {
                part(Activities; "CSD Seminar Manager Activities")
                {
                    ApplicationArea = all;
                    Caption = 'Activities';
                }
                part(MySeminars; "CSD My Seminars")
                {
                    ApplicationArea = all;
                    Caption = 'My Seminars';
                }
            }
            group(Column2)
            {
                part(MyCustomers; "My Customers")
                {
                    ApplicationArea = all;
                    Caption = 'My Customers';
                }
                systempart(MyNotifications; MyNotes)
                {
                    ApplicationArea = all;
                    Caption = 'My Notifications';
                }
                part(ReportInbox; "Report Inbox Part")
                {
                    ApplicationArea = all;
                    Caption = 'Report Inbox';
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
                RunObject = Page "CSD Posted Seminar Reg. List";
                ToolTip = 'Create seminar registrations';
            }

            action(Seminars)
            {
                Caption = 'Seminars';
                ApplicationArea = all;
                Image = List;
                RunObject = Page "CSD Seminar List";
                ToolTip = 'View all seminars';
            }

            action(Instructors)
            {
                ApplicationArea = all;
                Caption = 'Instructors';
                RunObject = Page "Resource List";
                RunPageView = WHERE(Type = const(Person));
                ToolTip = 'View all resources registeres as persons';
            }

            action(Rooms)
            {
                ApplicationArea = all;
                Caption = 'Rooms';
                RunObject = Page "Resource List";
                RunPageView = WHERE(Type = const(Machine));
                ToolTip = 'View all resources registeres as machines';
            }

            action("Sales Invoices")
            {

                Caption = 'Sales Invoices';
                ApplicationArea = Basic, Suite;
                Image = Invoice;
                RunObject = Page "Sales Invoice List";
                ToolTip = 'Register your sales to customers';
            }

            action("Sales Credit Memos")
            {
                ApplicationArea = all;
                Caption = 'Sales Credit Memos';
                RunObject = Page "Sales Credit Memos";
                ToolTip = 'Revert the financial transactions involved when your customers want to cancel a purchase';
            }

            action(Customers)
            {
                ApplicationArea = all;
                Caption = 'Customers';
                Image = Customer;
                RunObject = Page "Customer List";
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
                    ApplicationArea = all;
                    Caption = 'Posted Seminar Registrations';
                    Image = Timesheet;
                    RunObject = Page "CSD Posted Seminar Reg. List";
                    ToolTip = 'Open the list of posted Registrations.';

                }

                action("Posted Sales Invoices")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Sales Invoices';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Invoices";
                    ToolTip = 'Open the list of posted sales invoices.';
                }

                action("Posted Sales Credit Memos")
                {
                    ApplicationArea = all;
                    Caption = 'Posted Sales Credit Memos';
                    Image = PostedOrder;
                    RunObject = Page "Posted Sales Credit Memos";
                    ToolTip = 'Open the list of posted sales credit memos.';
                }

                action("Registers")
                {
                    ApplicationArea = all;
                    Caption = 'Seminar Registers';
                    Image = PostedShipment;
                    RunObject = Page "CSD Seminar Registers";
                    ToolTip = 'Open the list of Seminar Registers.';

                }
            }

        }

        area(Creation)
        {
            action(NewSeminarRegistration)
            {
                ApplicationArea = all;
                Caption = 'Seminar Registration';
                Image = NewTimesheet;
                RunObject = page "CSD Seminar Registration";
                RunPageMode = Create;
            }

            action(NewSalesInvoice)
            {
                ApplicationArea = all;
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
                ApplicationArea = all;
                Caption = 'Create Invoices';
                Image = CreateJobSalesInvoice;
                RunObject = report "Create Seminar Invoices";
            }

            action(Navigate)
            {
                ApplicationArea = all;
                Caption = 'Navigate';
                Image = Navigate;
                RunObject = page Navigate;
                RunPageMode = Edit;
            }
        }
    }
}