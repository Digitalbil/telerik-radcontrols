<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : Telerik.Web.UI.CloudUploadHandler
{
    public override void SetKeyName(object sender, Telerik.Web.UI.CloudUpload.SetKeyNameEventArgs e)
    {
        e.KeyName = e.OriginalFileName;       
    }
}