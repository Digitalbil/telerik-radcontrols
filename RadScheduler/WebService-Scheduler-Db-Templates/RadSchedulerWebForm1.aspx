<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadSchedulerWebForm1.aspx.cs" Inherits="RadSchedulerWebForm1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
	<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
       <%--<Templates>--%>
    <script id="tmplAppDescription" type="text/x-jquery-tmpl">
               <a style='font-style:italic;'>${CustomAttribute}</a>
    </script>
    <%--</Templates>--%>
    
	<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
		
	</telerik:RadScriptManager>
 
	<script type="text/javascript">

	    var teacherID = "all";

	    function OnClientSelectedIndexChanged(sender, args) {
	        teacherID = args.get_item().get_value();
	        var scheduler = $find('<%=RadScheduler1.ClientID %>');
            scheduler.rebind();
        }

        function OnClientAppointmentsPopulating(sender, eventArgs) {
            eventArgs.get_schedulerInfo().TeacherID = teacherID;
        }

        function OnClientDataBound(scheduler) {
            var $ = jQuery;
            $(".rsAptDelete").each(function () {
                var apt = scheduler.getAppointmentFromDomElement(this);
                // creating an object containing the data that should be applied on the template
                var tmplValue = { CustomAttribute: ": " + apt.get_attributes().getAttribute("Test") };
                // instantiate the template, populate it and insert before the delete handler (".rsAptDelete")
                $("#tmplAppDescription").tmpl(tmplValue).insertBefore(this);
            });


        }



    </script>
    <p>
        Filter appointments by teacher (resource):
    </p>
    <p>
        <telerik:RadComboBox ID="RadComboBox1" runat="server" OnClientSelectedIndexChanged="OnClientSelectedIndexChanged">
            <Items>
                <telerik:RadComboBoxItem Text="All" Value="all" />
                <telerik:RadComboBoxItem Text="Teacher 1" Value="1" />
                <telerik:RadComboBoxItem Text="Teacher 2" Value="2" />
            </Items>
        </telerik:RadComboBox>
    </p>
 
        <telerik:RadScheduler ID="RadScheduler1" runat="server" OnClientAppointmentsPopulating="OnClientAppointmentsPopulating" 
              EnableDescriptionField="true" _GroupBy="Teacher" _Skin="Forest" OnClientDataBound="OnClientDataBound"
        ShowFullTime="false" SelectedView="MonthView" CustomAttributeNames="Test" EnableCustomAttributeEditing="true"
        StartInsertingInAdvancedForm="True" Height="600px" Width="100%" OverflowBehavior="Scroll"
      
     
        WorkDayEndTime="23:59:59" WorkDayStartTime="00:00:00" DayEndTime="23:59:59" DayStartTime="00:00:00">
            <MonthView VisibleAppointmentsPerDay="5" />
         <AppointmentTemplate>
            <asp:HyperLink ID="HyperLink1" runat="server"><%# Eval("Subject")%></asp:HyperLink>
        </AppointmentTemplate>
        <WebServiceSettings Path="SchedulerWebService.asmx" ResourcePopulationMode="ServerSide" />
        <ResourceStyles>
            <telerik:ResourceStyleMapping Type="Teacher" Key="1" BackColor="Orange" />
            <telerik:ResourceStyleMapping Type="Teacher" Key="2" BackColor="Aqua" />
        </ResourceStyles>
         <TimeSlotContextMenus>
            <telerik:RadSchedulerContextMenu ID="RadSchedulerContextMenu1" runat="server">
                <Items>
                    <telerik:RadMenuItem Text="New Appointment" Value="CommandAddAppointment" />
                    <telerik:RadMenuItem Text="New All Day Event" />
                    <telerik:RadMenuItem IsSeparator="True" />
                    <telerik:RadMenuItem Text="New Recurring Appointment" Value="CommandAddRecurringAppointment" />
                    <telerik:RadMenuItem Text="New Recurring Event" />
                    <telerik:RadMenuItem IsSeparator="True" />
                    <telerik:RadMenuItem Text="Go to today" Value="CommandGoToToday" />
                    <telerik:RadMenuItem Text="Show 24 hours..." Value="CommandShow24Hours" />
                </Items>
            </telerik:RadSchedulerContextMenu>
        </TimeSlotContextMenus>
    </telerik:RadScheduler>
    </form>
</body>
</html>
