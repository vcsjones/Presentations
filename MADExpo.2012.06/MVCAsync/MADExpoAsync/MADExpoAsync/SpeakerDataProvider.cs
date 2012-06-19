using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Net;
using System.Threading.Tasks;

namespace MADExpoAsync
{
	public class SpeakerDataProvider
	{
		public async Task<IList<Speaker>> GetSpeakers()
		{
			var list = new List<Speaker>();
			using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
			{
				using (var command = new SqlCommand("SELECT * FROM Speaker ORDER BY LastName, FirstName", connection))
				{
					connection.Open();
					using (var reader = await command.ExecuteReaderAsync())
					{
						while (await reader.ReadAsync())
						{
							var speaker = new Speaker {
								SpeakerId = reader.GetInt32(0),
								FirstName = reader.GetString(1),
								LastName = reader.GetString(2),
								Twitter = reader.IsDBNull(3) ? null : reader.GetString(3),
								Bio = reader.GetString(4)
							};
							list.Add(speaker);
						}
					}
				}
			}
			return list;
		}
	}

	public class Speaker
	{
		public int SpeakerId { get; set; }
		public string FirstName { get; set; }
		public string LastName { get; set; }
		public string Twitter { get; set; }
		public string Bio { get; set; }
	}
}