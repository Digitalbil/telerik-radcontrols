using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.IO;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Text;
using System.Web;
using Telerik.Web.UI;

[ServiceContract(Namespace = "")]
[AspNetCompatibilityRequirements(RequirementsMode = AspNetCompatibilityRequirementsMode.Allowed)]
[ServiceBehavior(IncludeExceptionDetailInFaults = true)]
public class Service
{
    [OperationContract]
    [WebInvoke(Method = "POST")]
    public Stream Export(Stream input)
    {
        StreamReader sr = new StreamReader(input);
        string s = sr.ReadToEnd();
        sr.Dispose();
        NameValueCollection qs = HttpUtility.ParseQueryString(s);
        string fileName = qs["fileName"];
        string base64 = qs["base64"];
        string contentType = qs["contentType"];

        byte[] data = Convert.FromBase64String(base64);

        MemoryStream stream = new MemoryStream(data);
        WebOperationContext.Current.OutgoingResponse.ContentType = contentType;
        stream.Position = 0;
        return stream;
    }
}