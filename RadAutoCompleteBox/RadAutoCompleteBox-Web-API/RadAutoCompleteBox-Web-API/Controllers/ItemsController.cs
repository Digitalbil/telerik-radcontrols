using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;

namespace RadAutoCompleteBox_Web_API.Controllers
{
    public class ItemsController : ApiController
    {
        public IEnumerable<Item> Get()
        {
            List<Item> items = new List<Item>();

            for (int i = 0; i < 10; i++)
            {
                items.Add(new Item() { Text = "Item " + i, Id = i });
            }
            return items;
        }
    }
}