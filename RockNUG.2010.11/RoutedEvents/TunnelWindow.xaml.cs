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
using System.Windows.Shapes;

namespace RoutedEvents
{
    /// <summary>
    /// Interaction logic for TunnelWindow.xaml
    /// </summary>
    public partial class TunnelWindow : Window
    {

        public TunnelWindow()
        {
            InitializeComponent();
        }

        private void Grid_PreviewKeyUp(object sender, KeyEventArgs e)
        {
            MessageBox.Show("The Grid was given a Preview Key Up!");
            e.Handled = true;
        }

        private void TextBox_KeyUp(object sender, KeyEventArgs e)
        {
            MessageBox.Show("The TextBox was given a Preview Key Up!");
        }
    }
}
