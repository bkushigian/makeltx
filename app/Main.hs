module Main where
import System.Console.CmdArgs.Implicit

import Lib
import Latex

main = do 
  parsedArgs <- cmdArgs run
  writeTexToFile parsedArgs
