<%@ WebHandler Language="C#" Class="UploadHandler" %>

using System;
using System.Web;
using Telerik.Web.UI;

public class UploadHandler : CloudUploadHandler
{

    public override void SetKeyName(object sender, Telerik.Web.UI.CloudUpload.SetKeyNameEventArgs e)
    {
        var customFolder = Guid.NewGuid().ToString() + "/";
        e.KeyName = string.Format("{0}{1}_{2}", customFolder, Guid.NewGuid(), e.OriginalFileName);
    }

}