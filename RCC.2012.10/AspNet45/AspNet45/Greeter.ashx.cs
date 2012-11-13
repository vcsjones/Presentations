using System;
using System.Net.WebSockets;
using System.Text;
using System.Threading;
using System.Web;

namespace AspNet45
{
    public class Greeter : IHttpHandler
    {
        public void ProcessRequest(HttpContext context)
        {
            context.AcceptWebSocketRequest(async sc =>
            {
                var socket = sc.WebSocket;
                while(true)
                {
                    var buffer = new ArraySegment<byte>(new byte[1024]);
                    await socket.ReceiveAsync(buffer, CancellationToken.None);
                    if (socket.State == WebSocketState.Open)
                    {
                        var message = Encoding.UTF8.GetString(buffer.Array, 0, buffer.Count);
                        var response = "Hello from WebSockets, " + message + ". The time is: " + DateTime.Now.ToShortTimeString();
                        var responseBuffer = new ArraySegment<byte>(Encoding.UTF8.GetBytes(response));
                        for (var i = 0; i < 5; i++)
                        {
                            var q = new ArraySegment<byte>(Encoding.UTF8.GetBytes("Hello " + i));
                            await socket.SendAsync(q, WebSocketMessageType.Text, true, CancellationToken.None);
                            Thread.Sleep(2000);
                        }

                        await socket.SendAsync(responseBuffer, WebSocketMessageType.Text, true, CancellationToken.None);
                    }
                    else
                    {
                        break;
                    }
                }
            });
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}