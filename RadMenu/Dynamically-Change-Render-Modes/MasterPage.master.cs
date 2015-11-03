using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.Device.Detection;
using Telerik.Web.UI;

public partial class MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected override void OnInit(EventArgs e)
    {
        DeviceScreenDimensions screenDimensions = Detector.GetScreenDimensions(Request.UserAgent);
        LoadMobile(screenDimensions);
    }

    private void LoadMobile(DeviceScreenDimensions screenDimensions)
    {
        // Desktop Browser Detected
        if (screenDimensions.Height == 0 && screenDimensions.Width == 0)
        {
            menu.RenderMode = RenderMode.Lightweight;
        }
        // Mobile Browser Detected
        else
        {
            menu.RenderMode = RenderMode.Mobile;
        }
    }   
}
