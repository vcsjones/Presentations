using System.Web;

namespace LegacyExamples
{
    public class SpeakerImageHandler : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "image/jpeg";
            int speakerId;
            if (!int.TryParse(context.Request.QueryString["speakerId"], out speakerId))
            {
                context.Response.StatusCode = 404;
                context.Response.StatusDescription = "Not Found";
                context.Response.End();
            }
            var speakerImage = SpeakerDataProvider.GetSpeakerImage(speakerId);
            if (speakerImage == null)
            {
                context.Response.WriteFile(context.Server.MapPath("~/images/anon.jpg"));
            }
            else
            {
                using (var imageStream = ImageResizer.ResizeImage(speakerImage, 128))
                {
                    imageStream.CopyTo(context.Response.OutputStream);
                }
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}