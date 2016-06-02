using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

//namespace DownloadProgressArea_SignalR
//{
public class UpdateHub : Hub
{
    public void SendUpdate(string data)
    {
        Clients.All.broadcastNotification(data);
    }

    public void SendNewData(string connectionId, string data)
    {
        var Context = GlobalHost.ConnectionManager.GetHubContext<UpdateHub>();
        Context.Clients.Client(connectionId).send(data);
    }

    public override System.Threading.Tasks.Task OnConnected()
    {
        var connectionId = Context.ConnectionId;
        // store connectionId somewhere
        return base.OnConnected();
    }
}
//}