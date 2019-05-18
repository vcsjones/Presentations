using System;
using System.IO;
using System.Text;
using BenchmarkDotNet.Attributes;

namespace NovaCodeCamp2019
{
    [MemoryDiagnoser]
    public class FileBench
    {
        string _charset = "0123456789abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ";
        string path;
        FileStream stream;
        StreamWriter writer;

        [GlobalSetup]
        public void Setup()
        {
            path = Path.GetTempFileName();
            stream = new FileStream(path, FileMode.Create, FileAccess.ReadWrite);
            writer = new StreamWriter(stream);
        }

        [GlobalCleanup]
        public void Cleanup()
        {
            writer.Dispose();
            stream.Dispose();
            File.Delete(path);
        }

        [Params(1024, 1026)]
        public int Length { get; set; }

        [Benchmark(Baseline = true)]
        public void SStringFileBench()
        {
            var result = SString.RandomString(_charset, Length);
            writer.WriteLine(result.Substring(0, Length / 2));
        }

        [Benchmark]
        public void SFStringFileBench()
        {
            Span<char> buffer = Length > 1024 ? new byte[Length] : stackalloc char[Length];
            SFString.RandomString(_charset, buffer);
            writer.WriteLine(buffer.Slice(0, Length / 2));
        }
    }
}
