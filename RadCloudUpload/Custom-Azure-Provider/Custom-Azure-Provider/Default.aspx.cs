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
        if (!IsPostBack)
        {
            Session["accountKey"] = "{ACCOUNT_KEY}";
            Session["accountName"] = "{ACCOUNT_NAME}";
            Session["blobContainer"] = "{BLOB_CONTAINER}";
            Session["subFolderStructure"] = "{SUB_FOLDER_STRUCTURE}";
        }
    }

    protected void ddlBlob_SelectedIndexChanged(object sender, DropDownListEventArgs e)
    {
        Session["blobContainer"] = e.Value;
    }
}
