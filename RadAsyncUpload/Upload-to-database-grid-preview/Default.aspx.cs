using System;
using System.Web;
//using System.Web.UI;
//using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using System.Drawing;
using System.IO;
using System.Drawing.Imaging;
using System.Data.SqlClient;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void RadAsyncUpload1_FileUploaded(object sender, FileUploadedEventArgs e)
    {
        string  text = RadAsyncUpload1.UploadedFiles[0].GetFieldValue("TextBox");
        InsertImage(e.File, 123, text);
        RadGrid1.Rebind();
    }
    public int InsertImage(UploadedFile file, int userID, string text)
    {
        string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

        using (SqlConnection conn = new SqlConnection(connectionString))
        {
            string cmdText = "INSERT INTO AsyncUploadImages VALUES(@ImageData, @ImageName, @UserID, @Text) SET @Identity = SCOPE_IDENTITY()";
            SqlCommand cmd = new SqlCommand(cmdText, conn);

            byte[] imageData = GetImageBytes(file.InputStream);

            SqlParameter identityParam = new SqlParameter("@Identity", SqlDbType.Int, 0, "ImageID");
            identityParam.Direction = ParameterDirection.Output;

            cmd.Parameters.AddWithValue("@ImageData", imageData);
            cmd.Parameters.AddWithValue("@ImageName", file.GetName());
            cmd.Parameters.AddWithValue("@UserID", userID);
            cmd.Parameters.AddWithValue("@Text", text);

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
            using (MemoryStream ms = new MemoryStream())
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