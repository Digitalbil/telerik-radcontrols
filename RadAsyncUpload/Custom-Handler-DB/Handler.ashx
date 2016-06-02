<%@ WebHandler Language="C#" Class="Handler" %>

using System;
using System.Web;
using Telerik.Web.UI;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Data.SqlClient;
using System.IO;

public class Handler : AsyncUploadHandler, System.Web.SessionState.IRequiresSessionState
{
  protected override IAsyncUploadResult Process(UploadedFile file, HttpContext context, IAsyncUploadConfiguration configuration, string tempFileName)
    {
        // Call the base Process method to save the file to the temporary folder
        // base.Process(file, context, configuration, tempFileName);
 
        // Populate the default (base) result into an object of type SampleAsyncUploadResult
        SampleAsyncUploadResult result = CreateDefaultUploadResult<SampleAsyncUploadResult>(file);
 
        int userID = -1;
        // You can obtain any custom information passed from the page via casting the configuration parameter to your custom class
        SampleAsyncUploadConfiguration sampleConfiguration = configuration as SampleAsyncUploadConfiguration;
        if (sampleConfiguration != null)
        {
            userID = sampleConfiguration.UserID;
        }
         
        // Populate any additional fields into the upload result.
        // The upload result is available both on the client and on the server
        result.ImageID = InsertImage(file, userID);
         
        return result;
    }
 
    public int InsertImage(UploadedFile file, int userID)
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
 
         using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string cmdText = "INSERT INTO AsyncUploadImages VALUES(@ImageData, @ImageName, @UserID) SET @Identity = SCOPE_IDENTITY()";
            SqlCommand cmd = new SqlCommand(cmdText, conn);
 
            byte[] imageData = GetImageBytes(file.InputStream);
             
            SqlParameter identityParam = new SqlParameter("@Identity", SqlDbType.Int, 0, "ImageID");
            identityParam.Direction = ParameterDirection.Output;
             
            cmd.Parameters.AddWithValue("@ImageData", imageData);
            cmd.Parameters.AddWithValue("@ImageName", file.GetName());
            cmd.Parameters.AddWithValue("@UserID", userID);
             
            cmd.Parameters.Add(identityParam);
             
            conn.Open();
            cmd.ExecuteNonQuery();
 
            return (int)identityParam.Value;
        }
    }
     
    public byte[] GetImageBytes(Stream stream)
    {
        byte[] buffer;
         
        using (Bitmap image = ResizeImage(stream))
        {
            using ( MemoryStream ms = new MemoryStream())
            {
                image.Save(ms, ImageFormat.Jpeg);
                 
                //return the current position in the stream at the beginning
                ms.Position = 0;
                 
                buffer = new byte[ms.Length];
                ms.Read(buffer, 0, (int)ms.Length);
                return buffer;
            }
        }
    }
 
    public Bitmap ResizeImage(Stream stream)
    {
        Image originalImage = Bitmap.FromStream(stream);
 
        int height = 500;
        int width = 500;
 
        double ratio = Math.Min(originalImage.Width, originalImage.Height) / (double)Math.Max(originalImage.Width, originalImage.Height);
 
        if (originalImage.Width > originalImage.Height)
        {
            height = Convert.ToInt32(height * ratio);
        }
        else
        {
            width = Convert.ToInt32(width * ratio);
        }
 
        Bitmap scaledImage = new Bitmap(width, height);
 
        using (Graphics g = Graphics.FromImage(scaledImage))
        {
            g.InterpolationMode = System.Drawing.Drawing2D.InterpolationMode.HighQualityBicubic;
            g.DrawImage(originalImage, 0, 0, width, height);
 
            return scaledImage;
        }
 
    }
}
