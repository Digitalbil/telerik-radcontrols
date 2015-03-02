using Microsoft.WindowsAzure.Storage;
using Microsoft.WindowsAzure.Storage.Auth;
using Microsoft.WindowsAzure.Storage.Blob;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Telerik.Web.UI;

namespace CloudUploadWebRole
{
    public class CustomAzureProvider : AzureProvider
    {
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            AccountKey = "Eby8vdM02xNOcqFlqUwJPLlmEtlCDXJ1OUzFT50uSRZ6IFsuFq2UVErCz4I6tq/K1SZFPTOtr/KBHBeksoGMGw==";
            AccountName = "devstoreaccount1";
            BlobContainer = "radclouduploadtest";
            UncommitedFilesExpirationPeriod = TimeSpan.FromHours(2);
        }

        public override void EnsureWebClient()
        {

            bool isHTTPS = (DefaultEndpointsProtocol == "https") ? true : false;
            CloudStorageAccount storageAccount = new CloudStorageAccount(new StorageCredentials(AccountName, AccountKey),
                new StorageUri(new Uri("http://127.0.0.1:10000/devstoreaccount1/radclouduploadtest/")),
                new StorageUri(new Uri("http://127.0.0.1:10001/devstoreaccount1/test/")),
                new StorageUri(new Uri("http://127.0.0.1:10002/devstoreaccount1/test1/"))
                );

            var blobClient = storageAccount.CreateCloudBlobClient();

            var container = blobClient.GetContainerReference(BlobContainer);

            StorageContainer = container;

        }
    }
}