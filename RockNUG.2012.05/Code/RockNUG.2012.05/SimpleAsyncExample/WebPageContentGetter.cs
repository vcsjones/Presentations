using System;
using System.Net;
using System.Threading.Tasks;

namespace SimpleAsyncExample
{
	public class WebPageContentGetter
	{
		public Task<string> GetURLContents(string url)
		{
			var source = new TaskCompletionSource<string>();
			Task.Factory.StartNew(o =>
			{
			    try
			    {
			        var client = new WebClient();
			        var contents = client.DownloadString((string) o);
			        source.TrySetResult(contents);
			    }
			    catch (Exception e)
			    {
			        source.TrySetException(e);
			    }
										
			}, url);
			return source.Task;
		}
	}
}
