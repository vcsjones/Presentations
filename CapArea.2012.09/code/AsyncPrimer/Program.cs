using System;
using System.Linq;
using System.Threading.Tasks;

namespace AsyncPrimer
{
    partial class Program
    {
        static void Main()
        {
            var results = Task.WhenAll(GetNumberAndProcess(), GetNumberAndProcess()).Result;
            foreach (var result in results)
            {
                Console.WriteLine("Result: {0}", result);
            }
        }

        public static async Task<int> GetNumberAndProcess()
        {
            Console.WriteLine("Getting number from database.");
            var number = await GetNumberFromDatabase();
            Console.WriteLine("Got number from database, now processing.");
            return number + 6;
        }



        public static Task<int> GetNumberAndProcess2()
        {
            Console.WriteLine("Getting number from database.");
            return GetNumberFromDatabase().ContinueWith(r =>
            {
                Console.WriteLine("Got number from database, now processing.");
                return r.Result + 6;
            });
        }
    }
}
