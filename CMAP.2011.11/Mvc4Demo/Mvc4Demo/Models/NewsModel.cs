using System.Collections.Generic;

namespace Mvc4Demo.Models
{
    public class NewsModel
    {
        public List<NewsItem> YahooNews { get; set; }
        public List<NewsItem> GoogleNews { get; set; }
    }

    public class NewsItem
    {
        public string Title { get; set; }
        public string Link { get; set; }
    }
}