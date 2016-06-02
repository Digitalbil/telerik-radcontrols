<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadSchedulerAdvancedForm.aspx.cs"
	Inherits="RadSchedulerAdvancedForm" %>

<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="scheduler" TagName="AdvancedForm" Src="AdvancedForm.ascx" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/tr/xhtml11/dtd/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
	<style type="text/css">
		.RadScheduler .rsAdvancedEdit .RadColorPicker label
		{
			text-align: left;
			display: block;
			padding: 0;
		}
	</style>
	<telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <title></title>
</head>
<body class="BODY">
	<form id="Form1" method="post" runat="server">
	<telerik:RadScriptManager ID="RadScriptManager1" runat="server">
		<Scripts>
			<asp:ScriptReference Path="AdvancedForm.js" />
			<%--Needed for JavaScript IntelliSense in VS2010--%>
			<%--For VS2008 replace RadScriptManager with ScriptManager--%>
			<asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
		</Scripts>
	</telerik:RadScriptManager>
	<script type="text/javascript">	
		//<![CDATA[

		// Dictionary containing the advanced template client object
		// for a given RadScheduler instance (the control ID is used as key).
		var schedulerTemplates = {};

		function schedulerFormCreated(scheduler, eventArgs) {
			// Create a client-side object only for the advanced templates
			var mode = eventArgs.get_mode();
			if (mode == Telerik.Web.UI.SchedulerFormMode.AdvancedInsert ||
					mode == Telerik.Web.UI.SchedulerFormMode.AdvancedEdit) {
				// Initialize the client-side object for the advanced form
				var formElement = eventArgs.get_formElement();
				var templateKey = scheduler.get_id() + "_" + mode;
				var advancedTemplate = schedulerTemplates[templateKey];
				if (!advancedTemplate) {
					// Initialize the template for this RadScheduler instance
					// and cache it in the schedulerTemplates dictionary
					var schedulerElement = scheduler.get_element();
					var isModal = scheduler.get_advancedFormSettings().modal;
					advancedTemplate = new window.SchedulerAdvancedTemplate(schedulerElement, formElement, isModal);
					advancedTemplate.initialize();

					schedulerTemplates[templateKey] = advancedTemplate;

					// Remove the template object from the dictionary on dispose.
					scheduler.add_disposing(function () {
						schedulerTemplates[templateKey] = null;
					});
				}

				// Are we using Web Service data binding?
				if (!scheduler.get_webServiceSettings().get_isEmpty()) {
					// Populate the form with the appointment data
					var apt = eventArgs.get_appointment();
					var isInsert = mode == Telerik.Web.UI.SchedulerFormMode.AdvancedInsert;
					advancedTemplate.populate(apt, isInsert);
				}
			}
		}
		//]]>
	</script>
	<div class="exampleContainer">
		<telerik:RadScheduler runat="server" ID="RadScheduler1"  OnDataBound="RadScheduler1_DataBound"
            RenderMode="Lightweight" SelectedView="WeekView"
			AppointmentStyleMode="Default" OnAppointmentDataBound="RadScheduler1_AppointmentDataBound"
			OnClientFormCreated="schedulerFormCreated" CustomAttributeNames="AppointmentColor"
			EnableDescriptionField="true">
			<AdvancedForm Modal="true" EnableTimeZonesEditing="true" />
			<Reminders Enabled="true"/>
			<AdvancedEditTemplate>
				<scheduler:AdvancedForm runat="server" ID="AdvancedEditForm1" Mode="Edit" Subject='<%# Bind("Subject") %>'
					Description='<%# Bind("Description") %>' Start='<%# Bind("Start") %>' End='<%# Bind("End") %>'
					RecurrenceRuleText='<%# Bind("RecurrenceRule") %>' Reminder='<%# Bind("Reminder") %>'
					AppointmentColor='<%# Bind("AppointmentColor") %>' UserID='<%# Bind("User") %>'
					RoomID='<%# Bind("Room") %>' TimeZoneID='<%# Bind("TimeZoneID") %>'  />
			</AdvancedEditTemplate>
			<AdvancedInsertTemplate>
				<scheduler:AdvancedForm runat="server" ID="AdvancedInsertForm1" Mode="Insert" Subject='<%# Bind("Subject") %>'
					Start='<%# Bind("Start") %>' End='<%# Bind("End") %>' Description='<%# Bind("Description") %>'
					RecurrenceRuleText='<%# Bind("RecurrenceRule") %>' Reminder='<%# Bind("Reminder") %>'
					AppointmentColor='<%# Bind("AppointmentColor") %>' UserID='<%# Bind("User") %>'
					RoomID='<%# Bind("Room") %>' TimeZoneID='<%# Bind("TimeZoneID") %>'   />
			</AdvancedInsertTemplate>
			<TimelineView UserSelectable="false" />
			<TimeSlotContextMenuSettings EnableDefault="true" />
			<AppointmentContextMenuSettings EnableDefault="true" />
            <WebServiceSettings Path="SchedulerWebService.asmx" ResourcePopulationMode="ServerSide" UpdateMode="Single" />
		</telerik:RadScheduler>
	</div>
	</form>
</body>
</html>
