using System.IO;
using Cassette.Configuration;
using Cassette.Scripts;
using Cassette.Stylesheets;

namespace SampleCassette
{
    public class CassetteConfiguration : ICassetteConfiguration
    {
		public void Configure(BundleCollection bundles, CassetteSettings settings)
		{
			bundles.AddPerIndividualFile<StylesheetBundle>("Less");
			var compiler = new IECoffeeScriptCompiler();
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