using System.Linq;
using System.Security.Claims;
using System.Web.Mvc;
using WebMatrix.WebData;
using SamlWebApplication.Filters;

namespace SamlWebApplication.Controllers
{
    [Authorize]
    [InitializeSimpleMembership]
    public class AccountController : Controller
    {
        //
        // GET: /Account/Login

        [AllowAnonymous]
        public ActionResult Login(string returnUrl)
        {
            //URL generated from Azure Portal.
            return Redirect("Put in AZURE URL HERE");
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult LogOff()
        {
            WebSecurity.Logout();

            return RedirectToAction("Index", "Home");
        }

        [Authorize]
        public ActionResult Manage()
        {
            var context = HttpContext.User.Identity as ClaimsIdentity;
            if (context != null)
            {
                var type = "http://schemas.xmlsoap.org/ws/2005/05/identity/claims/nameidentifier";
                ViewBag.NameIdentifier = context.Claims.Single(c => c.Type == type).Value;
            }
            else
            {
                ViewBag.NameIdentifier = "Unknown";
            }
            return View();
        }
    }

}
