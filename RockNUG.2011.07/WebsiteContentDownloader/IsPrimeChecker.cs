using System;
using System.Collections.Generic;
using System.Diagnostics;
using System.Linq;
using System.Threading;

namespace WebsiteContentDownloader
{
    public class IsPrimeChecker
    {
        public static bool IsPrime(long n)
        {
            return !Range(2, n)
                    .Any(y => n != y && n%y == 0L);
        }

        private static IEnumerable<long> Range(long fromInclusive, long toInclusive)
        {
            for(var l = fromInclusive; l <= toInclusive; l++)
            {
                yield return l;
            }
        }
    }
}
