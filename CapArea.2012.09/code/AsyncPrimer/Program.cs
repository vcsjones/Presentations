using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace AsyncPrimer
{
    class Program
    {
        static void Main()
        {
            var result1 = Task.Run(() => Foo());
            Console.WriteLine("1");
            var result2 = Task.Run(() => Foo());
            Console.WriteLine("2");
            Task.WaitAll(result1, result2);
        }

        public static async Task Foo()
        {
            int number = await GetNumber();
            Console.WriteLine(number + 6);
        }

        public static async Task<int> GetNumber()
        {
            Thread.Sleep(3000);
            return 4;
        }
    }
}
