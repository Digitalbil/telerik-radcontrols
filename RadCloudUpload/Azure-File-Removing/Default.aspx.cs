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
using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Blob;
using Microsoft.WindowsAzure;
using System.Web.Services;
using System.ServiceModel.Web;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    [WebMethod]
    public static bool DeleteBlob(string blobName)
    {
        //http://azure.microsoft.com/en-us/documentation/articles/storage-dotnet-how-to-use-blobs/#delete-blobs

        string accountKey = "",
               accountName = "",
               blobContainer = "";
        try
        {
            CloudStorageAccount storageAccount = new CloudStorageAccount(new Microsoft.WindowsAzure.Storage.Auth.StorageCredentials(accountName, accountKey), true);

            // Create the blob client.
            CloudBlobClient blobClient = storageAccount.CreateCloudBlobClient();

            // Retrieve reference to a previously created container.
            CloudBlobContainer container = blobClient.GetContainerReference(blobContainer);

            // Retrieve reference to a blob named "myblob.txt".
            CloudBlockBlob blockBlob = container.GetBlockBlobReference(blobName);

            // Delete the blob.
            blockBlob.Delete();
        }
        catch (Exception)
        {
            return false;
        }
        return true;
    }
}

