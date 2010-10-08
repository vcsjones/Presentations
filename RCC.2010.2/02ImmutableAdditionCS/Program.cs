using System;
using System.Collections.Generic;
using System.Linq;

namespace _02ImmutableAdditionCS
{
    class Program
    {
        /// <summary>
        /// Let's pretend LINQ's Sum / Aggregate operation doesn't exist.
        /// </summary>
        static void Main(string[] args)
        {
            var numbers = Enumerable.Range(1, 10);
            var sum = AddNumberMutablePattern(numbers);
            Console.Out.WriteLine("sum = {0}", sum);
        }

        static int AddNumbersImmutablePattern(IEnumerable<int> numbers)
        {
            if (numbers.Count() == 0) return 0;
            return numbers.First() + AddNumbersImmutablePattern(numbers.Skip(1));
        }

        static int AddNumberMutablePattern(IEnumerable<int> numbers)
        {
            var sum = 0;
            foreach (var number in numbers)
            {
                sum += number;
            }
            return sum;
        }
    }
}
