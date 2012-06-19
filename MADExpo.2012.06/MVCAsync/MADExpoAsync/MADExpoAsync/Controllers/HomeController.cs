using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Threading.Tasks;

namespace MADExpoAsync.Controllers
{
    public class HomeController : Controller
    {
        public ActionResult Index()
        {
			return View();
        }

		[HttpGet]
		public async Task<ActionResult> GetSpeakers()
		{
			var speakerDataProvider = new SpeakerDataProvider();
			var speakers = await speakerDataProvider.GetSpeakers();
			return Json(new { Result = speakers }, JsonRequestBehavior.AllowGet);
		}

		[HttpGet]
		[OutputCache(Duration = 60)]
		public async Task<ActionResult> Image(int id)
		{
			return File("~/Content/images/anon.jpg", "image/jpeg", "anon.jpg");
		}
    }
}
