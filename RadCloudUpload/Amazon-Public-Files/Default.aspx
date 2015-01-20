<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" TagPrefix="telerik" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager runat="server">
        </telerik:RadScriptManager>
        <telerik:RadCloudUpload runat="server" ProviderType="Amazon"
            OnFileUploaded="RadCloudUpload1_FileUploaded">
        </telerik:RadCloudUpload>
        <asp:Button ID="btnSubmit" runat="server" Text="Submit" />
        <asp:HyperLink ID="HyperLink1" runat="server"></asp:HyperLink>
    </form>
</body>
</html>
