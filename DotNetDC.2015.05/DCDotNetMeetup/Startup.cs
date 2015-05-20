using Microsoft.AspNet.Builder;
using Microsoft.AspNet.Http;
using Microsoft.AspNet.Hosting;
using Microsoft.Framework.DependencyInjection;

namespace DCDotNetMeetup
{
	public class Startup
	{
		public void ConfigureServices(IServiceCollection services)
		{
			services.AddSingleton<EnglishGreeter>();
			services.AddSingleton<RussianGreeter>();
			services.AddScoped<IGreeter>(factory => {
				var c = factory.GetRequiredService<IHttpContextAccessor>();
				HttpContext context = c.HttpContext;
				var isRu = context.Request.Path.StartsWithSegments(new PathString("/ru"));
				if (isRu)
					return factory.GetRequiredService<RussianGreeter>();
				else
					return factory.GetRequiredService<EnglishGreeter>();
			});
			services.AddMvc();
			services.ConfigureMvc(config => {
			});
		}
		
		public void Configure(IApplicationBuilder app)
		{
			app.UseMvc(routes => {
				routes.MapRoute("Default", "{controller}/{action}");
			});
		}
	}
}