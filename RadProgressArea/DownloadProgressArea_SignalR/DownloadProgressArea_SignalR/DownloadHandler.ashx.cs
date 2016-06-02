using System.IO;
using System.Net;
using DownloadProgressArea_SignalR.App_Code;
using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;

namespace DownloadProgressArea_SignalR
{
    public class DownloadHandler : IHttpHandler
    {
        private IHubContext hub;

        public void ProcessRequest(HttpContext context)
        {
            string queryFile = context.Request.QueryString["file"]; 

            hub = GlobalHost.ConnectionManager.GetHubContext<UpdateHub>();
            var jsonSerialiser = new JavaScriptSerializer();
            ProgressData progressData = new ProgressData();

            DownloadFile(context, queryFile, jsonSerialiser, progressData);
        }

        private void DownloadFile(HttpContext context, string queryFile, JavaScriptSerializer jsonSerialiser, ProgressData progressData)
        {
            Stream  stream = null;
            int bytesToRead = 65536; //64 kilobytes
            byte[] buffer = new Byte[bytesToRead];

            try
            {
                string file = Path.Combine(context.Server.MapPath("~/Files/"), queryFile);
                stream = File.Open(file, FileMode.Open);

                context.Response.Clear();
                context.Response.ContentType = "application/pdf"; //"application/octet-stream";
                context.Response.AddHeader("Content-Disposition", "attachment; filename=\"" + queryFile + "\"");
                context.Response.AddHeader("Content-Length", stream.Length.ToString());

                context.Response.Buffer = false;
                //context.Response.Charset = "";
                context.Response.Cache.SetCacheability(HttpCacheability.NoCache);

                int length;
                int totalRead = 0;
                do
                {
                    if (context.Response.IsClientConnected)
                    {
                        length = stream.Read(buffer, 0, bytesToRead);
                        totalRead += length;
                        context.Response.OutputStream.Write(buffer, 0, length);

                        progressData.CurrentOperationText = queryFile;
                        progressData.PrimaryTotal = (stream.Length / 1024).ToString() + "kB";
                        progressData.PrimaryValue = (totalRead / 1024).ToString() + "kB";
                        progressData.PrimaryPercent = Convert.ToInt32((100 * totalRead / stream.Length));

                        var json = jsonSerialiser.Serialize(progressData);
                        hub.Clients.All.broadcastNotification(json);
                        System.Threading.Thread.Sleep(500);

                        context.Response.Flush();
                        buffer = new Byte[bytesToRead];
                    }
                    else
                    {
                        // cancel the download if client has disconnected
                        length = -1;
                    }
                } while (length > 0); //Repeat until no data is read
            }
            finally
            {
                if (stream != null)
                {
                    progressData.Completed = true;
                    var json = jsonSerialiser.Serialize(progressData);
                    hub.Clients.All.broadcastNotification(json);
                    stream.Close();
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}