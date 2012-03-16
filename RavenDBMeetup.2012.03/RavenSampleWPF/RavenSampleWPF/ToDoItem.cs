using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Input;
using Raven.Client.Document;

namespace RavenSampleWPF
{
    public class ToDoItem
    {
        public int Id { get; set; }
        public string Description { get; set; }
    }
}
