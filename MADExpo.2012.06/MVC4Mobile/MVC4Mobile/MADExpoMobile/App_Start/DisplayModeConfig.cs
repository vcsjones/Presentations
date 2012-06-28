using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.WebPages;

namespace MADExpoMobile
{
	public static class DisplayModeConfig
	{
		public static void RegisterModes(DisplayModeProvider provider)
		{
			provider.Modes.Insert(0,
			new DefaultDisplayMode("IE6")
			{
				ContextCondition = context =>
				context.GetOverriddenUserAgent()
				.IndexOf("MSIE 6",
			StringComparison.InvariantCultureIgnoreCase) > -1
			});
		}
	}
}