<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">

        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
            </Scripts>
        </telerik:RadScriptManager>

        <h2>Google Calendar Sync</h2>

        .ics URL<telerik:RadTextBox runat="server" ID="calendarUrl" Width="100%" Text="https://www.google.com/calendar/ical/eruc70mj8b0cvq2mi9apfo3bqg%40group.calendar.google.com/public/basic.ics"></telerik:RadTextBox>
        <ul>
            <li>Public Google Calendar: <a href="https://www.google.com/calendar/ical/eruc70mj8b0cvq2mi9apfo3bqg%40group.calendar.google.com/public/basic.ics">https://www.google.com/calendar/ical/eruc70mj8b0cvq2mi9apfo3bqg%40group.calendar.google.com/public/basic.ics</a></li>
            <li>Forumula 1 ics: <a href="https://www.f1calendar.com/download/f1-calendar_p1_p2_p3_q_gp.ics">https://www.f1calendar.com/download/f1-calendar_p1_p2_p3_q_gp.ics</a></li>
        </ul>

        <telerik:RadScheduler ID="RadScheduler1" runat="server" SelectedView="MonthView" Height="100%"
            DataSubjectField="Subject" DataStartField="Start" DataEndField="End" DataKeyField="ID">
        </telerik:RadScheduler>

        <telerik:RadButton runat="server" ID="btnSync" Text="Sync" OnClick="btnSync_Click"></telerik:RadButton>
        <asp:Label runat="server" ID="lblSyncTime"></asp:Label>
    </form>
</body>
</html>
