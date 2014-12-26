using System;
using System.Linq;
using Telerik.Web.UI;
using System.Web.SessionState;
using System.Web;

namespace CloudUpload
{
    public class CustomAzureProvider : AzureProvider, IRequiresSessionState
    {
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            HttpContext context = HttpContext.Current;

            AccountKey = context.Session["accountKey"].ToString();
            AccountName = context.Session["accountName"].ToString();
            BlobContainer = context.Session["blobContainer"].ToString();
            SubFolderStructure = context.Session["subFolderStructure"].ToString();
            UncommitedFilesExpirationPeriod = TimeSpan.FromHours(2);
        }
    }
}