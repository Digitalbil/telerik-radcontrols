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
        CustomAsyncUploadResult result = CreateDefaultUploadResult<CustomAsyncUploadResult>(file);

        if (file.FileName.Length > 10)
        {
            result.StatusCode = 500;
            result.Message = "File name is too long";
        }
        else
        {
            string targetFolder = context.Server.MapPath(configuration.TargetFolder);
            string fileName = file.GetName();
            file.SaveAs(targetFolder + "/" + fileName);

            result.StatusCode = 201;
            result.Message = "File was uploaded successfully";
        }

        return result;
    }
}