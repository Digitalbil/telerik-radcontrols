using Amazon.S3;
using Amazon.S3.Model;
using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Linq;
using System.Web;
using Telerik.Web.UI;

namespace MyNamespace
{
    public class CustomAmazonProvider : AmazonS3Provider
    {
        public override void Initialize(string name, System.Collections.Specialized.NameValueCollection config)
        {
            AccessKey = "{ACCESS_KEY}";
            SecretKey = "{SECRET_KEY}";
            BucketName = "{BUCKET_NAME}";
            UncommitedFilesExpirationPeriod = TimeSpan.FromHours(2);
        }

        public override void UploadFile(string keyName, System.Collections.Specialized.NameValueCollection metaData, System.IO.Stream fileStream)
        {

            PutObjectRequest request = new PutObjectRequest() { Key = keyName, BucketName = BucketName, InputStream = fileStream };
            request.CannedACL = S3CannedACL.PublicRead;

            foreach (string key in metaData)
            {
                request.Metadata.Add(key, metaData[key]);
            }

            try
            {
                AmazonS3Client.PutObject(request);
            }
            catch (AmazonS3Exception e)
            {
                var message = string.Format("Exception thrown for upload operation for file with keyName: {0}", keyName);
                throw new CloudUploadProviderException(message, e, keyName, BucketName);
            }

        }

        public override string InitiateMultiPartUpload(string keyName, NameValueCollection metaData)
        {
            InitiateMultipartUploadRequest request = new InitiateMultipartUploadRequest();
            request.CannedACL = S3CannedACL.PublicRead;

            request.BucketName = BucketName;
            request.Key = keyName;

            foreach (string key in metaData)
            {
                request.Metadata.Add(key, metaData[key]);
            }

            InitiateMultipartUploadResponse response;

            try
            {
                response = AmazonS3Client.InitiateMultipartUpload(request);
            }
            catch (AmazonS3Exception e)
            {
                throw new CloudUploadProviderException("Exception thrown for initiate multi part upload operation", e);
            }

            return response.UploadId;
        }
    }
}