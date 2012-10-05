using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace MyWPFProject
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

        private async void Button_Click_1(object sender, RoutedEventArgs e)
        {
            MyLabel.Content = "WORKING!";
            MyButton.IsEnabled = false;
            await TalkToDatabase();
            MyButton.IsEnabled = true;
            MyLabel.Content = "DONE WORKING!";
        }

        private Task TalkToDatabase()
        {
            return Task.Factory.StartNew(() => Thread.Sleep(4000));
        }
    }
}
