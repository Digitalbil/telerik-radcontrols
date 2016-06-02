<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Download.aspx.cs" Inherits="Default" Async="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <telerik:RadScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <telerik:RadScriptReference Path="Scripts/json2.js" />
                <telerik:RadScriptReference Path="~/Scripts/jquery.signalR-2.0.3.min.js" />
                <telerik:RadScriptReference Path="~/signalr/hubs" />
            </Scripts>
        </telerik:RadScriptManager>
        <div>
            <telerik:RadProgressArea runat="server" ID="RadProgressArea1">
            </telerik:RadProgressArea>
            <telerik:RadProgressManager runat="server" ID="RadProgressManager1"></telerik:RadProgressManager>
            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/DownloadHandler.ashx?file=test.pdf" Target="test.pdf">DownloadHandler.ashx</asp:HyperLink>
            <telerik:RadButton ID="rbDownload" runat="server" Text="Download" OnClick="rbDownload_Click"></telerik:RadButton>
        </div>
        <script type="text/javascript">
            var progressArea,
                progressManager;

            function pageLoad() {
                    progressArea = $find('<%= RadProgressArea1.ClientID %>');
                    progressManager = $find('<%= RadProgressManager1.ClientID %>');
                }

                $(function () {
                    // Declare a proxy to reference the hub. 
                    var updates = $.connection.updateHub;
                    // Create a function that the hub can call to broadcast messages.
                    updates.client.broadcastNotification = function (data) {
                        console.log(JSON.parse(data));
                        var progressData = JSON.parse(data);
                        if (!progressData.Completed) {
                            //Update progress area 
                            progressArea.update(progressData);
                        }
                        else {
                            //If file is downloaded stop the progress
                            progressManager.stopAsyncPolling();
                        }
                    };

                    // Start the connection.
                    $.connection.hub.start().done(function () {
                        progressArea
                    });
                });
        </script>
    </form>
</body>
</html>
