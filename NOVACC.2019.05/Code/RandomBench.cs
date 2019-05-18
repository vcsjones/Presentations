using BenchmarkDotNet.Attributes;

namespace NovaCodeCamp2019
{
    [MemoryDiagnoser]
    public class RandomBench
    {
        [Params(4095, 4096, 4097)]
        public int UpperBound { get; set; }


        [Benchmark]
        public void FRandomBench()
        {
            FRandom.GetInt32(0, UpperBound);
        }

        [Benchmark(Baseline = true)]
        public void SRandomBench()
        {
            SRandom.GetInt32(0, UpperBound);
        }
    }
}
