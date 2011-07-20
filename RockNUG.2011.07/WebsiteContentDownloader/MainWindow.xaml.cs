using System;
using System.Collections.Concurrent;
using System.Diagnostics;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Cache;
using System.Text.RegularExpressions;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Collections.ObjectModel;

namespace WebsiteContentDownloader
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        protected static readonly DependencyProperty NumbersProperty;

        static MainWindow()
        {
            var metadata = new PropertyMetadata(new ObservableCollection<long>
                                                    {
                                                        3,
                                                        2,
                                                        17,
                                                        20,
                                                        63553547345645653,
                                                        34563456314523431,
                                                        989956756956978671,
                                                        989956756956978673,
                                                    });
            NumbersProperty = DependencyProperty.Register("Numbers", typeof(ObservableCollection<long>), typeof(MainWindow), metadata);
        }

        public MainWindow()
        {
            InitializeComponent();
        }

        public ObservableCollection<long> Numbers
        {
            get { return (ObservableCollection<long>) GetValue(NumbersProperty); }
            set {SetValue(NumbersProperty, value);}
        }

        private void CheckPrime(object sender, RoutedEventArgs e)
        {
            int primeCount = 0;
            var watch = Stopwatch.StartNew();
            Action<long> checkPrime = number =>
                                    {
                                        if (IsPrimeChecker.IsPrime(number))
                                            primeCount++;
                                    };
            var partitioner = new LoHiPartitioner<long>(Numbers);
            Parallel.ForEach(partitioner, new ParallelOptions{MaxDegreeOfParallelism = 4}, checkPrime);
            watch.Stop();
            ResultLabel.Content = watch.Elapsed;
            MessageBox.Show(primeCount.ToString());
        }

        private void AddClick(object sender, RoutedEventArgs e)
        {
            Numbers.Add(Int64.Parse(NumberToAdd.Text));
            NumberToAdd.Clear();
        }
    }
}
