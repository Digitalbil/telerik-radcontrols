using System;
using System.Web.UI;
using System.Web;
using System.Text;
using Telerik.Web.UI;
using System.Collections.Generic;
using System.IO;
using DDay.iCal;

public class RadSchedulerICalendarImporter
{
    /// <summary>
    /// Imports Events, read from the iCalendar file, in RadScheduler.
    /// </summary>
    /// <param name="events">An <seealso cref="IList" /> of <seealso cref="Event" /> objects
    /// holding data for Event components.</param>
    /// <returns></returns>
    public static IEnumerable<AppointmentInfo> ImportEvents(IUniqueComponentList<IEvent> events)
    {
        List<AppointmentInfo> appointments = new List<AppointmentInfo>();
        foreach (Event eventComponent in events)
        {
            if ((eventComponent.Start != null) &&
                (eventComponent.End != null))
            {
                string summary = eventComponent.Summary ?? String.Empty;
                DateTime startDate = eventComponent.Start.Local;
                DateTime endDate = eventComponent.End.Local;
                string recurrenceRule = GetSchedulerRecurrenceRule(startDate, endDate, eventComponent);
                string recurrenceParentID = null;
                string description = eventComponent.Description ?? String.Empty;
                string reminder = eventComponent.Alarms.Count > 0 ? new Reminder(eventComponent.Alarms[0].Trigger.Duration.Value.Duration()).ToString() : String.Empty;
                AppointmentInfo appInfo = new AppointmentInfo(
                    summary,
                    startDate,
                    endDate,
                    recurrenceRule,
                    recurrenceParentID,
                    reminder);
                appInfo.Description = description;
                appointments.Add(appInfo);
            }
        }
        return appointments;
    }
    /// <summary>
    /// Imports the todos.
    /// </summary>
    /// <param name="todos">The todos.</param>
    /// <returns></returns>
    public static IEnumerable<AppointmentInfo> ImportTodos(IUniqueComponentList<ITodo> todos)
    {
        List<AppointmentInfo> appointments = new List<AppointmentInfo>();
        foreach (Todo todo in todos)
        {
            if (todo.Start != null)
            {
                string summary = todo.Summary ?? String.Empty;
                DateTime startDate = todo.Start.Local;
                //Import To-Dos as All Day events as they do not have End Date.
                DateTime endDate = startDate.AddDays(1);
                string recurrenceRule = GetSchedulerRecurrenceRule(startDate, endDate, todo);
                //Recurrence Exceptions are not currently supported as they can be defined
                //in varios ways and should be handled specifically.
                string recurrenceParentID = null;
                string description = todo.Description ?? String.Empty;
                string reminder = todo.Alarms.Count > 0 ? new Reminder(todo.Alarms[0].Trigger.Duration.Value.Duration()).ToString() : String.Empty;
                AppointmentInfo appInfo = new AppointmentInfo(
                    summary,
                    startDate,
                    endDate,
                    recurrenceRule,
                    recurrenceParentID,
                    reminder);
                appInfo.Description = description;
                appointments.Add(appInfo);
            }
        }
        return appointments;
    }
    /// <summary>
    /// Imports Journals, read from the iCalendar file, as All Day events in RadScheduler.
    /// </summary>
    /// <param name="todos">An <see cref="IList"/> of <seealso cref="Journal"/> objects holding data for 
    /// Journal components.</param>
    public static IEnumerable<AppointmentInfo> ImportJournals(ICalendarObjectList<IJournal> journals)
    {
        List<AppointmentInfo> appointments = new List<AppointmentInfo>();
        foreach (Journal journal in journals)
        {
            if (journal.Start != null)
            {
                string summary = journal.Summary ?? String.Empty;
                DateTime startDate = journal.Start.Local;
                //Import Journals as All Day events as they do not have End Date.
                DateTime endDate = startDate.AddDays(1);
                string recurrenceRule = GetSchedulerRecurrenceRule(startDate, endDate, journal);
                //Recurrence Exceptions are not currently supported as they can be defined
                //in varios ways and should be handled specifically.
                string recurrenceParentID = null;
                string description = journal.Description ?? String.Empty;
                string reminder = journal.Alarms.Count > 0 ? new Reminder(journal.Alarms[0].Trigger.Duration.Value.Duration()).ToString() : String.Empty;
                AppointmentInfo appInfo = new AppointmentInfo(
                    summary,
                    startDate,
                    endDate,
                    recurrenceRule,
                    recurrenceParentID,
                    reminder);
                appInfo.Description = description;
                appointments.Add(appInfo);
            }
        }
        return appointments;
    }
    /// <summary>
    /// Creates a Recurrence Rule in RadScheduler-friendly format from the RRule of the specified Recurring component.
    /// </summary>
    /// <param name="startDate">The Start Date of the Recurring component.</param>
    /// <param name="endDate">The End Date of the Recurring component.</param>
    /// <param name="recurringComponent">The Recurring component.</param>
    /// <returns>A <see cref="string"/> representation of the RRule in RadScheduler-friendly format.</returns>
    private static string GetSchedulerRecurrenceRule(DateTime startDate, DateTime endDate, RecurringComponent recurringComponent)
    {
        string recurrenceRuleString = String.Empty;
        if ((recurringComponent.RecurrenceRules != null) &&
            (recurringComponent.RecurrenceRules[0] != null))
        {
            RecurrenceRange schedulerRange = new RecurrenceRange();
            schedulerRange.Start = startDate;
            schedulerRange.EventDuration = endDate - startDate;
            DDay.iCal.RecurrencePattern iCalPattern = (DDay.iCal.RecurrencePattern)recurringComponent.RecurrenceRules[0];
            if (iCalPattern.Count > 0)
            {
                schedulerRange.MaxOccurrences = iCalPattern.Count;
            }
            else if ((iCalPattern.Until != null))//&&   (iCalPattern.IsValidDate(iCalPattern.Until))
            {
                schedulerRange.RecursUntil = iCalPattern.Until.ToLocalTime();
            }
            RecurrenceRule schedulerRRule = null;
            int iCallPatternInterval = iCalPattern.Interval;
            RecurrenceDay schedulerRecurrenceDay = GetSchedulerRecurrenceDay(iCalPattern.ByDay);
            switch (iCalPattern.Frequency)
            {
                case FrequencyType.Hourly:
                    schedulerRRule =
                        new HourlyRecurrenceRule(iCallPatternInterval, schedulerRange);
                    break;
                case FrequencyType.Daily:
                    if (schedulerRecurrenceDay == RecurrenceDay.None)
                    {
                        schedulerRRule =
                            new DailyRecurrenceRule(iCallPatternInterval, schedulerRange);
                    }
                    else
                    {
                        schedulerRRule =
                            new DailyRecurrenceRule(schedulerRecurrenceDay, schedulerRange);
                    }
                    break;
                case FrequencyType.Weekly:
                    if (schedulerRecurrenceDay == RecurrenceDay.None)
                    {
                        schedulerRRule =
                            new WeeklyRecurrenceRule(
                                iCallPatternInterval,
                                (RecurrenceDay)startDate.DayOfWeek,
                                schedulerRange,
                                iCalPattern.FirstDayOfWeek);
                    }
                    else
                    {
                        schedulerRRule =
                            new WeeklyRecurrenceRule(
                                iCallPatternInterval,
                                schedulerRecurrenceDay,
                                schedulerRange,
                                iCalPattern.FirstDayOfWeek);
                    }
                    break;
                case FrequencyType.Monthly:
                    if (iCalPattern.ByMonthDay.Count > 0)
                    {
                        schedulerRRule = new MonthlyRecurrenceRule(
                            iCalPattern.ByMonthDay[0],
                            iCallPatternInterval,
                            schedulerRange);
                    }
                    else if (iCalPattern.BySetPosition.Count > 0)
                    {
                        schedulerRRule = new MonthlyRecurrenceRule(
                            iCalPattern.BySetPosition[0],
                            schedulerRecurrenceDay,
                            iCallPatternInterval,
                            schedulerRange);
                    }
                    else
                    {
                        schedulerRRule = new MonthlyRecurrenceRule(
                            startDate.Day,
                            iCallPatternInterval,
                            schedulerRange);
                    }
                    break;
                case FrequencyType.Yearly:
                    if (iCalPattern.ByMonth.Count > 0)
                    {
                        if (iCalPattern.ByMonthDay.Count > 0)
                        {
                            schedulerRRule = new YearlyRecurrenceRule(
                                (RecurrenceMonth)iCalPattern.ByMonth[0],
                                iCalPattern.ByMonthDay[0],
                                schedulerRange);
                        }
                        else if (iCalPattern.BySetPosition.Count > 0)
                        {
                            schedulerRRule = new YearlyRecurrenceRule(
                                iCalPattern.BySetPosition[0],
                                (RecurrenceMonth)iCalPattern.ByMonth[0],
                                schedulerRecurrenceDay,
                                schedulerRange);
                        }
                        else
                        {
                            schedulerRRule = new YearlyRecurrenceRule(
                                (RecurrenceMonth)iCalPattern.ByMonth[0],
                                startDate.Day,
                                schedulerRange);
                        }
                    }
                    else
                    {
                        schedulerRRule = new YearlyRecurrenceRule(
                                (RecurrenceMonth)startDate.Month,
                                startDate.Day,
                                schedulerRange);
                    }
                    break;
                default:
                    break;
            }
            if (schedulerRRule != null)
            {
                AddRecurrenceExceptions(schedulerRRule, recurringComponent);
                recurrenceRuleString = schedulerRRule.ToString();
            }
        }
        return recurrenceRuleString;
    }
    /// <summary>
    /// Gets the scheduler recurrence day.
    /// </summary>
    /// <param name="byDay">The by day.</param>
    /// <returns></returns>
    private static RecurrenceDay GetSchedulerRecurrenceDay(IList<IWeekDay> byDay)
    {
        RecurrenceDay schedulerRecurrenceDay = RecurrenceDay.None;
        foreach (WeekDay daySpecifier in byDay)
        {
            switch (daySpecifier.DayOfWeek)
            {
                case DayOfWeek.Monday:
                    schedulerRecurrenceDay |= RecurrenceDay.Monday;
                    break;
                case DayOfWeek.Tuesday:
                    schedulerRecurrenceDay |= RecurrenceDay.Tuesday;
                    break;
                case DayOfWeek.Wednesday:
                    schedulerRecurrenceDay |= RecurrenceDay.Wednesday;
                    break;
                case DayOfWeek.Thursday:
                    schedulerRecurrenceDay |= RecurrenceDay.Thursday;
                    break;
                case DayOfWeek.Friday:
                    schedulerRecurrenceDay |= RecurrenceDay.Friday;
                    break;
                default:
                    break;
            }
        }
        return schedulerRecurrenceDay;
    }
    /// <summary>
    /// Adds all exceptions defined in the EXDATE property of the specified Recurring Component in
    /// the list of Exceptions of the Scheduler Recurrence Rule.
    /// </summary>
    /// <param name="schedulerRRule"><seealso cref="RecurrenceRule"/> as the Scheduler Recurrence Rule.</param>
    /// <param name="recurringComponent">The <seealso cref="RecurringComponent"/> object.</param>
    private static void AddRecurrenceExceptions(RecurrenceRule schedulerRRule, RecurringComponent recurringComponent)
    {
        if (recurringComponent.ExceptionDates != null)
        {
            foreach (IPeriodList exceptionDates in recurringComponent.ExceptionDates)
            {
                foreach (Period period in exceptionDates)
                {
                    if (period.StartTime != null)
                    {
                        schedulerRRule.Exceptions.Add(period.StartTime.Local);
                    }
                }
            }
        }
    }
}