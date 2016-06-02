<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using Telerik.Web.UI;

public class Handler : AsyncUploadHandler {

    protected override IAsyncUploadResult Process(UploadedFile file, HttpContext context, IAsyncUploadConfiguration configuration, string tempFileName)
    {
        CustomResult result = CreateDefaultUploadResult<CustomResult>(file);

        //Check if the if the file is password protected.
        result.IsPasswordProtected = true;
        
        
        return result;
    }

}