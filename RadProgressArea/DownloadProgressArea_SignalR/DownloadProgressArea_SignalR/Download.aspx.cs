using System;
using System.Threading.Tasks;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Microsoft.AspNet.SignalR;
using Telerik.Web.UI;
using System.Web.Script.Serialization;
using DownloadProgressArea_SignalR.App_Code;

public partial class Default : System.Web.UI.Page
{
    private IHubContext hub;

    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void rbDownload_Click(object sender, EventArgs e)
    {
        
    }
}
