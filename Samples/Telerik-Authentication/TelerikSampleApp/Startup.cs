using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(TelerikSampleApp.Startup))]
namespace TelerikSampleApp
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
