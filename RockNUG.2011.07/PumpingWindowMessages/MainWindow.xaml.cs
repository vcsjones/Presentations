using System.Windows;

namespace PumpingWindowMessages
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private int _workCount = 0;

        public MainWindow()
        {
            InitializeComponent();
        }

        private void DoStuffClick(object sender, RoutedEventArgs e)
        {
            ResultLabel.Content = null;
            new HardWorker().HardWork();
            ResultLabel.Content = "I've Worked " + _workCount++ + " times(s).";
        }
    }
}
