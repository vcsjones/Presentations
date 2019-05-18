using System;
using System.Buffers.Binary;
using System.Security.Cryptography;

namespace NovaCodeCamp2019
{
    static class SRandom
    {
        public static int GetInt32(int fromInclusive, int toExclusive)
        {
            // The total possible range is [0, 4,294,967,295).
            // Subtract one to account for zero being an actual possibility.
            uint range = (uint)toExclusive - (uint)fromInclusive - 1;

            // If there is only one possible choice, nothing random will actually happen, so return
            // the only possibility.
            if (range == 0)
            {
                return fromInclusive;
            }

            // Create a mask for the bits that we care about for the range. The other bits will be
            // masked away.
            uint mask = range;
            mask |= mask >> 1;
            mask |= mask >> 2;
            mask |= mask >> 4;
            mask |= mask >> 8;
            mask |= mask >> 16;

            var buffer = new byte[sizeof(uint)];
            uint result;
            using (var rng = RandomNumberGenerator.Create())
            do
            {
                rng.GetBytes(buffer);
                result = mask & BitConverter.ToUInt32(buffer, 0);
            }
            while (result > range);

            return (int)result + fromInclusive;
        }
    }
}