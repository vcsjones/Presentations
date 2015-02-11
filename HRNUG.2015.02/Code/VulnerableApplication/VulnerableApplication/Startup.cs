using System;
using System.Security.Cryptography;
using System.Web;
using System.Web.Helpers;
using System.Web.Mvc;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(VulnerableApplication.Startup))]
namespace VulnerableApplication
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            app.Use((context, next) =>
            {
                var rng = new RNGCryptoServiceProvider();
                var nonceBytes = new byte[32];
                rng.GetBytes(nonceBytes);
                var nonce = Convert.ToBase64String(nonceBytes);
                context.Set("ScriptNonce", nonce);
                context.Response.Headers.Add("Content-Security-Policy",
                    new[] {string.Format("script-src 'self' 'nonce-{0}'", nonce)});
                return next();
            });
            ConfigureAuth(app);
        }
    }

    public static class NonceHelper
    {
        public static IHtmlString ScriptNonce(this HtmlHelper helper)
        {
            return new HtmlString(helper.ViewContext.HttpContext.GetOwinContext().Get<string>("ScriptNonce"));
        }
    }
}
