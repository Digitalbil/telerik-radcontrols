using System;
using System.Web.UI;
using System.Drawing;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class RadSchedulerAdvancedForm : System.Web.UI.Page 
{
    protected void Page_Init(object sender, EventArgs e)
		{		
            //RadScheduler1.Provider = new XmlSchedulerProvider(Server.MapPath("Appointments_CustomTemplates.xml"), true);
		}

		protected void Page_Load(object sender, EventArgs e)
		{

		}

		protected void RadScheduler1_DataBound(object sender, EventArgs e)
		{
			RadScheduler1.ResourceTypes.FindByName("User").AllowMultipleValues = true;
			RadScheduler1.ResourceTypes.FindByName("Room").AllowMultipleValues = false;
		}

		protected void RadScheduler1_AppointmentDataBound(object sender, SchedulerEventArgs e)
		{
			string colorAttribute = e.Appointment.Attributes["AppointmentColor"];
			if (!string.IsNullOrEmpty(colorAttribute))
			{
				int colorValue;
				if (int.TryParse(colorAttribute, out colorValue))
				{
					Color appointmentColor = Color.FromArgb(colorValue);
					e.Appointment.BackColor = appointmentColor;
					e.Appointment.BorderColor = Color.Black;
					e.Appointment.BorderStyle = BorderStyle.Solid;
					e.Appointment.BorderWidth = Unit.Pixel(1);
				}
			}
            e.Appointment.ToolTip = e.Appointment.Subject + ": " + e.Appointment.Description;
		}
}
