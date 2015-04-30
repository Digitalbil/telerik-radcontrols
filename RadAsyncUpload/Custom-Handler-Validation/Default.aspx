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
            function onClientFileUploadFailed(sender, args) {
            }
            function onClientValidationFailed(sender, args) {
                var fileExtention = args.get_fileName().substring(args.get_fileName().lastIndexOf('.') + 1, args.get_fileName().length);
                if (args.get_fileName().lastIndexOf('.') != -1) {//this checks if the extension is correct
                    if (sender.get_allowedFileExtensions().indexOf(fileExtention) == -1) {
                        alert("Wrong Extension!");
                    }
                    else {
                        alert("Wrong file size!");
                    }
                }
                else {
                    alert("not correct extension!");
                }
            }
            function onClientFileUploaded(sender, args) {
                var status = args.get_fileInfo().StatusCode,
                    message = args.get_fileInfo().Message;


                $("#result").empty().append("<p>" + message + "</p>");

                if (status == 201) $("#result").css({ "border-color": "#80FF00", "border-width": "2px", "border-style": "solid" });
                if (status == 500) $("#result").css({ "border-color": "#FF0000", "border-width": "2px", "border-style": "solid" });

            }
        </script>

        <div>
            <p>(client validation) <strong>Maximum allowed file size 500KB.</strong></p>
            <p>(client validation) <strong>Allowed extensions jpg,jpeg,png,gif.</strong></p>
            <p>(server validation inside the handler) <strong>Maximum allowed file name length 10 characters.</strong></p>
        </div>

        <div>
            <telerik:RadAsyncUpload
                ID="RadAsyncUpload1"
                OnClientFileUploadFailed="onClientFileUploadFailed"
                OnClientValidationFailed="onClientValidationFailed"
                OnClientFileUploaded="onClientFileUploaded"
                UploadedFilesRendering="BelowFileInput"
                HttpHandlerUrl="~/Handler.ashx"
                MaxFileSize="524288"
                AllowedFileExtensions=".jpg,.jpeg,.png,.gif"
                runat="server">
            </telerik:RadAsyncUpload>
        </div>

        <div id="result"></div>
    </form>
</body>
</html>
