using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Microsoft.AspNet.SignalR;

namespace DownloadProgressArea_SignalR
{
 public class NotificationsHub : Hub
    {
        public void SendNotification(string data)
        {
            Clients.All.broadcastNotification(data);
        }
    }
}
