using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Holds data for a single Appointment.
/// </summary>
public class AppointmentInfo
{
    private readonly string _id;
    private string _subject;
    private DateTime _start;
    private DateTime _end;
    private string _recurrenceRule;
    private string _recurrenceParentId;
    private string _description;
    private string _reminder;
    public string ID
    {
        get { return _id; }
    }
    public string Subject
    {
        get { return _subject; }
        set { _subject = value; }
    }
    public DateTime Start
    {
        get { return _start; }
        set { _start = value; }
    }
    public DateTime End
    {
        get { return _end; }
        set { _end = value; }
    }
    public string RecurrenceRule
    {
        get { return _recurrenceRule; }
        set { _recurrenceRule = value; }
    }
    public string RecurrenceParentID
    {
        get { return _recurrenceParentId; }
        set { _recurrenceParentId = value; }
    }
    public string Description
    {
        get { return _description; }
        set { _description = value; }
    }
    public string Reminder
    {
        get { return _reminder; }
        set { _reminder = value; }
    }
    private AppointmentInfo()
    {
        _id = Guid.NewGuid().ToString();
        _description = String.Empty;
    }
    public AppointmentInfo(string subject, DateTime start, DateTime end,
        string recurrenceRule, string recurrenceParentID, string reminder)
        : this()
    {
        _subject = subject;
        _start = start;
        _end = end;
        _recurrenceRule = recurrenceRule;
        _recurrenceParentId = recurrenceParentID;
        _reminder = reminder;
    }
}
