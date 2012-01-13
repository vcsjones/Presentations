using System;

namespace RockNUG.Models.Home.Index
{
    public class Release
    {
        public string Version { get; set; }
        public DateTime Date { get; set; }
        public TimeSpan FirstSession { get; set; }
        public TimeSpan LastSession { get; set; }
        public Session HeadLineSession { get; set; }
        public Session NextSession { get; set; }
        public Session[] AllSessions { get; set; }
    }

    public class Session
    {

        public TimeSpan Begin { get; set; }
        public TimeSpan End { get; set; }
        public string Title { get; set; }
        public int Type { get; set; }
        public Speaker Speaker { get; set; }
        public string Abstract { get; set; }
    }

    public class Speaker
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public int ID { get; set; }
    }
}