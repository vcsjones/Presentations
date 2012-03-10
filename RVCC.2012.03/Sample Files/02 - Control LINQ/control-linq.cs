using System.Linq;

public class Person
{
	public string FirstName {get; set;}
	public string MiddleName {get; set;}
	public string LastName {get; set;}
	public int Age {get; set;}
	
	public Person(string firstName, string lastName, string middleName, int age)
	{
		FirstName = firstName;
		LastName = lastName;
		MiddleName = middleName;
		Age = age;
	}
	
	public void PrintFullName()
	{
		System.Console.WriteLine(FirstName + " " + MiddleName + " " + LastName);
	}
}

public class EntryPoint
{
	static void Main()
	{
		Person[] persons = GetPersons();
		System.Console.WriteLine("Old People:");
		foreach(Person person in persons.Where(p => p.Age >= 30))
		{
			person.PrintFullName();
		}
	}
	
	private static Person[] GetPersons()
	{
		Person[] persons = new Person[2];
		persons[0] = new Person("Kevin", "Jones", "Hammer", 24);
		persons[1] = new Person("Jonathan", "Cogley", "Michael", 33);
		return persons;
	}
}