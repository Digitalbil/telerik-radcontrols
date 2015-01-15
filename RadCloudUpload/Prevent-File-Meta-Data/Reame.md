#RadCloudUpload Meta Data

###Description
This demo shows how to set or prevent meta data adding. Some of the Cloud Storage Providers (Azure Storage) does not
allow to set metadata which contains non alphanumeric characters(ex. file names with hebrew, cyrillic or chinese
symbols). That's why file's metadata need to changed or removed in order to upload file successfully.

###How to run the demo?
1. Copy Telerik.Web.UI.dll into the Bin folder.
2. Install Azure Storage SDK v. 3.0.2 from NuGet:

> *Install-Package WindowsAzure.Storage -Version 3.0.2*

#### RadCloudUpload Resources
* [RadCloudUpload Help](http://www.telerik.com/help/aspnet-ajax/cloud-upload-overview.html)
* [RadCloudUpload Demos](http://demos.telerik.com/aspnet-ajax/cloud-upload/examples/overview/defaultcs.aspx)
