using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AsyncMVC4.Models.Home
{
	public class NewsModel
	{
		public string FeedName { get; set; }
		public NewsItemModel[] Items { get; set; }
	}

	public class NewsItemModel
	{
		public string URL { get; set; }
		public string Title { get; set; }
		public string PublishDate { get; set; }
	}
}