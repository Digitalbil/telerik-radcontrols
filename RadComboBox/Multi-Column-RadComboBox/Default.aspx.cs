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
using System.Collections.Generic;

public partial class Default : System.Web.UI.Page 
{
    protected void Page_Load(object sender, EventArgs e)
    {
        List<Contact> contacts = new List<Contact>();

        contacts.Add(new Contact() { ContactName = "Maria Anders", City = "Berlin", ContactTitle = "Sales Representative" });
        contacts.Add(new Contact() { ContactName = "Ana Trujillo", City = "Mexico D.F.", ContactTitle = "Owner" });
        contacts.Add(new Contact() { ContactName = "Thomas Hardy", City = "London", ContactTitle = "Owner" });

        RadComboBox1.DataSource = contacts;
        RadComboBox1.DataBind();
    }
}
