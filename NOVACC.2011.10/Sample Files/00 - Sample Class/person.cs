public class Person
{
	public string FirstName;
	public string MiddleName;
	public string LastName;
	public int Age;
	public Person Brother;
	
	public void PrintFullName()
	{
		System.Console.WriteLine(FirstName + " " + MiddleName + " " + LastName);
	}
}

public class EntryPoint
{
	static void Main()
	{
		Person john = new Person();
		john.FirstName = "John";
		john.LastName = "Smith";
		john.MiddleName = "X";
		john.Age = 12;
		
		Person kevin = new Person();
		john.Brother = kevin;
		kevin.FirstName = "Kevin";
		kevin.LastName = "Jones";
		kevin.MiddleName = "Hammer";
		kevin.Age = 25;
		kevin.Brother = john;
		kevin.PrintFullName();
		kevin.Brother.PrintFullName();
	}
}