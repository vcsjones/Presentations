using System;
using System.Security.Cryptography;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SimpleAES
{
    class Program
    {
        static void Main(string[] args)
        {
            //RijndaelManaged
            //AesCryptoServiceProvider
            //AesManaged
            Console.Write("Type some text: ");
            var text = Console.ReadLine();
            var textBytes = Encoding.UTF8.GetBytes(text);
            using (var aesManaged = new AesManaged())
            {
                aesManaged.KeySize = 128;
                using (var encryptor = aesManaged.CreateEncryptor())
                {
                    var encryptedData = encryptor.TransformFinalBlock(textBytes, 0, textBytes.Length);
                    string base64 = Convert.ToBase64String(encryptedData);
                    Console.WriteLine("Encrypted Data:");
                    Console.WriteLine(base64);
                }
            }
            Console.ReadKey(true);
        }
    }
}
