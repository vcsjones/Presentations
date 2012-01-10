using System;
using System.Web.Mvc;

namespace RockNUG
{
    public static class HtmlHelpers
    {
        public static MvcHtmlString FormatTimeSpan(this TimeSpan timeSpan)
        {
            return new MvcHtmlString((DateTime.MinValue + timeSpan).ToString("hh:mm tt"));
        }
    }
}