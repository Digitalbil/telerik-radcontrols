using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class _Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadCloudUpload1_FileUploaded(object sender, CloudFileUploadedEventArgs e)
    {
        string bucketName = "{BUCKET_NAME}";
        string endpoint = "https://" + bucketName + ".s3.amazonaws.com/";
        HyperLink1.Text = e.FileInfo.OriginalFileName;
        HyperLink1.NavigateUrl = endpoint + e.FileInfo.KeyName;
    }
}