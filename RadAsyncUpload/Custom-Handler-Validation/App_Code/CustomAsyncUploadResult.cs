using System;
using Telerik.Web.UI;

public class CustomAsyncUploadResult : AsyncUploadResult
{
    public int StatusCode { get; set; }
    public string Message { get; set; }
}