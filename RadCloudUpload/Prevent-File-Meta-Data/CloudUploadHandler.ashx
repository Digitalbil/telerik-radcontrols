<%@ WebHandler Language="C#" Class="CloudUploadHandler" %>

using System;
using System.Web;

public class CloudUploadHandler : Telerik.Web.UI.CloudUploadHandler 
{
    public override void SetMetaData(object sender, Telerik.Web.UI.CloudUpload.SetMetaDataEventArgs e)
    {
        //base.SetMetaData(sender, e);
    }
}