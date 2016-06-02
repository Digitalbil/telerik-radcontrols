using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.AspNet.SignalR;

namespace SignalRDemo
{
    public class NotificationsHub : Hub
    {
        public void SendNotification(string data)
        {
            Clients.All.broadcastNotification(data);
        }
    }
}