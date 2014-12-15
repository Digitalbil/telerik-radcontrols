<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager runat="server" ID="RadAjaxManager1" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="ConfiguratorPanel1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="ConfiguratorPanel1" />
                    <telerik:AjaxUpdatedControl ControlID="DemoContainer1" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>

    <div style="padding-bottom:25px;">
       <a href="http://www.telerik.com/help/aspnet-ajax/asyncupload-disable-chunk-upload.html">ChunkSize:</a>
        <telerik:RadDropDownList ID="RadDropDownList" runat="server" AutoPostBack="true" OnSelectedIndexChanged="RadDropDownList_SelectedIndexChanged">
            <Items>
                <telerik:DropDownListItem Text="1 Mb" Value="1048576" />
                <telerik:DropDownListItem Text="2 Mb" Value="2097152" />
                <telerik:DropDownListItem Text="3 Mb" Value="3145728" />
            </Items>
        </telerik:RadDropDownList>
    </div>

    <div runat="server" id="DemoContainer1">
        <telerik:RadAsyncUpload runat="server" ID="AsyncUpload1" ChunkSize="1048576" TargetFolder="~/Uploads" />
        <telerik:RadProgressArea runat="server" ID="RadProgressArea1" />
        <telerik:RadButton ID="rbUpload" runat="server" Text="Upload"></telerik:RadButton>
    </div>


</asp:Content>

