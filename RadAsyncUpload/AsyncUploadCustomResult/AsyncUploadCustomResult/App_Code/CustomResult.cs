using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;

/// <summary>
/// Summary description for CustomResult
/// </summary>
public class CustomResult : AsyncUploadResult
{
    public bool IsPasswordProtected { get; set; }
}