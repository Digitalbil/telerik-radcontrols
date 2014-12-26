<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />

            <telerik:RadClientDataSource runat="server" ID="rcdsCountries">
                <DataSource>
                    <WebServiceDataSourceSettings ServiceType="Default" BaseUrl="Services/Service.svc/">
                        <Select Url="GetCountries" DataType="JSON" RequestType="Post" ContentType="application/json; charset=utf-8" />
                    </WebServiceDataSourceSettings>
                </DataSource>
                <Schema DataName="d">
                </Schema>
            </telerik:RadClientDataSource>

            <telerik:RadDropDownList runat="server" ID="ddlCountries" DataTextField="Name" DataValueField="Id"
                ClientDataSourceID="rcdsCountries" OnClientItemSelected="ddlCountries_OnClientItemSelected">
            </telerik:RadDropDownList>


            <telerik:RadClientDataSource runat="server" ID="rcdsCities">
                <ClientEvents OnCustomParameter="rcdsCities_OnCustomParameter" />
                <DataSource>
                    <WebServiceDataSourceSettings ServiceType="Default" BaseUrl="Services/Service.svc/" Select-EnableCaching="false">
                        <Select Url="GetCities" DataType="JSON" RequestType="Post" ContentType="application/json; charset=utf-8" />
                    </WebServiceDataSourceSettings>
                </DataSource>
                <Schema DataName="d">
                </Schema>
            </telerik:RadClientDataSource>

            <telerik:RadDropDownList runat="server" ID="ddlCities" ClientDataSourceID="rcdsCities" DataTextField="Name" DataValueField="Id" Enabled="false">
            </telerik:RadDropDownList>

        </div>
    </form>

    <script type="text/javascript">
        var id = 0;

        function rcdsCities_OnCustomParameter(sender, args) {            
            args.set_parameterFormat("{ \"context\" : " + id + " }");
        }

        function ddlCountries_OnClientItemSelected(sender, args) {
            id = args.get_item().get_value();
            var cities = $find("<%= ddlCities.ClientID %>"),
                odatasource = $find('rcdsCities'),
                items = cities.get_items();

            if (id == 0) {
                cities.set_enabled(false);
            }
            else {
                cities.set_enabled(true);
                odatasource.fetch();
                items.clear();
                setTimeout(function () {
                    odatasource.get_data().forEach(function (item) {
                        items.add(createItem(item.Name, item.Id));
                    })
                }, 200);
                
            }            
        }

        function createItem(text, value)
        {
            var item = new Telerik.Web.UI.DropDownListItem();
            item.set_text(text);
            item.set_value(value);
            return item;
        }
    </script>
</body>
</html>
