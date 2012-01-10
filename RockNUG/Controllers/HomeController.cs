using System;
using System.Linq;
using System.Web.Mvc;

namespace RockNUG.Controllers
{
    public class HomeController : Controller
    {
        private readonly RockNUGEntities _entities;

        public HomeController(RockNUGEntities entities)
        {
            _entities = entities;
        }

        public ActionResult Index()
        {
            var nextRelease = (from release in _entities.Releases.Include("Sessions").Include("Sessions.Speaker")
                              where release.Date >= DateTime.UtcNow
                                && release.Sessions.Count() > 0
                              orderby release.Date descending
                              select release).FirstOrDefault();
            return View(nextRelease);
        }

    }
}
