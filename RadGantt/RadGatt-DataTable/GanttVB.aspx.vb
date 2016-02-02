Imports System.Data

Partial Class Controls_Gantt_GanttVB
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        RadGantt1.DataSource = Tasks
        RadGantt1.DependenciesDataSource = Dependencies
    End Sub

    Private ReadOnly Property Tasks As DataTable
        Get
            Dim dt As New DataTable
            dt.Columns.Add("ID", GetType(Object))
            dt.Columns.Add("Title", GetType(String))
            dt.Columns.Add("Start", GetType(Date))
            dt.Columns.Add("End", GetType(Date))
            dt.Columns.Add("PercentComplete", GetType(Decimal))
            dt.Columns.Add("OrderID", GetType(Object))
            dt.Columns.Add("Summary", GetType(Boolean))
            dt.Columns.Add("ParentID", GetType(Object))

            Dim dr As DataRow = dt.NewRow

            dr("ID") = 1
            dr("Title") = "Planning Stage"
            dr("Start") = New DateTime(2015, 12, 7)
            dr("End") = New DateTime(2016, 7, 12)
            dr("Summary") = False
            dr("PercentComplete") = 0
            dr("OrderID") = 0

            dt.Rows.Add(dr)

            Return dt
        End Get
    End Property

    Private ReadOnly Property Dependencies As DataTable
        Get
            Dim dt As New DataTable
            dt.Columns.Add("ID", GetType(Object))
            dt.Columns.Add("PredecessorID", GetType(Object))
            dt.Columns.Add("SuccessorID", GetType(Object))
            dt.Columns.Add("Type", GetType(Integer))

            Dim dr As DataRow = dt.NewRow

            Return dt
        End Get
    End Property

End Class
