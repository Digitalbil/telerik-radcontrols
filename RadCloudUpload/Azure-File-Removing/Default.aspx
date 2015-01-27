<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
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

        <script type="text/javascript">
            function removing(sender, args) {
                $.ajax({
                    type: "POST",
                    url: "Default.aspx/DeleteBlob",
                    data: '{blobName: "' + args.get_fileName() + '" }',
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function () {
                        alert('File was removed successfully!');
                    },
                    failure: function (response) {
                        alert(response.d);
                    }
                });
            }
        </script>
        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" ProviderType="Azure"
            OnClientFileUploadRemoving="removing" MultipleFileSelection="Automatic"
            HttpHandlerUrl="~/Handler.ashx">
        </telerik:RadCloudUpload>
    </form>
</body>
</html>
