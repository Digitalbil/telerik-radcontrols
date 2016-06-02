<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RadSchedulerWebForm.aspx.cs"
    Inherits="RadSchedulerWebForm" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        <Scripts>
            <%--Needed for JavaScript IntelliSense in VS2010--%>
            <%--For VS2008 replace RadScriptManager with ScriptManager--%>
            <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
        </Scripts>
    </telerik:RadScriptManager>
   
    <telerik:RadScheduler runat="server" ID="RadScheduler1" 
         DataRecurrenceField="RecurrenceRule" DataRecurrenceParentKeyField="RecurrenceParentID" DataKeyField="ID"
        DataSourceID="SqlDataSource1" DataSubjectField="Subject" DataStartField="Start" DataEndField="End" 
         EnableDescriptionField="True">
           <ResourceTypes>
                <telerik:ResourceType KeyField="ID" Name="Room" TextField="RoomName" ForeignKeyField="RoomID"
                    DataSourceID="RoomsDataSource"></telerik:ResourceType>
                <telerik:ResourceType KeyField="ID" Name="User" TextField="UserName" ForeignKeyField="UserID"
                    DataSourceID="UsersDataSource"></telerik:ResourceType>
            </ResourceTypes>
        <AppointmentTemplate>
               
                <div style="font-style: italic; background-color: Lime"><%# Eval("Start")%></div>
            </AppointmentTemplate>
        <Reminders Enabled="True" />
    </telerik:RadScheduler>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [Appointments] WHERE [ID] = @ID" InsertCommand="INSERT INTO [Appointments] ([Subject], [Start], [End], [UserID], [RoomID], [RecurrenceRule], [RecurrenceParentID], [Annotations], [Description], [Reminder], [LastModified]) VALUES (@Subject, @Start, @End, @UserID, @RoomID, @RecurrenceRule, @RecurrenceParentID, @Annotations, @Description, @Reminder, @LastModified)"
        SelectCommand="SELECT * FROM [Appointments]" UpdateCommand="UPDATE [Appointments] SET [Subject] = @Subject, [Start] = @Start, [End] = @End, [UserID] = @UserID, [RoomID] = @RoomID, [RecurrenceRule] = @RecurrenceRule, [RecurrenceParentID] = @RecurrenceParentID, [Annotations] = @Annotations, [Description] = @Description, [Reminder] = @Reminder, [LastModified] = @LastModified WHERE [ID] = @ID">
        <DeleteParameters>
            <asp:Parameter Name="ID" Type="Int32" />
        </DeleteParameters>
        <InsertParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Start" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="RoomID" Type="Int32" />
            <asp:Parameter Name="RecurrenceRule" Type="String" />
            <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
            <asp:Parameter Name="Annotations" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Reminder" Type="String" />
            <asp:Parameter Name="LastModified" Type="String" />
        </InsertParameters>
        <UpdateParameters>
            <asp:Parameter Name="Subject" Type="String" />
            <asp:Parameter Name="Start" Type="DateTime" />
            <asp:Parameter Name="End" Type="DateTime" />
            <asp:Parameter Name="UserID" Type="Int32" />
            <asp:Parameter Name="RoomID" Type="Int32" />
            <asp:Parameter Name="RecurrenceRule" Type="String" />
            <asp:Parameter Name="RecurrenceParentID" Type="Int32" />
            <asp:Parameter Name="Annotations" Type="String" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="Reminder" Type="String" />
            <asp:Parameter Name="LastModified" Type="String" />
            <asp:Parameter Name="ID" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
         <asp:SqlDataSource ID="RoomsDataSource" runat="server"
       ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Rooms]">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="UsersDataSource" runat="server" 
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT * FROM [Users] ORDER BY UserName DESC">
    </asp:SqlDataSource>
    </form>
</body>
</html>
