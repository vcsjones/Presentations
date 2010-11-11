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

namespace Dependencies
{
    /// <summary>
    /// Interaction logic for MainWindow.xaml
    /// </summary>
    public partial class MainWindow : Window
    {
        private static readonly DependencyProperty SomeTextProperty = DependencyProperty.Register("SomeText", typeof(string), typeof(MainWindow));

        public MainWindow()
        {
            InitializeComponent();
        }

        public string SomeText
        {
            get
            {
                return (string)GetValue(SomeTextProperty);
            }
            set
            {
                SetValue(SomeTextProperty, value);
            }
        }

        private void Button_Click(object sender, RoutedEventArgs e)
        {
            SomeText += "A";
        }
    }
}
