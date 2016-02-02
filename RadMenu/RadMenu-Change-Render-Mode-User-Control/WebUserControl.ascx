<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WebUserControl.ascx.cs" Inherits="WebUserControl" %>

<telerik:RadMenu runat="server" ID="menu">
    <Items>
        <telerik:RadMenuItem Text="Item 1"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Item 2"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Item 3"></telerik:RadMenuItem>
        <telerik:RadMenuItem Text="Item 4"></telerik:RadMenuItem>
    </Items>
</telerik:RadMenu>

<input type="button" value="Go Mobile" onclick="change()" />

<telerik:RadAjaxManagerProxy ID="AjaxManagerProxy1" runat="server" >
    <AjaxSettings>
        <telerik:AjaxSetting AjaxControlID="AjaxManagerProxy1">
            <UpdatedControls>
                <telerik:AjaxUpdatedControl ControlID="AjaxManagerProxy1" />
                <telerik:AjaxUpdatedControl ControlID="menu" />
            </UpdatedControls>
        </telerik:AjaxSetting>
    </AjaxSettings>
</telerik:RadAjaxManagerProxy>

<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
    <script type="text/javascript">
        function change() {
            $find("<%= RadAjaxManager.GetCurrent(Page).ClientID %>").ajaxRequest("mobile");
        }
    </script>
</telerik:RadCodeBlock>
