using System;
using System.Collections.Generic;

namespace MyFirstApplication
{
	public class Person
	{
		public string FirstName;
		public string LastName;
		public int Age;
		
		public void SayHello()
		{
			Console.WriteLine("Hello, " + FirstName + " " + LastName);
			Console.WriteLine("You Are " + Age + " Year(s) old"); 
		}
	}

	public class EntryPoint {
		static void Main()
		{
			List<Person> persons = new List<Person>();
			persons.Add(new Person());
			persons[0].FirstName = "Kevin";
			persons[0].LastName = "Jones";
			persons[0].Age = 500;
			persons.Add(new Person());
			persons[1].FirstName = "Jonathan";
			persons[1].LastName = "Smith";
			persons[1].Age = 35;
			foreach(Person p in persons)
			{
				p.SayHello();
				if (p.Age > 40)
				{
					Console.WriteLine(p.FirstName + ", you are old.");
				}
			}
		}
	}
}