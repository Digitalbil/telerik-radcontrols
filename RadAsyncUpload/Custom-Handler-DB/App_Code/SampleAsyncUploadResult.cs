using System;
using Telerik.Web.UI;
 
// The result object is returned from the handler to the page.
// You can include custom fields in the result by extending the AsyncUploadResult class.
// In this case we return the ID of the image record.
public class SampleAsyncUploadResult : AsyncUploadResult
{
    private int imageID;
 
    public int ImageID
    {
        get { return imageID; }
        set { imageID = value; }
    }
}