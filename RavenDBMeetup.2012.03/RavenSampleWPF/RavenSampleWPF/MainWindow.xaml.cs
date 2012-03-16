using System;
using System.Collections.Generic;
using System.Collections.ObjectModel;
using System.Linq;
using System.Text;
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
using Raven.Client.Document;

namespace RavenSampleWPF
{
    public static class Commands
    {
        public static readonly RoutedUICommand Remove = new RoutedUICommand("Remove", "Remove", typeof(Commands));
    }
    public partial class MainWindow : Window
    {
        internal static readonly DependencyProperty ItemsProperty = DependencyProperty.Register("Items", typeof(ObservableCollection<ToDoItem>), typeof(MainWindow), new PropertyMetadata { DefaultValue = new ObservableCollection<ToDoItem>() });


        public ObservableCollection<ToDoItem> Items
        {
            get
            {
                return (ObservableCollection<ToDoItem>)GetValue(ItemsProperty);
            }
            set
            {
                SetValue(ItemsProperty, value);
            }
        }

        public MainWindow()
        {
            InitializeComponent();
        }

        private async void AddButton_Click(object sender, RoutedEventArgs e)
        {
            AddButton.IsEnabled = false;
            ItemDescriptionTextBox.IsEnabled = false;
            using (var documentStore = new DocumentStore())
            {
                documentStore.Url = "http://localhost:8080";
                documentStore.Initialize();
                using (var session = documentStore.OpenAsyncSession())
                {
                    var toDoItem = new ToDoItem { Description = ItemDescriptionTextBox.Text };
                    session.Store(toDoItem);
                    await session.SaveChangesAsync();
                    AddButton.IsEnabled = true;
                    ItemDescriptionTextBox.IsEnabled = true;
                    ItemDescriptionTextBox.Clear();
                    Items.Add(toDoItem);
                }
            }
        }

        private void Window_Loaded(object sender, RoutedEventArgs e)
        {
            AddButton.IsEnabled = false;
            ItemDescriptionTextBox.IsEnabled = false;
            using (var documentStore = new DocumentStore())
            {
                documentStore.Url = "http://localhost:8080";
                documentStore.Initialize();

                using (var session = documentStore.OpenSession())
                {
                    foreach (var item in session.Query<ToDoItem>())
                    {
                        Items.Add(item);
                    }
                }
            }
            AddButton.IsEnabled = true;
            ItemDescriptionTextBox.IsEnabled = true;
        }

        private void AlwaysExecute(object sender, CanExecuteRoutedEventArgs e)
        {
            e.CanExecute = true;
        }

        private async void RemoveCommand(object sender, ExecutedRoutedEventArgs e)
        {
            AddButton.IsEnabled = false;
            ItemDescriptionTextBox.IsEnabled = false;
            using (var documentStore = new DocumentStore())
            {
                documentStore.Url = "http://localhost:8080";
                documentStore.Initialize();
                using (var session = documentStore.OpenSession())
                {
                    var toDoItem = (ToDoItem)e.Parameter;
                    var loaded = session.Query<ToDoItem>().Where(tdi => tdi.Id == toDoItem.Id).First();
                    session.Delete(loaded);
                    session.SaveChanges();
                    AddButton.IsEnabled = true;
                    ItemDescriptionTextBox.IsEnabled = true;
                    Items.Remove(toDoItem);
                }
            }
        }
    }
}
