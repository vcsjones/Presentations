public class Person
{
	public string FirstName;
	public string MiddleName;
	public string LastName;
	public int Age;
	
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
		foreach(Person person in persons)
		{
			if (person.Age >= 30)
			{
				person.PrintFullName();
			}
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