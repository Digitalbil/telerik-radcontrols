<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CancelFileUploading.aspx.cs" Inherits="CancelFileUploading" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js"></asp:ScriptReference>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js"></asp:ScriptReference>
            </Scripts>
        </telerik:RadScriptManager>

        <script>
            var progressCancelButton;

            function pageLoad() {
                progressCancelButton = $get(progressArea.attributes.id.value + "_Panel_CancelButton");
                progressCancelButton.addEventListener('click', cancelButtonClick);
            }

            function cancelButtonClick() {
                var $inputCancelButtons = $("span.ruButton.ruCancel");
                var count = $inputCancelButtons.size();

                $inputCancelButtons.each(function () {
                    $(this).click().delay(0);
                    if (!--count) removeCanceledFiles();
                });
            }

            function removeCanceledFiles() {
                var $inputRemoveButtons = $("span.ruButton.ruRemove");
                $inputRemoveButtons.each(function () {
                    $(this).click();
                });
            }
        </script>

        <telerik:RadAsyncUpload runat="server" ID="async"
            MultipleFileSelection="Automatic"
            RenderMode="Lightweight"
            UploadedFilesRendering="BelowFileInput">
        </telerik:RadAsyncUpload>
        <telerik:RadProgressArea runat="server" ID="progressArea" DisplayCancelButton="true"></telerik:RadProgressArea>
    </form>
</body>
</html>
