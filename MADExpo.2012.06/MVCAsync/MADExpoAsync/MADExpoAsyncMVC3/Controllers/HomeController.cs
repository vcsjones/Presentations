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
    public class HomeController : AsyncController
    {
        public ActionResult Index()
        {
			return View();
        }

		public ActionResult Speaker(int id)
		{
			return View(id);
		}

		public Task<ActionResult> GetSpeaker(int id)
		{
			return null; /*
			var speakerDataProvider = new SpeakerDataProvider();
			var speaker = speakerDataProvider.GetSpeaker(id);
			var sessions = speakerDataProvider.GetSpeakerSessions(id);
			return Json(new { Sessions = await sessions, Speaker = await speaker }, JsonRequestBehavior.AllowGet);*/
		}

		[HttpGet]
		public Task<ActionResult> GetSpeakers()
		{
			return null; /*
			var speakerDataProvider = new SpeakerDataProvider();
			var speakers = await speakerDataProvider.GetSpeakers();
			return Json(new { Result = speakers }, JsonRequestBehavior.AllowGet);*/
		}

		public void ImageAsync(int id, int size = 128)
		{
			AsyncManager.OutstandingOperations.Increment();
			var speakerDataProvider = new SpeakerDataProvider();
			speakerDataProvider.GetSpeakerImage(id).ContinueWith(d =>
			{
				AsyncManager.Parameters["image"] = d.Result;
				AsyncManager.Parameters["size"] = size;
				AsyncManager.Parameters["id"] = id;
				AsyncManager.OutstandingOperations.Decrement();
			});
		}

		public ActionResult ImageCompleted(byte[] image, int size, int id)
		{
			if (image == null)
			{
				return File("~/Content/images/anon.jpg", "image/jpeg", "anon.jpg");
			}
			var resizedImage = ImageResizer.ResizeImage(image, size);
			return File(resizedImage, "image/png", id + ".png");
		}
    }
}
