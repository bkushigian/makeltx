module Main where
import System.Console.CmdArgs.Implicit
import Installer

import Lib
import Latex

main = do 
  parsedArgs <- cmdArgs (modes [install, run])
  handleArgs parsedArgs

handleArgs :: Arguments -> IO ()
handleArgs Install {}   = runInstaller
handleArgs a@Run {}     = writeTexToFile a
  
