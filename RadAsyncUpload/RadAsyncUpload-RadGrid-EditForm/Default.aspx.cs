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

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            RadGrid1.DataSource = GetData();
            RadGrid1.DataBind();
        }
    }

    private DataTable GetData()
    {
        System.Data.DataTable table = new DataTable();
        DataColumn column;
        DataRow row;

        column = new DataColumn();
        column.DataType = System.Type.GetType("System.Int32");
        column.ColumnName = "ID";
        column.ReadOnly = true;
        table.Columns.Add(column);

        column = new DataColumn();
        column.DataType = System.Type.GetType("System.String");
        column.ColumnName = "Description";
        column.AutoIncrement = false;
        column.Caption = "Description";
        column.ReadOnly = false;
        column.Unique = false;
        column.AllowDBNull = true;
        table.Columns.Add(column);

        DataColumn[] PrimaryKeyColumns = new DataColumn[1];
        PrimaryKeyColumns[0] = table.Columns["ID"];
        table.PrimaryKey = PrimaryKeyColumns;

        //Generating Data
        row = table.NewRow();
        row["ID"] = 1;
        row["Description"] = "Description";
        table.Rows.Add(row);

        return table;
    }
    protected void RadGrid1_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        RadGrid1.DataSource = GetData();
    }

    protected void RadGrid1_UpdateCommand(object sender, GridCommandEventArgs e)
    {
        GridEditFormItem editForm = (GridEditFormItem)e.Item;
        RadAsyncUpload upload = (RadAsyncUpload) editForm.FindControl("RadAsyncUpload1");

        if (upload != null)
        {
            foreach (UploadedFile file in upload.UploadedFiles)
            {
                string target = Server.MapPath("~/Uploads/");
                file.SaveAs(target + file.FileName);
            }
        }
    }
}
