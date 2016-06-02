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
            function enable() {
                $('#dropzone').show();
            }


            function disable() {
                $('#dropzone').hide();
            }

            //Prevent file dropping on the document body
            $(document).bind('drop dragover', function (e) {
                e.preventDefault();
            });

        </script>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
        </telerik:RadAjaxManager>
        <telerik:RadAsyncUpload runat="server" ID="upload" DropZones="#dropzone"></telerik:RadAsyncUpload>
        <div style="width: 500px; height: 500px; background-color: red;z-index:9;">
            <div id="dropzone" style="width: 500px; height: 500px; background-color: green;z-index:99;"></div>
        </div>
        <input id="Button3" type="button" value="Enable Drop Zone" onclick="enable();" />
        <input id="Button4" type="button" value="Disable Drop Zone" onclick="disable()" />
    </form>
</body>
</html>
