using System;

namespace _01Mutability
{
    class Program
    {
        static void Main()
        {
            var iAmAMutableLocal = 3;
            iAmAMutableLocal = 7;
            Console.Out.WriteLine(iAmAMutableLocal);
        }
    }
}
