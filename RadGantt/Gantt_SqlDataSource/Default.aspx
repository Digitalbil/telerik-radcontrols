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

        <telerik:RadGantt runat="server" ID="RadGantt1" DataSourceID="sdsTasks" Width="1275px" Height="600px" ListWidth="351px"
            DependenciesDataSourceID="sdsDependencies" SelectedView="WeekView" AutoGenerateColumns="false">
            <Columns>
                <telerik:GanttBoundColumn DataField="Title" DataType="String" Width="120px"></telerik:GanttBoundColumn>
                <telerik:GanttBoundColumn DataField="Start" DataType="DateTime" DataFormatString="dd/MM/yy" Width="40px"></telerik:GanttBoundColumn>
                <telerik:GanttBoundColumn DataField="End" DataType="DateTime" DataFormatString="dd/MM/yy" Width="40px"></telerik:GanttBoundColumn>
            </Columns>
 
            <DataBindings>
                <TasksDataBindings
                    IdField="ID" ParentIdField="ParentID"
                    StartField="Start" EndField="End"
                    OrderIdField="OrderID"
                    SummaryField="Summary"
                    TitleField="Title" PercentCompleteField="PercentComplete" />
                <DependenciesDataBindings
                    TypeField="Type" IdField="ID"
                    PredecessorIdField="PredecessorID"
                    SuccessorIdField="SuccessorID" />
            </DataBindings>
        </telerik:RadGantt>

        <asp:SqlDataSource runat="server" ID="sdsTasks" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [GanttTasks] WHERE [ID] = @ID" InsertCommand="INSERT INTO [GanttTasks] ([ParentID], [OrderID], [Title], [Start], [End], [PercentComplete], [Expanded], [Summary], [Description]) VALUES (@ParentID, @OrderID, @Title, @Start, @End, @PercentComplete, @Expanded, @Summary, @Description)" SelectCommand="SELECT * FROM [GanttTasks]" UpdateCommand="UPDATE [GanttTasks] SET [ParentID] = @ParentID, [OrderID] = @OrderID, [Title] = @Title, [Start] = @Start, [End] = @End, [PercentComplete] = @PercentComplete, [Expanded] = @Expanded, [Summary] = @Summary, [Description] = @Description WHERE [ID] = @ID">
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
                <asp:Parameter Name="Description" Type="String" />
            </InsertParameters>
            <UpdateParameters>
                <asp:Parameter Name="ParentID" Type="Int32" />
                <asp:Parameter Name="OrderID" Type="Int32" />
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="Start" Type="DateTime" />
                <asp:Parameter Name="End" Type="DateTime" />
                <asp:Parameter Name="PercentComplete" Type="Decimal" />
                <asp:Parameter Name="Expanded" Type="Boolean" />
                <asp:Parameter Name="Summary" Type="Boolean" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ID" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

        <asp:SqlDataSource runat="server" ID="sdsDependencies" ConnectionString="<%$ ConnectionStrings:ConnectionString %>" DeleteCommand="DELETE FROM [GanttDependencies] WHERE [ID] = @ID" InsertCommand="INSERT INTO [GanttDependencies] ([PredecessorID], [SuccessorID], [Type]) VALUES (@PredecessorID, @SuccessorID, @Type)" SelectCommand="SELECT * FROM [GanttDependencies]" UpdateCommand="UPDATE [GanttDependencies] SET [PredecessorID] = @PredecessorID, [SuccessorID] = @SuccessorID, [Type] = @Type WHERE [ID] = @ID" >
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
