-- TODO Download template files
module Installer (runInstaller ) where

import System.Directory
import System.IO
import Lib


url = "http://benkushigian.com/makeltx"

-- Naive Installer - no options
-- TODO check for previous install, handle accordingly
runInstaller = do
  mldir <- getAppUserDataDirectory programName
  let mlpkg     = mldir ++ "/package-lists"
  let mlrc      = mldir ++ "/makeltx.rc"
  let templates = mldir ++ "/templates" 
  let templ_xml = templates ++ "/templates.xml"
  putStrLn "Installing MakeLTX..."
  putStrLn "Creating directories..."
  putStrLn mldir
  createDirectory mldir
  putStrLn mlpkg
  createDirectory mlpkg


