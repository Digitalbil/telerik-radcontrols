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

        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="ddlBlob">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="ddlBlob" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>

        Blob Container:<telerik:RadDropDownList ID="ddlBlob" runat="server" OnSelectedIndexChanged="ddlBlob_SelectedIndexChanged" AutoPostBack="true">
            <Items>
                <telerik:DropDownListItem Text="Blob 1" Value="blob1" />
                <telerik:DropDownListItem Text="Blob 2" Value="blob2" />
                <telerik:DropDownListItem Text="Blob 3" Value="blob3" />
            </Items>
        </telerik:RadDropDownList>

        <telerik:RadCloudUpload ID="RadCloudUpload1" runat="server" ProviderType="Azure" HttpHandlerUrl="~/Handler.ashx"></telerik:RadCloudUpload>

    </form>
</body>
</html>
