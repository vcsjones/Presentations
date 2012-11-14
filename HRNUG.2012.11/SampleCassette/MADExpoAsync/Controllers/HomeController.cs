﻿using System;
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

		public ActionResult Speaker(int id)
		{
			return View(id);
		}

		public async Task<ActionResult> GetSpeaker(int id)
		{
			var speakerDataProvider = new SpeakerDataProvider();
			var speaker = speakerDataProvider.GetSpeaker(id);
			var sessions = speakerDataProvider.GetSpeakerSessions(id);
			return Json(new { Sessions = await sessions, Speaker = await speaker }, JsonRequestBehavior.AllowGet);
		}

		[HttpGet]
		public async Task<ActionResult> GetSpeakers()
		{
			var speakerDataProvider = new SpeakerDataProvider();
			var speakers = await speakerDataProvider.GetSpeakers();
			return Json(new { Result = speakers }, JsonRequestBehavior.AllowGet);
		}

		[HttpGet]
		[OutputCache(Duration = 10 * 60)]
		public async Task<ActionResult> Image(int id, int size = 128)
		{
			var speakerDataProvider = new SpeakerDataProvider();
			var image = await speakerDataProvider.GetSpeakerImage(id);
			if (image == null)
			{
				return File("~/Content/images/anon.jpg", "image/jpeg", "anon.jpg");
			}
			var resizedImage = ImageResizer.ResizeImage(image, size);
			return File(resizedImage, "image/png", id + ".png");
		}
    }
}
