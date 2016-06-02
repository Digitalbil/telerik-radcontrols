using System;
using System.Web.UI;
using Telerik.Web.UI;

public partial class RadSchedulerWebForm1 : System.Web.UI.Page 
{
		protected void Page_Load(object sender, EventArgs e)
		{

            ScriptManager manager = RadScriptManager.GetCurrent(Page);
            manager.Scripts.Add(new ScriptReference("Telerik.Web.UI.Common.Core.js", "Telerik.Web.UI"));
            manager.Scripts.Add(new ScriptReference("Telerik.Web.UI.Common.jQuery.js", "Telerik.Web.UI"));
            manager.Scripts.Add(new ScriptReference("Telerik.Web.UI.Common.jQueryInclude.js", "Telerik.Web.UI"));
            manager.Scripts.Add(new ScriptReference(ResolveUrl("Scripts/jquery.tmpl.js")));
		}
}
