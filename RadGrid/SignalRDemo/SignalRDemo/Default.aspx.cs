using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using SignalRDemo.App_Code;

namespace SignalRDemo
{
    public partial class Default : System.Web.UI.Page
    {
        private IHubContext hub;

        protected void Page_Load(object sender, EventArgs e)
        {
            hub = GlobalHost.ConnectionManager.GetHubContext<NotificationsHub>();
            var jsonSerialiser = new JavaScriptSerializer();
            List<Currency> list = new List<Currency>();
            list.Add(new Currency() { Code = "USD", Price = GetRandomNumber(1.300, 1.3500) });
            list.Add(new Currency() { Code = "EUR", Price = GetRandomNumber(1.300, 1.3500) });
            list.Add(new Currency() { Code = "GBP", Price = GetRandomNumber(1.300, 1.3500) });

            //var chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

            for (int i = 0; i < 10; i++)
            {
                list[0].Price = GetRandomNumber(1.300, 1.3500);
                list[1].Price = GetRandomNumber(1.300, 1.3500);
                list[2].Price = GetRandomNumber(1.300, 1.3500);

                var json = jsonSerialiser.Serialize(list);
                hub.Clients.All.broadcastNotification(json);
                System.Threading.Thread.Sleep(1000);
            }
        }

        public double GetRandomNumber(double minimum, double maximum)
        {
            Random random = new Random();
            return random.NextDouble() * (maximum - minimum) + minimum;
        }

    }
}