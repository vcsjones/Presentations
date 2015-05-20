namespace DCDotNetMeetup
{
	public interface IGreeter
	{
		string Greet(string name);
	}
	
	public class EnglishGreeter : IGreeter
	{
		public string Greet(string name)
		{
			return $"Hello, {name}!";
		}
	}
	
	public class RussianGreeter : IGreeter
	{
		public string Greet(string name)
		{
			return $"Privet, {name}!";
		}
	}
}