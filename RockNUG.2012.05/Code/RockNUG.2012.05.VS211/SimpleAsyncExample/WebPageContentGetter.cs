using System;
using System.Net;
using System.Threading.Tasks;

namespace SimpleAsyncExample
{
	public class WebPageContentGetter
	{
		public Task<string> GetURLContents(string url)
		{
			var client = new WebClient();
			return client.DownloadStringTaskAsync(url);
		}
	}
}
