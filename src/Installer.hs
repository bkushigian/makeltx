-- TODO Download template files
module Installer (runInstaller ) where

import System.Directory
import System.IO
import Lib
import Network.Download
import Data.Either


url = "http://benkushigian.com/makeltx/"
fileListings = "files.out"

-- Naive Installer - no options
-- TODO Download appropriate files from benkushigian.com/makeltx
runInstaller = do
  mldir <- getAppUserDataDirectory programName
  -- If directory exists, output error message
  mldirExists <- doesDirectoryExist mldir
  if mldirExists then do
    putStrLn "textools already installed, or leftover directory from a previous install."
    putStrLn $ "To reinstall, please remove " ++ mldir
    else do
      let mlpkg     = mldir ++ "/package-lists"
      let mlrc      = mldir ++ "/makeltx.rc"
      let templates = mldir ++ "/templates" 
      let templ_xml = templates ++ "/templates.xml"
      putStrLn "Installing MakeLTX..."
      putStrLn "Creating directories..."
      putStrLn mldir

      createDirectoryIfMissing True mldir
      putStrLn mlpkg
      createDirectory mlpkg
      
      -- Download from url
--      putStrLn "Downloading files..."
--      doc <- openURI $ url ++ fileListings
--      let toDownload = extractRelativePaths lefts[doc]

      
--extractRelativePaths stuff 
--    | []      = []
--    | lines stuff



