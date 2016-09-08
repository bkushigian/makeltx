module Main where
import System.Directory
import System.Console.CmdArgs.Implicit
import System.FilePath.Posix
import Installer

import Lib
import Latex

main = do 
  parsedArgs <- cmdArgs (modes [install, run])
  handleArgs parsedArgs

handleArgs :: Arguments -> IO ()
handleArgs Install {}     = runInstaller
handleArgs a@Template {}
  | showall a = do
      contents <- readDataFile ("templates" </> "template.xml")
      putStrLn contents
handleArgs a@Run {}       = writeTexToFile a
  
