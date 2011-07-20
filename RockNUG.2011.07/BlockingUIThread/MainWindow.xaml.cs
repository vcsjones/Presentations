using System;
using System.Threading;
using System.Windows;

namespace BlockingUIThread
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        public MainWindow()
        {
            InitializeComponent();
        }

        private void DoStuffClick(object sender, RoutedEventArgs e)
        {
            ResultLabel.Content = null;
            MyProgressBar.Visibility = Visibility.Visible;
            Thread thread = new Thread(DoHardWorkAndSetLabel);
            thread.Start();
        }

        private void DoHardWorkAndSetLabel()
        {
            var result = new HardWorker().HardWork();
            Action<string> s = r => ResultLabel.Content = r;
            Action setVisibility = () => MyProgressBar.Visibility = Visibility.Hidden;
            Dispatcher.Invoke(s, result);
            Dispatcher.Invoke(setVisibility);
        }
    }
}
