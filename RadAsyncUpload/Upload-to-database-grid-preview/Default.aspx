<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <telerik:RadStyleSheetManager ID="RadStyleSheetManager1" runat="server" />
    <script src="script.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server" />

        <div class="uploaded-files">
            <asp:Literal runat="server" ID="ltrNoResults" Visible="True" Text="<strong>No files uploaded</strong>" />
            <asp:Repeater runat="server" ID="Repeater1">
                <HeaderTemplate>
                    <ul>
                </HeaderTemplate>
                <FooterTemplate></ul></FooterTemplate>
                <ItemTemplate>
                    <li>
                        <dl>
                            <dt>File info:</dt>
                            <dd><%#((Telerik.Web.UI.UploadedFile)Container.DataItem).GetFieldValue("TextBox").ToString()%></dd>
                            <dt>File name:</dt>
                            <dd><%# DataBinder.Eval(Container.DataItem, "FileName").ToString() %></dd>
                            <dt>File size:</dt>
                            <dd><%# DataBinder.Eval(Container.DataItem, "ContentLength").ToString() %></dd>
                        </dl>
                    </li>
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div>
            <telerik:RadAsyncUpload ID="RadAsyncUpload1" OnFileUploaded="RadAsyncUpload1_FileUploaded" OnClientFileUploaded="onClientFileUploaded" runat="server">
            </telerik:RadAsyncUpload>
        </div>
        <telerik:RadButton ID="btnUpload" runat="server" Text="Upload"></telerik:RadButton>
        <div class="imageContainer"></div>

        <telerik:RadGrid ID="RadGrid1" runat="server" CellSpacing="-1" DataSourceID="SqlDataSource1" GridLines="Both" GroupPanelPosition="Top">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="ImageID" DataSourceID="SqlDataSource1">
                <Columns>
                    <telerik:GridBoundColumn DataField="ImageID" DataType="System.Int32" FilterControlAltText="Filter ImageID column" HeaderText="ImageID" ReadOnly="True" SortExpression="ImageID" UniqueName="ImageID">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ImageName" FilterControlAltText="Filter ImageName column" HeaderText="ImageName" SortExpression="ImageName" UniqueName="ImageName">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBinaryImageColumn DataField="ImageData" HeaderText="Image"></telerik:GridBinaryImageColumn>
                    <telerik:GridBoundColumn DataField="UserID" DataType="System.Int32" FilterControlAltText="Filter UserID column" HeaderText="UserID" SortExpression="UserID" UniqueName="UserID">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Text" DataType="System.String" FilterControlAltText="Filter UserID column" HeaderText="Text" UniqueName="Text">
                        <ColumnValidationSettings>
                            <ModelErrorMessage Text="" />
                        </ColumnValidationSettings>
                    </telerik:GridBoundColumn>
                </Columns>
            </MasterTableView>
        </telerik:RadGrid>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            SelectCommand="SELECT * FROM [AsyncUploadImages]"></asp:SqlDataSource>
    </form>
</body>
</html>
