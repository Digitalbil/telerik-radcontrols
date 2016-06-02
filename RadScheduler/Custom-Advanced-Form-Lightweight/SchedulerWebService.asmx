<%@ WebService Language="C#" Class="SchedulerWebService" %>

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.Services;
using Telerik.Web.UI;
using System.Web.Script.Services;

[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
// To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
[System.Web.Script.Services.ScriptService]
public class SchedulerWebService  : System.Web.Services.WebService 
{
    private WebServiceAppointmentController _controller;

    /// <summary>
    /// The WebServiceAppointmentController class is used as a facade to the SchedulerProvider.
    /// </summary>
    private WebServiceAppointmentController Controller
    {
        get
        {
            if (_controller == null)
            {
                _controller = new WebServiceAppointmentController(new XmlSchedulerProvider(Server.MapPath("Appointments_CustomTemplates.xml"), true));
            }
            return _controller;
        }
    }
    [WebMethod]
    public IEnumerable<AppointmentData> GetAppointments(SchedulerInfo schedulerInfo)
    {
        return Controller.GetAppointments(schedulerInfo);
    }
    [WebMethod]
    public IEnumerable<AppointmentData> InsertAppointment(SchedulerInfo schedulerInfo, AppointmentData appointmentData)
    {
        return Controller.InsertAppointment(schedulerInfo, appointmentData);
    }
    [WebMethod]
    public IEnumerable<AppointmentData> UpdateAppointment(SchedulerInfo schedulerInfo, AppointmentData appointmentData)
    {
        return Controller.UpdateAppointment(schedulerInfo, appointmentData);
    }
    [WebMethod]
    public IEnumerable<AppointmentData> CreateRecurrenceException(SchedulerInfo schedulerInfo, AppointmentData recurrenceExceptionData)
    {
        return Controller.CreateRecurrenceException(schedulerInfo, recurrenceExceptionData);
    }
    [WebMethod]
    public IEnumerable<AppointmentData> RemoveRecurrenceExceptions(SchedulerInfo schedulerInfo, AppointmentData masterAppointmentData)
    {
        return Controller.RemoveRecurrenceExceptions(schedulerInfo, masterAppointmentData);
    }
    [WebMethod]
    public IEnumerable<AppointmentData> DeleteAppointment(SchedulerInfo schedulerInfo, AppointmentData appointmentData, bool deleteSeries)
    {
        return Controller.DeleteAppointment(schedulerInfo, appointmentData, deleteSeries);
    }
    [WebMethod]
    public IEnumerable<ResourceData> GetResources(SchedulerInfo schedulerInfo)
    {
        return Controller.GetResources(schedulerInfo);
    }
}