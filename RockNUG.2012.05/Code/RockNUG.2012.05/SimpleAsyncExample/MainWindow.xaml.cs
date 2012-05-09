
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

		private void Window_Loaded(object sender, RoutedEventArgs e)
		{
			_watch.Start();
			var context = TaskScheduler.FromCurrentSynchronizationContext();
			new WebPageContentGetter().GetURLContents("http://rocknug.org")
				.ContinueWith(t =>
				              	{
									_watch.Stop();
				              		SizeTextBlock.Text = "Size: " + t.Result.Length;
				              	}, context);
		}
	}
}
