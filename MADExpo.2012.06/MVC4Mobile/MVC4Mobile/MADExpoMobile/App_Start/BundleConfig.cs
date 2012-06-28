﻿using System.Web;
using System.Web.Optimization;

namespace MADExpoMobile
{
	public class BundleConfig
	{
		public static void RegisterBundles(BundleCollection bundles)
		{
			bundles.Add(new ScriptBundle("~/bundles/jquery").Include(
						"~/Scripts/jquery-1.*"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryui").Include(
						"~/Scripts/jquery-ui*"));

			bundles.Add(new ScriptBundle("~/bundles/jquerymobile").Include(
						"~/Scripts/jquery.mobile*"));

			bundles.Add(new ScriptBundle("~/bundles/jqueryval").Include(
						"~/Scripts/jquery.unobtrusive*",
						"~/Scripts/jquery.validate*"));

			bundles.Add(new ScriptBundle("~/bundles/bindingHandlers").Include(
						"~/Scripts/Knockout.BindingHandlers.js"));

			bundles.Add(new ScriptBundle("~/bundles/knockout").Include(
						"~/Scripts/knockout-2*"));

			bundles.Add(new ScriptBundle("~/bundles/modernizr").Include(
						"~/Scripts/modernizr-*"));

			bundles.Add(new ScriptBundle("~/bundles/dotdotdot").Include(
						"~/Scripts/jquery.dotdotdot-*"));

			bundles.Add(new StyleBundle("~/Content/css").Include("~/Content/site.css"));
			bundles.Add(new StyleBundle("~/Content/css/mobile").Include("~/Content/site.mobile.css"));
			bundles.Add(new StyleBundle("~/Content/css/jquerymobile").Include("~/Content/jquery.mobile*"));

			bundles.Add(new StyleBundle("~/Content/themes/base/css").Include(
						"~/Content/themes/base/jquery.ui.core.css",
						"~/Content/themes/base/jquery.ui.resizable.css",
						"~/Content/themes/base/jquery.ui.selectable.css",
						"~/Content/themes/base/jquery.ui.accordion.css",
						"~/Content/themes/base/jquery.ui.autocomplete.css",
						"~/Content/themes/base/jquery.ui.button.css",
						"~/Content/themes/base/jquery.ui.dialog.css",
						"~/Content/themes/base/jquery.ui.slider.css",
						"~/Content/themes/base/jquery.ui.tabs.css",
						"~/Content/themes/base/jquery.ui.datepicker.css",
						"~/Content/themes/base/jquery.ui.progressbar.css",
						"~/Content/themes/base/jquery.ui.theme.css"));
		}
	}
}