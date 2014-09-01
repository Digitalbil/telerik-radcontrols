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
    protected void btnUpload_Click(object sender, EventArgs e)
    {
        string target = Server.MapPath("~/Uploads/");
        foreach (UploadedFile file in RadAsyncUpload1.UploadedFiles)
        {
            string fileName = file.FileName;
            string fullFileName = target + fileName;
            file.SaveAs(fullFileName);
        }
    }
}
