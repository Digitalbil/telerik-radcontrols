using RadComboBox_LoadOnDemand_WebAPI.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using Telerik.Web.UI;
using Newtonsoft.Json.Linq;

namespace RadComboBox_LoadOnDemand_WebAPI.Controllers
{
    public class ItemsController : ApiController
    {
        private const int ItemsPerRequest = 10;

        [HttpPost]
        [Route("api/items")]
        public RadComboBoxData GetComboItems([FromBody]RadComboBoxContext context)
        {
            string text = "";
            int numberOfItems = 0;

            foreach (var item in context)
            {
                JToken token = JObject.Parse(item.Value.ToString());
                text = (string)token.SelectToken("Text");
                numberOfItems = (int)token.SelectToken("NumberOfItems");
            }

            List<Product> products = GetProducts(text);

            RadComboBoxData comboData = new RadComboBoxData();
            int itemOffset = numberOfItems;
            int endOffset = Math.Min(itemOffset + ItemsPerRequest, products.Count);
            comboData.EndOfItems = endOffset == products.Count;

            List<RadComboBoxItemData> result = new List<RadComboBoxItemData>();

            for (int i = itemOffset; i < endOffset; i++)
            {
                RadComboBoxItemData itemData = new RadComboBoxItemData();
                itemData.Text = products[i].Name;
                itemData.Value = products[i].Id.ToString();

                result.Add(itemData);
            }

            comboData.Message = GetStatusMessage(endOffset, products.Count);

            comboData.Items = result.ToArray();
            return comboData;
        }


        public List<Product> GetProducts(string text)
        {
            List<Product> products = new List<Product>();

            products.Add(new Product(1, "Chai"));
            products.Add(new Product(2, "Chang"));
            products.Add(new Product(3, "Aniseed Syrup"));
            products.Add(new Product(4, "Chef Anton's Cajun Seasoning"));
            products.Add(new Product(5, "Chef Anton's Gumbo Mix"));
            products.Add(new Product(6, "Grandma's Boysenberry Spread"));
            products.Add(new Product(7, "Uncle Bob's Organic Dried Pears"));
            products.Add(new Product(8, "Northwoods Cranberry Sauce"));
            products.Add(new Product(9, "Mishi Kobe Niku"));
            products.Add(new Product(10, "Ikura"));
            products.Add(new Product(11, "Queso Cabrales"));
            products.Add(new Product(12, "Queso Manchego La Pastora"));
            products.Add(new Product(13, "Konbu"));
            products.Add(new Product(14, "Tofu"));
            products.Add(new Product(15, "Genen Shouyu"));
            products.Add(new Product(16, "Pavlova"));
            products.Add(new Product(17, "Alice Mutton"));
            products.Add(new Product(18, "Carnarvon Tigers"));
            products.Add(new Product(19, "Teatime Chocolate Biscuits"));
            products.Add(new Product(20, "Sir Rodney's Marmalade"));
            products.Add(new Product(21, "Sir Rodney's Scones"));
            products.Add(new Product(22, "Gustaf's Knäckebröd"));
            products.Add(new Product(23, "Tunnbröd"));
            products.Add(new Product(24, "Guaraná Fantástica"));
            products.Add(new Product(25, "NuNuCa Nuß-Nougat-Creme"));
            products.Add(new Product(26, "Gumbär Gummibärchen"));
            products.Add(new Product(27, "Schoggi Schokolade"));
            products.Add(new Product(28, "Rössle Sauerkraut"));
            products.Add(new Product(29, "Thüringer Rostbratwurst"));
            products.Add(new Product(30, "Nord-Ost Matjeshering"));
            products.Add(new Product(31, "Gorgonzola Telino"));
            products.Add(new Product(32, "Mascarpone Fabioli"));
            products.Add(new Product(33, "Geitost"));
            products.Add(new Product(34, "Sasquatch Ale"));
            products.Add(new Product(35, "Steeleye Stout"));
            products.Add(new Product(36, "Inlagd Sill"));
            products.Add(new Product(37, "Gravad lax"));
            products.Add(new Product(38, "Côte de Blaye"));
            products.Add(new Product(39, "Chartreuse verte"));
            products.Add(new Product(40, "Boston Crab Meat"));
            products.Add(new Product(41, "Jack's New England Clam Chowder"));
            products.Add(new Product(42, "Singaporean Hokkien Fried Mee"));
            products.Add(new Product(43, "Ipoh Coffee"));
            products.Add(new Product(44, "Gula Malacca"));
            products.Add(new Product(45, "Rogede sild"));
            products.Add(new Product(46, "Spegesild"));
            products.Add(new Product(47, "Zaanse koeken"));
            products.Add(new Product(48, "Chocolade"));
            products.Add(new Product(49, "Maxilaku"));
            products.Add(new Product(50, "Valkoinen suklaa"));
            products.Add(new Product(51, "Manjimup Dried Apples"));
            products.Add(new Product(52, "Filo Mix"));
            products.Add(new Product(53, "Perth Pasties"));
            products.Add(new Product(54, "Tourtière"));
            products.Add(new Product(55, "Pâté chinois"));
            products.Add(new Product(56, "Gnocchi di nonna Alice"));
            products.Add(new Product(57, "Ravioli Angelo"));
            products.Add(new Product(58, "Escargots de Bourgogne"));
            products.Add(new Product(59, "Raclette Courdavault"));
            products.Add(new Product(60, "Camembert Pierrot"));
            products.Add(new Product(61, "Sirop d'érable"));
            products.Add(new Product(62, "Tarte au sucre"));
            products.Add(new Product(63, "Vegie-spread"));
            products.Add(new Product(64, "Wimmers gute Semmelknödel"));
            products.Add(new Product(65, "Louisiana Fiery Hot Pepper Sauce"));
            products.Add(new Product(66, "Louisiana Hot Spiced Okra"));
            products.Add(new Product(67, "Laughing Lumberjack Lager"));
            products.Add(new Product(68, "Scottish Longbreads"));
            products.Add(new Product(69, "Gudbrandsdalsost"));
            products.Add(new Product(70, "Outback Lager"));
            products.Add(new Product(71, "Flotemysost"));
            products.Add(new Product(72, "Mozzarella di Giovanni"));
            products.Add(new Product(73, "Röd Kaviar"));
            products.Add(new Product(74, "Longlife Tofu"));
            products.Add(new Product(75, "Rhönbräu Klosterbier"));
            products.Add(new Product(76, "Lakkalikööri"));
            products.Add(new Product(77, "Original Frankfurter grüne Soße"));


            return products.Where(p => p.Name.Contains(text)).ToList();
        }


        private string GetStatusMessage(int offset, int total)
        {
            if (total <= 0)
                return "No matches";

            return String.Format("Items <b>1</b>-<b>{0}</b> out of <b>{1}</b>", offset, total);
        }
    }
}