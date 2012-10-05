using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Threading.Tasks;

namespace AsyncMVC3.Controllers
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

		public void GetSpeakersAsync()
		{
			var speakerDataProvider = new SpeakerDataProvider();
			AsyncManager.OutstandingOperations.Increment();
			speakerDataProvider.GetSpeakers().ContinueWith(d =>
			{
				AsyncManager.Parameters["speakers"] = d.Result;
				AsyncManager.OutstandingOperations.Decrement();
			});
		}

		public ActionResult GetSpeakersCompleted(List<Speaker> speakers)
		{
			return Json(new { Result = speakers }, JsonRequestBehavior.AllowGet);
		}

		public void GetSpeakerAsync(int id)
		{
			var speakerDataProvider = new SpeakerDataProvider();
			AsyncManager.OutstandingOperations.Increment(2);
		    speakerDataProvider.GetSpeaker(id).ContinueWith(d =>
		        {
		            AsyncManager.Parameters["speaker"] = d.Result;
		            AsyncManager.OutstandingOperations.Decrement();
		        }).ContinueWith(r =>
		                            {
                                        speakerDataProvider.GetSpeakerSessions(id).ContinueWith(d =>
                                        {
                                            AsyncManager.Parameters["sessions"] = d.Result;
                                            AsyncManager.OutstandingOperations.Decrement();
                                        });
		                            });

		}

		public ActionResult GetSpeakerCompleted(Speaker speaker, List<Session> sessions)
		{
			return Json(new { Sessions = sessions, Speaker = speaker }, JsonRequestBehavior.AllowGet);
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
