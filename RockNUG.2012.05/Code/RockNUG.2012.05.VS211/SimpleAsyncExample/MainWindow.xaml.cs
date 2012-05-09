
using System.Threading.Tasks;
using System.Windows;

namespace SimpleAsyncExample
{
	public partial class MainWindow
	{
		partial void PreInitializeComponent();

		public MainWindow()
		{
			PreInitializeComponent();
			InitializeComponent();
		}

		private async void Window_Loaded(object sender, RoutedEventArgs e)
		{
			_watch.Start();
			var getter = new WebPageContentGetter();
			var result = await getter.GetURLContents("http://rocknug.org");
			_watch.Stop();
			_timer.Dispose();
			SizeTextBlock.Text = "Size: " + result.Length;
		}
	}
}
