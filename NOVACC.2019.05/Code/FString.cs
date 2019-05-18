using System;

namespace NovaCodeCamp2019
{
    class FString
    {
        public static string RandomString(ReadOnlySpan<char> set, int length)
        {
            Span<char> buffer = stackalloc char[length]; //Security bug for later!
            for (var i = 0; i < length; i++)
            {
                buffer[i] = set[FRandom.GetInt32(0, set.Length)];
            }
            return new string(buffer);
        }
    }
}