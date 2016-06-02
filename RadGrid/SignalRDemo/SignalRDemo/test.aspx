<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="test.aspx.cs" Inherits="SignalRDemo.test" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="Scripts/jquery-1.6.4.min.js"></script>
    <script src="Scripts/jquery.signalR-2.0.3.min.js"></script>
    <script src="signalr/hubs"></script>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <telerik:RadScriptReference Path="~/Scripts/jquery.signalR-2.0.3.min.js" />
                <telerik:RadScriptReference Path="~/signalr/hubs" />
            </Scripts>
        </telerik:RadScriptManager>

        <telerik:RadGrid runat="server" ID="CurrencyGrid" AllowPaging="true" PageSize="1" Width="500px">
            <ClientSettings ClientEvents-OnCommand="function(){}"></ClientSettings>
            <MasterTableView>
                <Columns>
                    <telerik:GridBoundColumn HeaderText="Currency Code" DataField="Code" UniqueName="Code"></telerik:GridBoundColumn>
                    <telerik:GridBoundColumn HeaderText="Price" DataField="Price" UniqueName="Price"></telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>

        <telerik:RadProgressArea ID="RadProgressArea1" runat="server"></telerik:RadProgressArea>
        <telerik:RadProgressManager ID="RadProgressManager1" runat="server" />
        <asp:Button ID="btnDownload" runat="server" Text="Download" OnClick="btnDownload_Click" />
    </form>
    <script>
        var grid,
            progress,
            manager,
            tableView;


        function pageLoad() {
            grid = $find('<%= CurrencyGrid.ClientID %>');
                tableView = grid.get_masterTableView();
            }

            $(function () {
                // Declare a proxy to reference the hub. 
                var notifications = $.connection.notificationsHub;
                // Create a function that the hub can call to broadcast messages.
                notifications.client.broadcastNotification = function (data) {
                    console.log(JSON.parse(data));
                    var objData = JSON.parse(data);

                    tableView.set_dataSource(objData);
                    tableView.dataBind();
                };

                // Start the connection.
                $.connection.hub.start().done(function () {

                });
            });


    </script>
</body>
</html>
