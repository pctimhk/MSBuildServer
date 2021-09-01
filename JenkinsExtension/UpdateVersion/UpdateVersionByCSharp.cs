using System;
using System.Text.RegularExpressions;

public class Program
{
	public static void Main(string[] args)
	{
    var myPaths = Directory.GetFiles(Path.GetDirectoryName(Process.GetCurrentProcess().MainModule.FileName), "AssemblyInfo.cs", SearchOption.AllDirectories);
    string myMatch = @"Assembly([a-zA-Z]*)Version\(""(\d+).(\d+).(\d+).(\d+)""\)";
    string myReplace = string.Format(@"Assembly$1Version(""$2.$3.$4.{0}"")", args[0]);
    
    foreach (var myPath in myPaths)
    {
      File.WriteAllText(myPath, Regex.Replace(File.ReadAllText(myPath), myMatch, myReplace));
    }
	}
	
	public static void RegExSample()
	{
    string myWords = "[assembly: AssemblyVersion(\"1.0.0.0\")]";
    string myMatch = @"\[assembly:\sAssemblyVersion\(\""(\d+)\.(\d+)\.(\d+)\.(\d+|\*)\""\)\]";
    string myReplace = @"[assembly: AssemblyVersion(""$1.$2.$3.1234"")]";
    myReplace = String.Format(myReplace, "1234");
    String myNewWording = Regex.Replace(myWords, myMatch, myReplace);
    Console.WriteLine("Original words:" + myWords);
    Console.WriteLine("Replace matern:" + myReplace);
    Console.WriteLine("New words:" + myNewWording);
	}
}