module Main where
import System.Directory
import System.Console.CmdArgs.Implicit
import System.FilePath.Posix
import Installer

import Lib
import Args
import Latex
import qualified XML

main = do 
  parsedArgs <- cmdArgs (modes [install, generate, template])
  handleArgs parsedArgs

-- Send XML name and description to stdout
printNameAndDesc :: XML.Template -> IO ()
printNameAndDesc t = do
  putStrLn $ XML.name_ t
  putStrLn $ XML.desc  t


handleArgs :: Arguments -> IO ()
handleArgs Install {}     = runInstaller
handleArgs a@Template {}
  | showall a = do
      templates <- XML.readTemplates
      mapM_ printNameAndDesc  templates

  | name_ a /= "" = do
      templates <- XML.readTemplates
      let filt = filter (\t -> XML.name_ t == name_ a) templates
      if null filt then 
        putStrLn "No template by that name"
        else 
          XML.copyTemplate (head filt)
          

handleArgs a@Generate {}       
  | getConfDir a = do
    mldir <- getAppUserDataDirectory programName
    putStrLn mldir
  | otherwise = writeTexToFile a
  
