﻿using System;
using System.Diagnostics;
using System.Threading;
using System.Windows.Threading;

namespace SimpleAsyncExample
{
	partial class MainWindow
	{
		private Timer _timer;
		private Stopwatch _watch;

		partial void PreInitializeComponent()
		{
			Loaded += MainWindow_Loaded;
			Unloaded += MainWindow_Unloaded;
		}

		void MainWindow_Unloaded(object sender, System.Windows.RoutedEventArgs e)
		{
			_timer.Dispose();
		}

		void MainWindow_Loaded(object sender, System.Windows.RoutedEventArgs e)
		{
			_watch = new Stopwatch();
			_timer = new Timer(o =>
			{
				var w = (Stopwatch)o;
				Action set = () => StopWatchTextBlock.Text = w.Elapsed.ToString();
				Dispatcher.Invoke(set, DispatcherPriority.Normal);
			}, _watch, 0, 20);
		}
	}
}
