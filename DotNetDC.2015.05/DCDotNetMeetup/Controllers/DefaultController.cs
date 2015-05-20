using Microsoft.AspNet.Mvc;
namespace DCDotNetMeetup.Controllers
{
	[RouteAttribute("{lang}/[controller]/[action]")]
	public class DefaultController : Controller
	{
		[HttpGet]
		public IActionResult Index()
		{
			return View();
		}
		
		[HttpPost]
		public IActionResult Index(DCDotNetMeetup.GreetingModel model)
		{
			return View("Greeted", model.Name);
		}
	}
}