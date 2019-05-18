using System;
using System.IO;
using BenchmarkDotNet.Attributes;

namespace NovaCodeCamp2019
{
    [MemoryDiagnoser]
    public class StringBench
    {
        string _charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";

        [Params(16, 1024)]
        public int Length { get; set; }


        [Benchmark]
        public void FStringBench()
        {
            FString.RandomString(_charset, Length);
        }

        [Benchmark(Baseline = true)]
        public void SStringBench()
        {
            SString.RandomString(_charset, Length);
        }
    }
}
