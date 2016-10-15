module Lib
    ( programName
    , readDataFile
    ) where

import Data.List
import System.Directory
import System.FilePath.Posix

programName = "makeltx"


readDataFile :: FilePath -> IO String
readDataFile f = do
  mldir <- getAppUserDataDirectory programName
  let filePath = mldir </> f
  readFile filePath


