module Main where
import System.Console.CmdArgs.Implicit

import Lib

main = do 
  parsedArgs <- cmdArgs arguments
  printArgs parsedArgs
