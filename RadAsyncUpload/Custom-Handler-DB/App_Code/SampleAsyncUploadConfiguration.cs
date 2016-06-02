using System;
using Telerik.Web.UI;
 
// The upload configuration object is passed from the page to the custom handler.
// You can customize it to include custom properties by extending the AsyncUploadConfiguration class.
// In this case we send the ID of the currently logged-in user to be stored in the database as the auther of the image.
public class SampleAsyncUploadConfiguration : AsyncUploadConfiguration
{
    private int userID;
    public int UserID
    {
        get
        {
            return userID;
        }
 
        set
        {
            userID = value;
        }
    }
}