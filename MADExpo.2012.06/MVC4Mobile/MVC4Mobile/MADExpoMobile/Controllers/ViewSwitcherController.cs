using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.WebPages;

namespace MADExpoMobile.Controllers
{
	public class ViewSwitcherController : Controller
	{
		public RedirectResult SwitchView(bool mobile, string returnUrl)
		{
			if (Request.Browser.IsMobileDevice == mobile)
				HttpContext.ClearOverriddenBrowser();
			else
				HttpContext.SetOverriddenBrowser(mobile ? BrowserOverride.Mobile : BrowserOverride.Desktop);

			return Redirect(returnUrl);
		}
	}
}
