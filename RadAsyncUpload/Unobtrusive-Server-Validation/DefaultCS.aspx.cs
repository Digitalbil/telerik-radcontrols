using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class DefaultCS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void requiredValidator_ServerValidate(object source, ServerValidateEventArgs args)
    {
        // There are no selected files
        if (upload.UploadedFiles.Count == 0)
        {
            args.IsValid = false;
        }

        // Selected files don't match the specified extension
        foreach (UploadedFile file in upload.UploadedFiles)
        {
            if (file.GetExtension() != ".jpg")
            {
                args.IsValid = false;
            }
        }
    }

    protected void rbSubmit_Click(object sender, EventArgs e)
    {
        if (Page.IsValid)
        {
            string target = Server.MapPath("~/Uploads/");
            foreach (UploadedFile file in upload.UploadedFiles)
            {
                string fileName = file.FileName;
                string fullFileName = target + fileName;
                file.SaveAs(fullFileName);
            }
        }

    }
}