using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Threading.Tasks;
using System.Web.Mvc;
using System.Xml.Linq;
using Mvc4Demo.Models;

namespace Mvc4Demo.Controllers
{
    public class DefaultController : AsyncController
    {
        public async Task<ActionResult> Index()
        {
            var model = new NewsModel();
            model.GoogleNews = await GetGoogleHeadlines();
            model.YahooNews = await GetYahooHeadlines();
            return View(model);
        }

        public async Task<List<NewsItem>> GetYahooHeadlines()
        {
            var client = new WebClient();
            var rss = await client.DownloadStringTaskAsync("http://news.yahoo.com/rss/");
            var document = XDocument.Parse(rss);
            var names = from item in
                            document.Root.Element("channel").Elements("item")
                        select new NewsItem
                            {
                                Title = item.Element("title").Value,
                                Link = item.Element("link").Value
                            };
            return names.ToList();
        }

        public async Task<List<NewsItem>> GetGoogleHeadlines()
        {
            var client = new WebClient();
            var rss = await client.DownloadStringTaskAsync("http://news.google.com/news?ned=us&topic=h&output=rss");
            var document = XDocument.Parse(rss);
            var names = from item in
                            document.Root.Element("channel").Elements("item")
                        select new NewsItem
                        {
                            Title = item.Element("title").Value,
                            Link = item.Element("link").Value
                        };
            return names.ToList();
        }
    }
}
