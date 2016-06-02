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
    protected void rbSubmit_Click(object sender, EventArgs e)
    {
        foreach (UploadedFile file in RadAsyncUpload1.UploadedFiles)
        {
            string target = Server.MapPath("~/Uploads/");
            file.SaveAs(target + file.FileName);
            byte[] fileBytes = System.IO.File.ReadAllBytes(target + file.FileName);
            RadBinaryImage1.DataValue = fileBytes;
            RadBinaryImage1.DataBind();
        }
    }
}
