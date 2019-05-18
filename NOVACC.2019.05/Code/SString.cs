using System;

namespace NovaCodeCamp2019
{
    class SString
    {
        public static string RandomString(string set, int length)
        {
            var buffer = new char[length];
            for (var i = 0; i < length; i++)
            {
                buffer[i] = set[SRandom.GetInt32(0, set.Length)];
            }
            return new string(buffer);
        }
    }
}