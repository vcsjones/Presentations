using System.Windows;
using System.Windows.Input;

namespace BadEncodingProblem
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

        private void StackPanel_KeyUp(object sender, KeyEventArgs e)
        {
            PasswordMatch.Text = HexText1.Text == HexText2.Text ? "Yes" : "No";
        }
    }
}
