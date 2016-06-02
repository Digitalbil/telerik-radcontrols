Imports System
Imports System.Web.UI
Imports Telerik.Web.UI

Partial Class RadSchedulerWebForm
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(sender As Object, e As EventArgs)
        Dim manager As ScriptManager = RadScriptManager.GetCurrent(Page)
        manager.Scripts.Add(New ScriptReference("Telerik.Web.UI.Common.Core.js", "Telerik.Web.UI"))
        manager.Scripts.Add(New ScriptReference("Telerik.Web.UI.Common.jQuery.js", "Telerik.Web.UI"))
        manager.Scripts.Add(New ScriptReference("Telerik.Web.UI.Common.jQueryInclude.js", "Telerik.Web.UI"))
        manager.Scripts.Add(New ScriptReference(ResolveUrl("Scripts/jquery.tmpl.js")))

       
    End Sub


End Class
