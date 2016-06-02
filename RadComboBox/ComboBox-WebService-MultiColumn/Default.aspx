<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <style type="text/css">
        ul {
            margin: 0;
            padding: 0;
            width: 100%;
            display: inline-block;
            list-style-type: none;
        }

        .col1,
        .col2,
        .col3 {
            margin: 0;
            padding: 0 5px 0 0;
            width: 110px;
            line-height: 14px;
            float: left;
        }
    </style>
    <telerik:RadScriptBlock runat="server" ID="RadScriptBlock1">

        <script type="text/javascript">

            //Problem: When autopostback set to true it removes all the items from the combo and only the selected item is displayed.
            //Solution: Clear the selection when user opens the drop down list in OnClientDropDownOpening event.
            function clientDropDownOpening(sender, args) {
                sender.clearSelection();
            }

        </script>

    </telerik:RadScriptBlock>
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
        <telerik:RadComboBox ID="rcbCompanies" runat="server"  Height="190px" Width="420px"
            EmptyMessage="Select a Company" EnableLoadOnDemand="true" ShowMoreResultsBox="true"
            EnableVirtualScrolling="true" Label="Page Methods:">
            <HeaderTemplate>
                <ul>
                    <li class="col1">Company</li>
                    <li class="col2">Branch</li>
                    <li class="col3">Site</li>
                </ul>
            </HeaderTemplate>
            <ClientItemTemplate>
                    <ul>
                        <li class="col1">
                            <span> #= Text # </span>
                            <li class="col2">
                                 <span> #= Attributes.Branch # </span>
                                <li class="col3">
                                    <span> #= Attributes.Site # </span>
                    </ul>
                    
            </ClientItemTemplate>
            <WebServiceSettings Method="GetCompanyNames" Path="CompaniesWebService.asmx" />
        </telerik:RadComboBox>
    </form>
</body>
</html>
