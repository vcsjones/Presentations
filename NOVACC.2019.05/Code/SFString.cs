using System;

namespace NovaCodeCamp2019
{
    class SFString
    {
        public static void RandomString(ReadOnlySpan<char> set, Span<char> buffer)
        {
            for (var i = 0; i < buffer.Length; i++)
            {
                buffer[i] = set[FRandom.GetInt32(0, set.Length)];
            }
        }
    }
}