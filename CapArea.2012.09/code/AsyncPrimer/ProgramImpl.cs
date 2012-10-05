using System.Threading;
using System.Threading.Tasks;

namespace AsyncPrimer
{
    partial class Program
    {
        public static Task<int> GetNumberFromDatabase()
        {
            return Task.Factory.StartNew(() => { Thread.Sleep(3000); return 4; });
        }
    }
}
