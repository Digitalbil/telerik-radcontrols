<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using Telerik.Web.UI;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Data.SqlClient;
using System.IO;

public class Handler : AsyncUploadHandler, System.Web.SessionState.IRequiresSessionState
{

    protected override IAsyncUploadResult Process(UploadedFile file, HttpContext context, IAsyncUploadConfiguration configuration, string tempFileName)
    {
        string targetFolder = context.Server.MapPath(configuration.TargetFolder);
        string fileName = file.GetName();
        
        file.SaveAs(targetFolder + "/" + fileName);
           
        return CreateDefaultUploadResult<UploadedFileInfo>(file);
    }
}
