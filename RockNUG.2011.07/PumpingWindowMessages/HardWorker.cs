using System;
using System.Threading;

namespace PumpingWindowMessages
{
    public class HardWorker
    {
        public string HardWork()
        {
            Thread.Sleep(1000);
            return "Hard Work Complete!";
        }
    }
}
