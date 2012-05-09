using System;
using System.Collections.Generic;
using System.Diagnostics.Contracts;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using System.Xml.Linq;
using AsyncMVC3.Models.Home;

namespace AsyncMVC3.Controllers
{
    public class HomeController : AsyncController
    {
        public void IndexAsync()
        {
			AsyncManager.OutstandingOperations.Increment();
        	var client = new WebClient();
        	client.DownloadStringCompleted += (s, e) =>
        	{
				AsyncManager.Parameters["contents"] = XDocument.Parse(e.Result);
        	    AsyncManager.OutstandingOperations.Decrement();
        	};
			client.DownloadStringAsync(new Uri("http://news.google.com/news?output=rss"));
        }

		public ActionResult IndexCompleted(XDocument contents)
		{
			Contract.Assume(contents.Root != null);
			var channel = contents.Root.Element("channel");

			var model = new NewsModel
			            	{
			            		FeedName = channel.Element("title").Value,
			            		Items = channel.Elements("item").Select(
			            			e => new NewsItemModel
			            			     	{
												Title = e.Element("title").Value,
												PublishDate = e.Element("pubDate").Value,
												URL = e.Element("link").Value
			            			     	}
			            			).ToArray()
			            	};
			return View(model);
		}
    }
}
