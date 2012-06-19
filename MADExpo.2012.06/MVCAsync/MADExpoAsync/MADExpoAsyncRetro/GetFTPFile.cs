using System;
using System.Collections.Generic;
using System.Web;
using System.IO;

namespace MADExpoAsyncRetro
{
	public class GetFTPFile : IHttpAsyncHandler
	{
		private FileStream _fs;
		public IAsyncResult BeginProcessRequest(HttpContext context, AsyncCallback cb, object extraData)
		{
			string path = context.Request.QueryString["path"];
			_fs = new FileStream(path, FileMode.Open);
			return 
		}

		public void EndProcessRequest(IAsyncResult result)
		{
			_request.EndGetResponse(result);
		}

		public bool IsReusable
		{
			get { return false; }
		}

		public void ProcessRequest(HttpContext context)
		{
			throw new NotImplementedException();
			//This never really gets called. We need
			//To satisfy the interface thoug
		}
	}
}