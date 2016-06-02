<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AdvancedForm.ascx.cs" Inherits="RadSchedulerAdvancedFormAdvancedForm" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="scheduler" TagName="ResourceControl" Src="ResourceControl.ascx" %>
<%@ Register TagPrefix="scheduler" TagName="MultipleValuesResourceControl" Src="MultipleValuesResourceControl.ascx" %>
<div class="rsAdvancedEdit rsAdvancedModal" style="position: relative">
    <%-- Title bar. --%>
    <div class="rsAdvTitle rsTitle">
        <%-- The rsAdvInnerTitle element is used as a drag handle when the form is modal. --%>
        <%= (this.Mode.ToString() == "Edit") ? Owner.Localization.AdvancedEditAppointment : Owner.Localization.AdvancedNewAppointment %>
        <asp:LinkButton runat="server" ID="AdvancedEditCloseButton" CssClass="rsAdvEditClose"
            CommandName="Cancel" CausesValidation="false" ToolTip='<%# Owner.Localization.AdvancedClose %>'>
            <span class="rsIcon rsIconClose"></span>
        </asp:LinkButton>
    </div>
    <div class="rsAdvContentWrapper rsBody">
        <%-- Scroll container - when the form height exceeds MaximumHeight scrollbars will appear on this element--%>
        <asp:Panel runat="server" ID="AdvOptionsScroll" CssClass="rsAdvOptionsScroll" OnDataBinding="AdvOptionsScroll_DataBinding">
            <ul class="rfbGroup">
                <li class="rfbRow">
                    <telerik:RadTextBox runat="server" ID="SubjectText" Width="100%" LabelCssClass="rfbLabel"
                        Label='<%# Owner.Localization.AdvancedSubject %>' RenderMode="Lightweight" />
                    <asp:RequiredFieldValidator runat="server" ID="SubjectValidator" ControlToValidate="SubjectText"
                        EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" />
                </li>
                <li class="rfbRow rsTimePick">
                    <label class="rfbLabel" for='<%= StartDate.ClientID %>_dateInput_text'>
                        <%= Owner.Localization.AdvancedFrom %></label><%--
                        Leaving a newline here will affect the layout, so we use a comment instead.
                        --%><telerik:RadDatePicker runat="server" ID="StartDate" CssClass="rsAdvDatePicker"
                            SharedCalendarID="SharedCalendar" Culture='<%# Owner.Culture %>'
                            MinDate="1900-01-01" RenderMode="Lightweight">
                            <DateInput ID="DateInput2" runat="server" DateFormat='<%# Owner.AdvancedForm.DateFormat %>'
                                EmptyMessageStyle-CssClass="riError" EmptyMessage=" " />
                        </telerik:RadDatePicker>
                    <%--
                                    
                    --%><telerik:RadTimePicker runat="server" ID="StartTime" CssClass="rsAdvTimePicker"
                            Culture='<%# Owner.Culture %>' RenderMode="Lightweight">
                        <DateInput ID="DateInput3" runat="server" EmptyMessageStyle-CssClass="riError" EmptyMessage=" " />
                        <TimeView ID="TimeView1" runat="server" Columns="2" ShowHeader="false" StartTime="08:00"
                            EndTime="18:00" Interval="00:30" />
                    </telerik:RadTimePicker>
                </li>
                <li class="rfbRow rsTimePick rsEndTimePick">
                    <label class="rfbLabel" for='<%= EndDate.ClientID %>_dateInput_text'>
                        <%= Owner.Localization.AdvancedTo%></label><%--
                                    
                        --%><telerik:RadDatePicker runat="server" ID="EndDate" CssClass="rsAdvDatePicker"
                            SharedCalendarID="SharedCalendar" Culture='<%# Owner.Culture %>'
                            MinDate="1900-01-01" RenderMode="Lightweight">
                            <DateInput ID="DateInput4" runat="server" DateFormat='<%# Owner.AdvancedForm.DateFormat %>'
                                EmptyMessageStyle-CssClass="riError" EmptyMessage=" " />
                        </telerik:RadDatePicker>
                    <%--
                                    
                    --%><telerik:RadTimePicker runat="server" ID="EndTime" CssClass="rsAdvTimePicker"
                        Culture='<%# Owner.Culture %>' RenderMode="Lightweight">
                        <DateInput ID="DateInput5" runat="server" EmptyMessageStyle-CssClass="riError" EmptyMessage=" " />
                        <TimeView ID="TimeView2" runat="server" Columns="2" ShowHeader="false" StartTime="08:00"
                            EndTime="18:00" Interval="00:30" />
                    </telerik:RadTimePicker>
                </li>
                <li class="rfbRow">
                    <asp:RequiredFieldValidator runat="server" ID="StartDateValidator" ControlToValidate="StartDate"
                        EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" />
                    <asp:RequiredFieldValidator runat="server" ID="StartTimeValidator" ControlToValidate="StartTime"
                        EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" />
                    <asp:RequiredFieldValidator runat="server" ID="EndDateValidator" ControlToValidate="EndDate"
                        EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" />
                    <asp:RequiredFieldValidator runat="server" ID="EndTimeValidator" ControlToValidate="EndTime"
                        EnableClientScript="true" Display="None" CssClass="rsValidatorMsg" />
                    <asp:CustomValidator runat="server" ID="DurationValidator" ControlToValidate="StartDate"
                        EnableClientScript="false" Display="Dynamic" CssClass="rsValidatorMsg rsInvalid"
                        OnServerValidate="DurationValidator_OnServerValidate" />
                </li>
                <li class="rfbRow rsAllDayWrapper">
                    <label class="rfbLabel" for='<%= AllDayEvent.ClientID %>'>
                        <%= Owner.Localization.AdvancedAllDayEvent%></label>
                    <asp:CheckBox runat="server" ID="AllDayEvent" CssClass="rsAdvChkWrap" Checked="false" />
                </li>
                <li class="rfbRow rsTimeZonesWrapper">
                    <label class="rfbLabel"><%= Owner.Localization.AdvancedTimeZone%></label>
                    <telerik:RadDropDownList runat="server" Visible="true" ID="TimeZonesDropDown" LabelCssClass="rfbLabel"
                        RenderMode="Lightweight">
                    </telerik:RadDropDownList>
                </li>
                <li class="rfbRow rsReminderWrapper">
                    <label class="rfbLabel"><%= Owner.Localization.Reminder%></label>
                    <telerik:RadDropDownList runat="server" ID="ReminderDropDown"
                        RenderMode="Lightweight" DropDownHeight="250">
                        <Items>
                            <telerik:DropDownListItem Text='<%# Owner.Localization.ReminderNone %>' Value="" />
                            <telerik:DropDownListItem Text='<%# "0 " + Owner.Localization.ReminderMinutes %>'
                                Value="0" />
                            <telerik:DropDownListItem Text='<%# "5 " + Owner.Localization.ReminderMinutes %>'
                                Value="5" />
                            <telerik:DropDownListItem Text='<%# "10 " + Owner.Localization.ReminderMinutes %>'
                                Value="10" />
                            <telerik:DropDownListItem Text='<%# "15 " + Owner.Localization.ReminderMinutes %>'
                                Value="15" />
                            <telerik:DropDownListItem Text='<%# "30 " + Owner.Localization.ReminderMinutes %>'
                                Value="30" />
                            <telerik:DropDownListItem Text='<%# "1 " + Owner.Localization.ReminderHour %>' Value="60" />
                            <telerik:DropDownListItem Text='<%# "2 " + Owner.Localization.ReminderHours %>' Value="120" />
                            <telerik:DropDownListItem Text='<%# "3 " + Owner.Localization.ReminderHours %>' Value="180" />
                            <telerik:DropDownListItem Text='<%# "4 " + Owner.Localization.ReminderHours %>' Value="240" />
                            <telerik:DropDownListItem Text='<%# "5 " + Owner.Localization.ReminderHours %>' Value="300" />
                            <telerik:DropDownListItem Text='<%# "6 " + Owner.Localization.ReminderHours %>' Value="360" />
                            <telerik:DropDownListItem Text='<%# "7 " + Owner.Localization.ReminderHours %>' Value="420" />
                            <telerik:DropDownListItem Text='<%# "8 " + Owner.Localization.ReminderHours %>' Value="480" />
                            <telerik:DropDownListItem Text='<%# "9 " + Owner.Localization.ReminderHours %>' Value="540" />
                            <telerik:DropDownListItem Text='<%# "10 " + Owner.Localization.ReminderHours %>' Value="600" />
                            <telerik:DropDownListItem Text='<%# "11 " + Owner.Localization.ReminderHours %>' Value="660" />
                            <telerik:DropDownListItem Text='<%# "12 " + Owner.Localization.ReminderHours %>' Value="720" />
                            <telerik:DropDownListItem Text='<%# "18 " + Owner.Localization.ReminderHours %>' Value="1080" />
                            <telerik:DropDownListItem Text='<%# "1 " + Owner.Localization.ReminderDays %>' Value="1440" />
                            <telerik:DropDownListItem Text='<%# "2 " + Owner.Localization.ReminderDays %>' Value="2880" />
                            <telerik:DropDownListItem Text='<%# "3 " + Owner.Localization.ReminderDays %>' Value="4320" />
                            <telerik:DropDownListItem Text='<%# "4 " + Owner.Localization.ReminderDays %>' Value="5760" />
                            <telerik:DropDownListItem Text='<%# "1 " + Owner.Localization.ReminderWeek %>' Value="10080" />
                            <telerik:DropDownListItem Text='<%# "2 " + Owner.Localization.ReminderWeeks %>' Value="20160" />
                        </Items>
                    </telerik:RadDropDownList>
                </li>
                <%-- RESOURCE CONTROLS --%>
                <li class="rfbRow">
                    <!-- Resource controls should follow the convention Res[Resource Name] for ID -->
                    <scheduler:ResourceControl runat="server" ID="ResRoom" Type="Room" Label="Room" />
                </li>
                <li class="rfbRow">
                    <scheduler:MultipleValuesResourceControl runat="server" ID="ResUser" Type="User"
                        Label="User" />
                </li>
                <!-- Optionally add more ResourceControl instances here -->
                <li class="rfbRow">
                    <telerik:RadTextBox runat="server" ID="DescriptionText" TextMode="MultiLine" Columns="50" LabelCssClass="rfbLabel"
                        Rows="5" Width="100%" Label='<%# Owner.Localization.AdvancedDescription %>'
                        Text='<%# Eval("Description") %>' RenderMode="Lightweight" />
                </li>
                <li class="rfbRow">
                    <label class="rfbLabel">
                        Color
                    </label>
                    <telerik:RadColorPicker ID="AppointmentColorPicker" runat="server" CssClass="rsAdvResourceValue"
                        RenderMode="Lightweight"
                        ShowIcon="true" PaletteModes="WebPalette">
                    </telerik:RadColorPicker>
                </li>
            </ul>
            <span class="rsAdvResetExceptions">
                <asp:LinkButton runat="server" ID="ResetExceptions" OnClick="ResetExceptions_OnClick" />
            </span>
            <telerik:RadSchedulerRecurrenceEditor runat="server" ID="AppointmentRecurrenceEditor" Visible="true" RenderMode="Lightweight" />
            <asp:HiddenField runat="server" ID="OriginalRecurrenceRule" />
            <telerik:RadCalendar runat="server" ID="SharedCalendar" RenderMode="Lightweight"
                CultureInfo='<%# Owner.Culture %>' ShowRowHeaders="false" RangeMinDate="1900-01-01" />
        </asp:Panel>
        <asp:Panel runat="server" ID="ButtonsPanel" CssClass="rsAdvButtonWrapper rsCommandFooter">
            <asp:LinkButton runat="server" ID="UpdateButton" CssClass="rsAdvEditSave rsButton">
                        <span><%= Owner.Localization.Save %></span>
            </asp:LinkButton>
            <asp:LinkButton runat="server" ID="CancelButton" CssClass="rsAdvEditCancel rsButton" CommandName="Cancel"
                CausesValidation="false">
                        <span><%= Owner.Localization.Cancel %></span>
            </asp:LinkButton>
        </asp:Panel>
    </div>
</div>
