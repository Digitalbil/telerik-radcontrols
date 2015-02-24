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
using System.IO;

public partial class AsyncUpload : System.Web.UI.Page 
{

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        foreach (UploadedFile file in RadAsyncUpload1.UploadedFiles)
        {
            string path = Server.MapPath("~/Uploads/") + file.FileName;
            bool isUplodad = SaveFile(file.InputStream, path);
            ShowResult(isUplodad);
        }
    }

    public bool SaveFile(Stream stream, string fulleFileName)
    {
        try
        {
            byte[] buffer = new byte[1024];
            using (FileStream fs = new FileStream(fulleFileName, FileMode.Create, FileAccess.Write, FileShare.None))
            {
                int read;
                while ((read = stream.Read(buffer, 0, buffer.Length)) > 0)
                {
                    fs.Write(buffer, 0, read);
                }
            }
        }
        catch (Exception)
        {
            throw;
        }
        return true;
    }

    public void ShowResult(bool isUpload)
    {
        if (isUpload)
        {
            lblResult.Text = "File was uploaded successfully.";
        }
        else
        {
            lblResult.Text = "Error!. The file was not uploaded.";
        }
    }
}
