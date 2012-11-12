using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.ModelBinding;
using System.Web.UI;

namespace AspNet45
{
    public partial class Speakers : Page
    {
        public List<Speaker> GetSpeakers([QueryString]string sort)
        {
            if (sort == "desc")
            {
                return SpeakerDataProvider.GetSpeakers().OrderByDescending(s => s.LastName).ToList();
            }
            else
            {
                return SpeakerDataProvider.GetSpeakers();
            }
        }
    }
}