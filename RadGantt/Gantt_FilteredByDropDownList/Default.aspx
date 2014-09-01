<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />

        <telerik:RadDropDownList runat="server" ID="ddlProject" AutoPostBack="true">
            <Items>
                <telerik:DropDownListItem Text="All Projects" Value="-1" />
                <telerik:DropDownListItem Text="Project 1" Value="1" />
                <telerik:DropDownListItem Text="Project 2" Value="2" />
            </Items>
        </telerik:RadDropDownList>

        <telerik:RadGantt runat="server" ID="RadGantt1" DataSourceID="SqlTasks" DependenciesDataSourceID="SqlDependencies">
            <DataBindings>
                <TasksDataBindings StartField="Start" EndField="End" TitleField="Title" OrderIdField="OrderId" IdField="Id" ParentIdField="ParentId"
                    ExpandedField="Expanded" SummaryField="Summary" PercentCompleteField="PercentComplete" />
                <DependenciesDataBindings IdField="ID" TypeField="Type" PredecessorIdField="PredecessorId" SuccessorIdField="SuccessorId" />
            </DataBindings>
        </telerik:RadGantt>

        <asp:SqlDataSource runat="server" ID="SqlTasks" ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [GanttTasks] WHERE [ID] = @ID"
            InsertCommand="INSERT INTO [GanttTasks] ([ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [ProjectID]) VALUES (@ParentID, @OrderID, @Title, @Start, @End, @PercentComplete, @Expanded, @Summary, @ProjectID)"
            SelectCommand="SELECT * FROM [GanttTasks] WHERE (@ProjectID) = -1 OR ProjectID = @ProjectID"
            UpdateCommand="UPDATE [GanttTasks] SET [ParentID] = @ParentID, [OrderID] = @OrderID, [Title] = @Title, [Start] = @Start, [End] = @End, [PercentComplete] = @PercentComplete, [Expanded] = @Expanded, [Summary] = @Summary, [ProjectID] = @ProjectID WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="ParentID" Type="Int32" />
                <asp:Parameter Name="OrderID" Type="Int32" />
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Start" Type="DateTime" />
                <asp:Parameter Name="End" Type="DateTime" />
                <asp:Parameter Name="PercentComplete" Type="Decimal" />
                <asp:Parameter Name="Expanded" Type="Boolean" />
                <asp:Parameter Name="Summary" Type="Boolean" />
                <asp:Parameter Name="ProjectID" Type="Int32" />
            </InsertParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlProject" Name="ProjectID" PropertyName="SelectedValue" Type="Int32" />
            </SelectParameters>
            <UpdateParameters>
                <asp:Parameter Name="ParentID" Type="Int32" />
                <asp:Parameter Name="OrderID" Type="Int32" />
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Start" Type="DateTime" />
                <asp:Parameter Name="End" Type="DateTime" />
                <asp:Parameter Name="PercentComplete" Type="Decimal" />
                <asp:Parameter Name="Expanded" Type="Boolean" />
                <asp:Parameter Name="Summary" Type="Boolean" />
                <asp:Parameter Name="ProjectID" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="SqlDependencies" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [GanttDependencies] WHERE [ID] = @ID" InsertCommand="INSERT INTO [GanttDependencies] ([PredecessorID], [SuccessorID], [Type]) VALUES (@PredecessorID, @SuccessorID, @Type)" SelectCommand="SELECT * FROM [GanttDependencies]" UpdateCommand="UPDATE [GanttDependencies] SET [PredecessorID] = @PredecessorID, [SuccessorID] = @SuccessorID, [Type] = @Type WHERE [ID] = @ID">
            <DeleteParameters>
                <asp:Parameter Name="ID" Type="Int32" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="PredecessorID" Type="Int32" />
                <asp:Parameter Name="SuccessorID" Type="Int32" />
                <asp:Parameter Name="Type" Type="Int32" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="PredecessorID" Type="Int32" />
                <asp:Parameter Name="SuccessorID" Type="Int32" />
                <asp:Parameter Name="Type" Type="Int32" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>
    </form>
</body>
</html>
