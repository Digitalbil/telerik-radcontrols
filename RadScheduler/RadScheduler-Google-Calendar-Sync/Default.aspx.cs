using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using System.Data;
using System.Configuration;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using Telerik.Web.UI;
using DDay.iCal;
using System.Collections.Generic;
using System.IO;

public partial class Default : System.Web.UI.Page
{
    private const string AppointmentsKey = "Telerik.Web.Examples.Scheduler.ICalendarImport.CS";

    /// <summary>
    /// Gets the list of <seealso cref="AppointmentInfo"/> objects stored in the Session.
    /// If the list does not exist, creates a new one.
    /// </summary>
    private List<AppointmentInfo> Appointments
    {
        get
        {
            List<AppointmentInfo> sessApts = Session[AppointmentsKey] as List<AppointmentInfo>;
            if (sessApts == null)
            {
                sessApts = new List<AppointmentInfo>();
                Session[AppointmentsKey] = sessApts;
            }
            return sessApts;
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            Session.Remove(AppointmentsKey);
        }
        RadScheduler1.DataSource = Appointments;
    }

    protected void btnSync_Click(object sender, EventArgs e)
    {
        bool fileIsSuccessfullyRead = false;
        Appointments.Clear();
        try
        {
            byte[] response = new System.Net.WebClient().DownloadData(calendarUrl.Text);
            Stream stream = new MemoryStream(response) as Stream;
            iCalendar iCal = (DDay.iCal.iCalendar)iCalendar.LoadFromStream(stream)[0];

            Appointments.AddRange(RadSchedulerICalendarImporter.ImportEvents(iCal.Events));
            Appointments.AddRange(RadSchedulerICalendarImporter.ImportTodos(iCal.Todos));
            Appointments.AddRange(RadSchedulerICalendarImporter.ImportJournals(iCal.Journals));

            fileIsSuccessfullyRead = true;
        }
        catch (Exception ex)
        {
            lblSyncTime.Text = "Error!";
            lblSyncTime.ForeColor = System.Drawing.Color.Red;
        }

        if (fileIsSuccessfullyRead)
        {
            lblSyncTime.ForeColor = System.Drawing.Color.Green;
            lblSyncTime.Text = "Last synced: " + DateTime.Now;
        }
    }
}
