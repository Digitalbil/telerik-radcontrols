<%@ Page Language="VB" AutoEventWireup="false" CodeFile="DefaultVB.aspx.vb" Inherits="DefaultVB" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
 <form id="form1" runat="server">
        <telerik:RadScriptManager ID="scriptManager" runat="server">
            <Scripts>
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.Core.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQuery.js" />
                <asp:ScriptReference Assembly="Telerik.Web.UI" Name="Telerik.Web.UI.Common.jQueryInclude.js" />
                <asp:ScriptReference Name="WebForms.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebForms.js" />
                <asp:ScriptReference Name="WebUIValidation.js" Assembly="System.Web" Path="~/Scripts/WebForms/WebUIValidation.js" />
            </Scripts>
        </telerik:RadScriptManager>

        <telerik:RadAjaxPanel ID="RadAjaxPanel1" runat="server">
            <div>
                <telerik:RadTextBox
                    runat="server"
                    ID="rtbName"
                    Label="Name"
                    ValidationGroup="G1">
                </telerik:RadTextBox>

                <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                    runat="server"
                    ControlToValidate="rtbName"
                    ErrorMessage="* Please enter name"
                    ForeColor="Red"
                    ValidationGroup="G1">
                </asp:RequiredFieldValidator>
            </div>
            <div>
                <telerik:RadAsyncUpload
                    runat="server"
                    ID="upload"
                    Localization-Select="Select only jpg files"
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
            </div>
            <div>
                <telerik:RadButton
                    runat="server"
                    Text="Submit"
                    ID="rbSubmit"
                    CausesValidation="true"
                    ValidationGroup="G1"
                    OnClick="rbSubmit_Click">
                </telerik:RadButton>
            </div>
        </telerik:RadAjaxPanel>
    </form>
</body>
</html>
