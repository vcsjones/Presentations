using System.IO;
using Cassette.Configuration;
using Cassette.Scripts;
using Cassette.Stylesheets;

namespace MADExpoAsync
{
    /// <summary>
    /// Configures the Cassette asset modules for the web application.
    /// </summary>
    public class CassetteConfiguration : ICassetteConfiguration
    {
        public void Configure(BundleCollection bundles, CassetteSettings settings)
        {
            var compiler = new IECoffeeScriptCompiler();
            bundles.AddPerIndividualFile<StylesheetBundle>("Content");
            bundles.AddPerIndividualFile<ScriptBundle>("Scripts",
            new FileSearch { SearchOption = SearchOption.TopDirectoryOnly },
            b => b.Processor = new ScriptPipeline { CoffeeScriptCompiler = compiler });
            bundles.AddPerSubDirectory<ScriptBundle>("Scripts",
                b => b.Processor = new ScriptPipeline
                {
                    CoffeeScriptCompiler = compiler
                }, true);
        }
    }
}