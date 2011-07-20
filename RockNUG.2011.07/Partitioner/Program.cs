using System;
using System.Collections;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Partitioner
{
    class Program
    {
        static void Main(string[] args)
        {
            var numbers = new[] {1, 2, 3, 4, 5, 6, 7, 8, 9};
            var partitioner = new LoHiPartitioner<int>(numbers);
            var options = new ParallelOptions
                              {
                                  MaxDegreeOfParallelism = 1
                              };
            Parallel.ForEach(partitioner, options, Console.WriteLine);
        }
    }

    public class LoHiPartitioner<T> : Partitioner<T> where T : IComparable<T>
    {
        private readonly IEnumerable<T> _data;

        public LoHiPartitioner(IEnumerable<T> data)
        {
            _data = data;
        }

        public override IList<IEnumerator<T>> GetPartitions(int partitionCount)
        {
            throw new NotImplementedException();
        }

        public override bool SupportsDynamicPartitions
        {
            get { return true; }
        }

        public override IEnumerable<T> GetDynamicPartitions()
        {
            return new InternalEnumerable(_data.OrderBy(s => s));
        }

        private class InternalEnumerable : IEnumerable<T>
        {
            private readonly IEnumerable<T> _owner;

            public InternalEnumerable(IEnumerable<T> owner)
            {
                Offset = -1;
                BackwardOffset = -1;
                _owner = owner;
            }

            public IEnumerator<T> GetEnumerator()
            {
                return new InternalEnumerator(this, _owner);
            }

            IEnumerator IEnumerable.GetEnumerator()
            {
                return GetEnumerator();
            }

            private int Offset { get; set; }
            private int BackwardOffset { get; set; }
            private bool Backward { get; set; }

            private class InternalEnumerator : IEnumerator<T>
            {
                private readonly InternalEnumerable _internalEnumerable;
                private readonly IEnumerable<T> _dataSource;

                public InternalEnumerator(InternalEnumerable internalEnumerable, IEnumerable<T> dataSource)
                {
                    _internalEnumerable = internalEnumerable;
                    _dataSource = dataSource;
                }

                public void Dispose()
                {
                }

                public bool MoveNext()
                {
                    lock (_internalEnumerable)
                    {
                        int count = _internalEnumerable._owner.Count();
                        if (_internalEnumerable.BackwardOffset + _internalEnumerable.Offset == count - 2)
                        {
                            return false;
                        }
                        if (!_internalEnumerable.Backward)
                        {
                            Current = _dataSource.ElementAt(_internalEnumerable.Offset = _internalEnumerable.Offset + 1);
                        }
                        else
                        {
                            Current = _dataSource.ElementAt(count - 1 - (_internalEnumerable.BackwardOffset = _internalEnumerable.BackwardOffset + 1));
                        }
                        _internalEnumerable.Backward = !_internalEnumerable.Backward;
                        return true;
                    }
                }

                public void Reset()
                {
                    throw new NotSupportedException();
                }

                public T Current { get; private set; }

                object IEnumerator.Current
                {
                    get { return Current; }
                }
            }
        }
    }
}
