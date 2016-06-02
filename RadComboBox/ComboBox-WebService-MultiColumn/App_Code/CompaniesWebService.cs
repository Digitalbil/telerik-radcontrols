using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Services;
using Telerik.Web.UI;
using System.Web.SessionState;
using System.Web.Script.Services;
using System.Configuration;

[WebService(Namespace = "http://tempuri.org/ComboWebService")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
[ScriptService]
public class CompaniesWebService : System.Web.Services.WebService, IRequiresSessionState
{
    private const int ItemsPerRequest = 10;

    [WebMethod]
    public RadComboBoxData GetCompanyNames(RadComboBoxContext context)
    {
        List<ComboBoxItemData> data = GetData(context.Text);

        RadComboBoxData comboData = new RadComboBoxData();
        int itemOffset = context.NumberOfItems;
        int endOffset = Math.Min(itemOffset + ItemsPerRequest, data.Count);
        comboData.EndOfItems = endOffset == data.Count;

        List<RadComboBoxItemData> result = new List<RadComboBoxItemData>(endOffset - itemOffset);

        for (int i = itemOffset; i < endOffset; i++)
        {
            RadComboBoxItemData itemData = new RadComboBoxItemData();
            itemData.Text = data[i].CompanyName;
            itemData.Value = data[i].CompanyId.ToString();
            itemData.Attributes["Branch"] = data[i].BranchName;
            itemData.Attributes["Site"] = data[i].SiteName;

            result.Add(itemData);
        }

        comboData.Message = GetStatusMessage(endOffset, data.Count);

        comboData.Items = result.ToArray();
        return comboData;
    }

    private string GetStatusMessage(int offset, int total)
    {
        if (total <= 0)
            return "No matches";

        return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
    }

    private List<ComboBoxItemData> GetData(string searchText)
    { 
        List<ComboBoxItemData> list = new List<ComboBoxItemData>();

        for (int i = 0; i < 51; i++)
        {
            list.Add(new ComboBoxItemData
            {
                CompanyName = "Comp" + i,
                BranchName = "Branch" + i,
                SiteName = "Site" + i,

                SiteId = i,
                CompanyId = i,
                BranchId = i
            });
        }

        if (!string.IsNullOrEmpty(searchText))
        {
            return list.Where(x => x.CompanyName.Contains(searchText)).ToList<ComboBoxItemData>();
        }
        //data = data.FindAll(x => x.CompanyName.StartsWith(searchText) || x.BranchName.StartsWith(searchText) || x.SiteName.StartsWith(searchText));
        //      context.Clear();

        return list;
    }
}
