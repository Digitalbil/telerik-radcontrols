<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
            </Scripts>
        </telerik:RadScriptManager>

        <telerik:RadAsyncUpload 
            runat="server" 
            ID="upload" 
            EnableCustomValidation="true" 
            ValidationGroup="G1">
        </telerik:RadAsyncUpload>
       
         <asp:CustomValidator 
            runat="server"
            ID="requiredValidator"
            ErrorMessage="* Please select only .jpg files"
            ForeColor="Red"
            ValidationGroup="G1"
            OnServerValidate="requiredValidator_ServerValidate">
        </asp:CustomValidator>

        <asp:Button 
            runat="server" 
            Text="Submit" 
            CausesValidation="true" 
            ValidationGroup="G1" 
            ID="btnSubmit" 
            OnClick="btnSubmit_Click" />
    </form>
</body>
</html>
