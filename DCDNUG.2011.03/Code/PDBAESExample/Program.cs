using System;
using System.Xml.Linq;
using System.Security.Cryptography;
using System.IO;
using System.Windows.Forms;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace PDBAESExample
{
    class Program
    {
        static void Main(string[] args)
        {
            Console.Write("Enter a password: ");
            var password = Console.ReadLine();
            using (var pdb = new Rfc2898DeriveBytes(password, new byte[] {1,2,3,4,5,6,7,8,9}))
            {
                Func<StringBuilder, byte, StringBuilder> bytesToStrign = (s, b) => s.AppendFormat("{0:X2} ", b);
                var salt = pdb.Salt.Aggregate(new StringBuilder(), bytesToStrign).ToString();
                var key = pdb.GetBytes(256 / 8).Aggregate(new StringBuilder(), bytesToStrign).ToString();
                Console.WriteLine("Random salt: {0}", salt);
                Console.WriteLine("Key: {0}", key);
            }
        }
    }
}