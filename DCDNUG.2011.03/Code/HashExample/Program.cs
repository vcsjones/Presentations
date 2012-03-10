using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;

namespace HashExample
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Give some text: ");
            var text = Console.ReadLine();
            using (var sha1 = new SHA1Managed())
            {
                var bytes = Encoding.UTF8.GetBytes(text);
                var hash = sha1.ComputeHash(bytes);
                var hashString = hash.Aggregate(new StringBuilder(), (s, b) => s.AppendFormat("{0}, ", b)).ToString();
                Console.WriteLine(hashString.Substring(0, hashString.Length - 2));
            }
        }
    }
}
