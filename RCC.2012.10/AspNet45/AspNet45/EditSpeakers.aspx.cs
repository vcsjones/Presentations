using System.Collections.Generic;

namespace AspNet45
{
    public partial class EditSpeakers : System.Web.UI.Page
    {
        public IEnumerable<Speaker> GetSpeakers()
        {
            return SpeakerDataProvider.GetSpeakers();
        }

        public void UpdateSpeaker(Speaker speaker)
        {
            if (TryUpdateModel(speaker))
            {
                SpeakerDataProvider.UpdateSpeaker(speaker);
            }
        }
    }
}