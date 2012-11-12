using System.Threading.Tasks;
using System.Web;

namespace AspNet45
{
    public class SpeakerImageHandler : HttpTaskAsyncHandler
    {
        public override async Task ProcessRequestAsync(HttpContext context)
        {
            context.Response.ContentType = "image/jpeg";
            int speakerId;
            if (!int.TryParse(context.Request.QueryString["speakerId"], out speakerId))
            {
                context.Response.StatusCode = 404;
                context.Response.StatusDescription = "Not Found";
                return;
            }
        

            var speakerImage = await SpeakerDataProvider.GetSpeakerImage(speakerId);
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

        public override bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}