using System;
using System.Linq;
using System.Web.Mvc;
using MRelease = RockNUG.Models.Home.Index.Release;
using MSession = RockNUG.Models.Home.Index.Session;
using MSpeaker = RockNUG.Models.Home.Index.Speaker;

namespace RockNUG.Controllers
{
    public class HomeController : Controller
    {
        private readonly RockNUGEntities _entities;

        public HomeController(RockNUGEntities entities)
        {
            _entities = entities;
        }

        [HttpGet]
        public ActionResult Index()
        {
            var date = DateTime.UtcNow.Date.AddDays(-1);
            var currentRelease = (from release in _entities.Releases.Include("Sessions").Include("Sessions.Speaker")
                              where release.Sessions.Count() > 0 && release.Date >= date
                              orderby release.Date ascending
                              select release).FirstOrDefault();
			if (currentRelease == null)
			{
				return View();
			}
            var nextRelease =  (from release in _entities.Releases.Include("Sessions").Include("Sessions.Speaker")
                              where release.Sessions.Any(s => s.Type == 2) && release.Date > currentRelease.Date
                              orderby release.Date ascending
                              select release).FirstOrDefault();
            return View(
                new MRelease
                            {
                                AllSessions = currentRelease.Sessions.Select(ModelSessionFromDTO).ToArray(),
                                Date = currentRelease.Date,
                                FirstSession = currentRelease.Sessions.OrderBy(s => s.Begin).First().Begin,
                                LastSession = currentRelease.Sessions.OrderByDescending(s => s.End).First().End,
                                HeadLineSession = ModelSessionFromDTO(currentRelease.Sessions.First(s => s.Type == 2)),
                                Version = currentRelease.Version,
                                NextSession = nextRelease == null ? null : ModelSessionFromDTO(nextRelease.Sessions.First())
                            });
        }

        public MSpeaker ModelSpeakerFromDTO(Speaker s)
        {
            return new MSpeaker { FirstName = s.FirstName, LastName = s.LastName, ID = s.ID };
        }

        public MSession ModelSessionFromDTO(Session s)
        {
            return new MSession
                       {
                           End = s.End,
                           Begin = s.Begin,
                           Speaker = ModelSpeakerFromDTO(s.Speaker),
                           Title = s.Title,
                           Type = s.Type,
                           Abstract = s.Abstract
                       };
        }

        [HttpGet]
        public ActionResult Mugshot(int id)
        {
            var speaker = _entities.Speakers.First(s => s.ID == id);
            if (speaker.Mugshot == null)
            {
                return File("~/Content/images/anon.png", "image/png");
            }
            return File(speaker.Mugshot, "image/png");
        }
    }
}
