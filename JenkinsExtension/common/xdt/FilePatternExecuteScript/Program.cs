using CommandLine;
using System.Diagnostics;
using System.Text.RegularExpressions;

namespace FilePatternExecuteScript
{
    internal class Program
    {

        const string defaultFilePattern = @"^(.*)\.\w+\.xdt\.xml";

        public class Options
        {

            [Option('d', "directory", Required = true, HelpText = "Input folder")]
            public string? folder { get; set; }

            [Option('c', "command", Required = true, HelpText = @"command to be executed. E.g. 'D:\CommandFolder\Command.exe {0} {1} -v' where the matched file name (regex = filePattern) will pass into {0} and the regex replace file name (regex = fileReplacePattern) will pass into {1}.")]
            public string? command { get; set; }

            [Option('p', "fileregex", Required = false, Default = defaultFilePattern, HelpText = "file name should match this regex which the filename will pass to {0} in command parameter. If not configure, the value is " + defaultFilePattern)]
            public string filePattern { get; set; }
            [Option('r', "replacefileregex", Required = false, Default = defaultFilePattern, HelpText = "file name replace regex which the value will pass to {1} in command parameter. If not configure, the value is " + defaultFilePattern)]
            public string fileReplacePattern { get; set; }

        }

        static void Main(string[] args)
        {

            Parser.Default.ParseArguments<Options>(args)
       .WithParsed<Options>(o =>
       {
           if (o.folder == null)
               throw new ArgumentNullException(nameof(o.folder));
           if (o.filePattern == null)
               throw new ArgumentNullException(nameof(o.filePattern));
           if (o.fileReplacePattern == null)
               throw new ArgumentNullException(nameof(o.fileReplacePattern));
           if (o.command == null || !o.command.Contains("{0}") || !o.command.Contains("{1}"))
               throw new FormatException("{0} should be existed in the command parameter to pass the file name");

           Regex reg = new Regex(defaultFilePattern);

           var xdtFiles = Directory.GetFiles(o.folder ?? String.Empty, "*", SearchOption.AllDirectories).Where(path => reg.IsMatch(path)).ToList();

           var files = xdtFiles.Where(s => s.EndsWith("DR.xdt.xml"));

           Console.ForegroundColor = ConsoleColor.Blue;
           Console.WriteLine("----Start----");
           Console.ForegroundColor = ConsoleColor.White;

           foreach (var file in files)
           {
               Console.WriteLine(string.Format("file {0} is found.", file));

               var filePatternValue = file;
               var fileReplacePatternValue = Regex.Replace(filePatternValue, o.fileReplacePattern, "$1");

               var fullCommand = string.Format(o.command ?? String.Empty, filePatternValue, fileReplacePatternValue);
               RunCmd(fullCommand);
           }

           Console.ForegroundColor = ConsoleColor.Blue;
           Console.WriteLine("----End----");
           Console.ForegroundColor = ConsoleColor.White;

       });


        }

        public static void RunCmd(string command)
        {
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine(string.Format("----Start to execute the command '{0}'----", command));

            Console.ForegroundColor = ConsoleColor.Yellow;
            var info = new ProcessStartInfo("cmd.exe", "/c " + command);
            info.UseShellExecute = false;
            var proc = Process.Start(info);
            if (proc != null)
                proc.WaitForExit();
            Console.ForegroundColor = ConsoleColor.Green;
            Console.WriteLine(string.Format("----executed command----", command));
            Console.ForegroundColor = ConsoleColor.White;
            Console.WriteLine("");
        }

    }
}