<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;

public class Handler : Telerik.Web.UI.CloudUploadHandler, System.Web.SessionState.IRequiresSessionState
{ }