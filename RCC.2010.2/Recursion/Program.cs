using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Recursion
{
    class Program
    {
        static void Main(string[] args)
        {
            Exception applicationException = GetException();
            Exception nullRef = WalkExceptionsForMyException_Linq(applicationException);
            Console.WriteLine(nullRef.Message);
        }

        private static Exception WalkExceptionsForMyException_ForLoop(Exception e)
        {
            for (Exception ex = e; ex != null; ex = ex.InnerException)
                if (ex is MyException)
                    return ex;
            return null;
        }

        private static Exception WalkExceptionsForMyException_Recursion(Exception e)
        {
            if (e == null)
                return null;
            if (e is MyException)
                return e;
            return WalkExceptionsForMyException_Recursion(e.InnerException);
        }

        private static Exception WalkExceptionsForMyException_Lambda(Exception e)
        {
            Func<Exception, Exception> f = null;
            f = ex => ex == null ? null : ex is MyException ? ex : f(ex.InnerException);
            return f(e);
        }

        private static Exception WalkExceptionsForMyException_Linq(Exception e)
        {
            return LazyWalkException(e).Where(ex => ex is MyException).FirstOrDefault();
        }

        private static IEnumerable<Exception> LazyWalkException(Exception e)
        {
            for (Exception ex = e; ex != null; ex = ex.InnerException)
            {
                //Console.WriteLine("Currently on: {0}", ex.Message);
                yield return ex;
            }
        }

        private static Exception GetException()
        {
            return new ApplicationException("Something bad happened",
                    new ApplicationException("Object didn't exist",
                        new ApplicationException("Couldn't find something",
                            new MyException("User didn't click button fast enough.",
                                new ApplicationException("Oops!")
                                )
                            )
                        )
                    );
        }

        private class MyException : Exception
        {
            public MyException(string message, Exception ex) : base(message, ex)
            {
            }
        }
    }
}
