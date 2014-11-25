using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;

public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    private void Page_Init(object sender, EventArgs e)
    {
        RadGantt1.Provider = new XmlGanttProvider(Server.MapPath("~/App_Data/GanttData.xml"), false); ;
    }
}
