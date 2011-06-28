using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Security.Cryptography;

namespace KeyIVSample
{
    class Program
    {
        static void Main(string[] args)
        {
            using (var aes = new AesManaged { KeySize = 256 })
            {
                aes.Key = new byte[] {8, 126, 128, 94, 217, 171, 13, 140, 41, 8, 27, 199, 88, 231, 120, 113, 43, 106, 254, 211, 118, 8, 241, 150, 81, 56, 226, 22, 159, 55, 56, 251};
                aes.IV = new byte[] { 2, 202, 91, 199, 11, 114, 153, 204, 70, 32, 101, 171, 221, 189, 233, 232 };
                var data = new byte[] { 228, 99, 142, 231, 172, 207, 213, 115, 226, 101, 148, 109, 3, 65, 31, 70 };
                using (var decryptor = aes.CreateDecryptor())
                {
                    var decryptedData = decryptor.TransformFinalBlock(data, 0, data.Length);
                    var plainText = Encoding.UTF8.GetString(decryptedData);
                    Console.WriteLine(plainText);
                }
            }
        }
    }
}
