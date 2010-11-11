using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;

namespace RoutedEvents
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

        private void TextBox_KeyUp(object sender, KeyEventArgs e)
        {
            MessageBox.Show("The Text Box received a key up!");
        }

        private void Grid_KeyUp(object sender, KeyEventArgs e)
        {
            MessageBox.Show("The Grid received a key up!");
            e.Handled = true;
        }
    }
}
