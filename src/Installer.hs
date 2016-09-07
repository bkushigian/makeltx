module Installer (runInstaller ) where

import System.Directory
import System.IO

-- Naive Installer - no options
runInstaller = do
  mldir <- getAppUserDataDirectory "makeltx_installer"
  let mlpkg     = mldir ++ "/package-lists"
  let mlrc      = mldir ++ "/makeltx.rc"
  let templates = mldir ++ "/templates" 
  putStrLn "Installing MakeLTX..."
  putStrLn "Creating directories..."
  putStrLn mldir
  createDirectory mldir
  putStrLn mlpkg
  createDirectory mlpkg
  putStrLn templates
  mldir2 <- getAppUserDataDirectory "makeltx_installer"
  putStrLn "mldir2 ="
  putStrLn mldir2

