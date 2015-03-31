<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="RadAutoCompleteBox_Web_API.Default" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <telerik:RadAutoCompleteBox ID="RadAutoCompleteBox1" runat="server" DataTextField="Text" DataValueField="Id"  
            ClientDataSourceID="RadClientDataSource1"></telerik:RadAutoCompleteBox>
        <telerik:RadClientDataSource ID="RadClientDataSource1" runat="server">
            <DataSource>
                <WebServiceDataSourceSettings>
                    <Select Url="api/items" ContentType="" DataType="JSON" RequestType="Get" />
                </WebServiceDataSourceSettings>
            </DataSource>
        </telerik:RadClientDataSource>
    </form>
</body>
</html>
