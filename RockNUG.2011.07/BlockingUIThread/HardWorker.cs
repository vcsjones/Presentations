using System.Threading;

namespace BlockingUIThread
{
    public class HardWorker
    {
        public string HardWork()
        {
            Thread.Sleep(5000);
            return "Hard Work Complete!";
        }
    }
}
