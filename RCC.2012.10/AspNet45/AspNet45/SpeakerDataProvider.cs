using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Data.SqlClient;
using System.IO;
using System.Diagnostics;
using System.Threading.Tasks;

namespace AspNet45
{
    public class SpeakerDataProvider
    {
        public static List<Speaker> GetSpeakers()
        {
            using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
            {
                using (var command = new SqlCommand("SELECT * FROM Speaker ORDER BY LastName, FirstName", connection))
                {
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
                        var list = new List<Speaker>();
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
                    }
                }
            }
        }

        public static Speaker GetSpeaker(int speakerId)
        {
            Debug.WriteLine("START: GetSpeaker");
            using (
                var connection =
                    new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
            {
                using (var command = new SqlCommand("SELECT * FROM Speaker WHERE SpeakerId = @SpeakerId", connection))
                {
                    command.Parameters.AddWithValue("SpeakerId", speakerId);
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
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
                    }
                }
            }
        }

        public static bool UpdateSpeaker(Speaker speaker)
        {
            using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
            {
                using (var command = new SqlCommand("UPDATE Speaker SET FirstName = @FirstName, LastName = @LastName, Twitter = @Twitter WHERE SpeakerId = @SpeakerId", connection))
                {
                    command.Parameters.AddWithValue("@SpeakerId", speaker.SpeakerId);
                    command.Parameters.AddWithValue("@FirstName", speaker.FirstName);
                    command.Parameters.AddWithValue("@LastName", speaker.LastName);
                    command.Parameters.AddWithValue("@Twitter", speaker.Twitter == null ? DBNull.Value : (object)speaker.Twitter);
                    connection.Open();
                    return command.ExecuteNonQuery() > 0;
                }
            }
        }

        public List<Session> GetSpeakerSessions(int speakerId)
        {
            Debug.WriteLine("START: GetSpeakerSessions");
            using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
            {
                using (var command = new SqlCommand("SELECT * FROM Session WHERE SpeakerId = @SpeakerId ORDER BY Title", connection))
                {
                    command.Parameters.AddWithValue("SpeakerId", speakerId);
                    connection.Open();
                    using (var reader = command.ExecuteReader())
                    {
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
                    }
                }
            }
        }

        public static async Task<byte[]> GetSpeakerImage(int speakerId)
        {
            using (var connection = new SqlConnection("Data Source=(local); Initial Catalog=MADExpoKJ;Integrated Security=SSPI;"))
            {
                using (var command = new SqlCommand("SELECT Pic FROM Speaker WHERE SpeakerId = @SpeakerId", connection))
                {
                    command.Parameters.AddWithValue("SpeakerId", speakerId);
                    connection.Open();
                    var result = await command.ExecuteScalarAsync();
                    return result as byte[];
                }
            }
        }
    }

    public class Speaker
    {
        public int SpeakerId { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        [Required(ErrorMessage = "Twitter is required.")]
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