<%@ Page Language="VB" AutoEventWireup="false" CodeFile="GanttVB.aspx.vb" Inherits="Controls_Gantt_GanttVB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager runat="server"></asp:ScriptManager>


            <telerik:RadGantt runat="server" ID="RadGantt1"  Width="1275px" Height="600px" ListWidth="351px"
                 SelectedView="WeekView" AutoGenerateColumns="false">
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

        </div>
    </form>
</body>
</html>
