using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using Telerik.Web.UI;

[ServiceBehavior(IncludeExceptionDetailInFaults = true)]
[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
public class Service
{

    [OperationContract]
    public Country[] GetCountries()
    {
        List<Country> countries = new List<Country>();
        countries.Add(new Country() { Name = "- Select Country -", Id = 0 });
        countries.Add(new Country() { Name = "USA", Id = 1 });
        countries.Add(new Country() { Name = "Canada", Id = 2 });

        var result = countries.ToArray();

        return result;
    }

    [OperationContract]
    public City[] GetCities(string context)
    {
        int id = Int32.Parse(context);
        
        List<City> cities = new List<City>();

        cities.Add(new City() { Id = 1, Name = "Seattle", CountryId = 1 });
        cities.Add(new City() { Id = 2, Name = "Washington DC", CountryId = 1 });
        cities.Add(new City() { Id = 3, Name = "Toronto", CountryId = 2 });
        cities.Add(new City() { Id = 4, Name = "Vancouver", CountryId = 2 });
        cities.Add(new City() { Id = 5, Name = "Montreal", CountryId = 2 });
     

        var filteredCities = cities.Where(c => c.CountryId == id).ToArray();

        return filteredCities;    
    }

}
