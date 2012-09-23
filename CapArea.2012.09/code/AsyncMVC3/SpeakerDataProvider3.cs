﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Net;
using System.IO;
using System.Threading.Tasks;
using System.Diagnostics;

namespace AsyncMVC3
{
	public class SpeakerDataProvider
	{
		public Task<List<Speaker>> GetSpeakers()
		{
			Debug.WriteLine("START: GetSpeaker");
			var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;");
			var command = new SqlCommand("SELECT * FROM Speaker ORDER BY LastName, FirstName", connection);
			connection.Open();
			var task = Task.Factory.FromAsync<SqlDataReader>(command.BeginExecuteReader, command.EndExecuteReader, null)
				.ContinueWith(c =>
				{
					var list = new List<Speaker>();
					var reader = c.Result;
					while (reader.Read())
					{
						var speaker = new Speaker
						{
							SpeakerId = reader.GetInt32(0),
							FirstName = reader.GetString(1),
							LastName = reader.GetString(2),
							Twitter = reader.IsDBNull(3) ? null : reader.GetString(3),
							Bio = reader.GetString(4)
						};
						list.Add(speaker);
					}
					return list;
				})
				.ContinueWith(d =>
				{
					command.Dispose();
					connection.Dispose();
					Debug.WriteLine("END: GetSpeaker");
					return d.Result;
				});
			return task;
			/*using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
			{
				using (var command = new SqlCommand("", connection))
				{
					connection.Open();
					using (var reader = await command.ExecuteReaderAsync())
					{
						while (await reader.ReadAsync())
						{
							var speaker = new Speaker
							{
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
			}*/
		}

		public Task<Speaker> GetSpeaker(int speakerId)
		{
			Debug.WriteLine("START: GetSpeaker");
			var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;");
			var command = new SqlCommand("SELECT * FROM Speaker WHERE SpeakerId = @SpeakerId", connection);
			command.Parameters.AddWithValue("SpeakerId", speakerId);
			connection.Open();
			var task = Task.Factory.FromAsync<SqlDataReader>(command.BeginExecuteReader, command.EndExecuteReader, null)
				.ContinueWith(c =>
				{
					var reader = c.Result;
					while (reader.Read())
					{
						return new Speaker
						{
							SpeakerId = reader.GetInt32(0),
							FirstName = reader.GetString(1),
							LastName = reader.GetString(2),
							Twitter = reader.IsDBNull(3) ? null : reader.GetString(3),
							Bio = reader.GetString(4)
						};
					}
					return null;
				})
				.ContinueWith(d =>
				{
					command.Dispose();
					connection.Dispose();
					Debug.WriteLine("END: GetSpeaker");
					return d.Result;
				});
			return task;
		}

		public Task<List<Session>> GetSpeakerSessions(int speakerId)
		{
			Debug.WriteLine("START: GetSpeakerSessions");
			var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;");
			var command = new SqlCommand("SELECT * FROM Session WHERE SpeakerId = @SpeakerId ORDER BY Title", connection);
			command.Parameters.AddWithValue("SpeakerId", speakerId);
			connection.Open();
			var task = Task.Factory.FromAsync<SqlDataReader>(command.BeginExecuteReader, command.EndExecuteReader, null)
				.ContinueWith(c =>
				{
					var reader = c.Result;
					var list = new List<Session>();
					while (reader.Read())
					{
						var session = new Session
						{
							SessionId = reader.GetInt32(0),
							SpeakerId = reader.GetInt32(1),
							Title = reader.GetString(2),
							Level = reader.GetInt16(3),
							Abstract = reader.GetString(4)
						};
						list.Add(session);
					}
					return list;
				})
				.ContinueWith(d =>
				{
					command.Dispose();
					connection.Dispose();
					Debug.WriteLine("END: GetSpeakerSessions");
					return d.Result;
				});
			return task;
		}

		public Task<byte[]> GetSpeakerImage(int speakerId)
		{
			var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;");
			var command = new SqlCommand("SELECT Pic FROM Speaker WHERE SpeakerId = @SpeakerId", connection);
			command.Parameters.AddWithValue("SpeakerId", speakerId);
			connection.Open();
			var task = Task.Factory.FromAsync<SqlDataReader>(command.BeginExecuteReader, command.EndExecuteReader, null)
				.ContinueWith(c =>
			{
				var reader = c.Result;
				while (reader.Read())
				{
					if (reader.IsDBNull(0))
					{
						return null;
					}
					using (var ms = new MemoryStream())
					{
						const int BUFFER_SIZE = 1024;
						byte[] buffer = new byte[BUFFER_SIZE];
						int bytesRead, offset = 0;
						while ((bytesRead = (int)reader.GetBytes(0, offset, buffer, 0, BUFFER_SIZE)) > 0)
						{
							ms.Write(buffer, 0, bytesRead);
							offset += bytesRead;
						}
						return ms.ToArray();
					}
				}
				return null;
			}).ContinueWith(d =>
			{
				command.Dispose();
				connection.Dispose();
				return d.Result;
			});
			return task;
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

	public class Session
	{
		public int SessionId { get; set; }
		public int SpeakerId { get; set; }
		public short Level { get; set; }
		public string Title { get; set; }
		public string Abstract { get; set; }
	}
}