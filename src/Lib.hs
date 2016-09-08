{-# LANGUAGE DeriveDataTypeable #-}
module Lib
    ( install
    , programName
    , readDataFile
    , run
    , template
    , Arguments(..)
    ) where

import Data.List
import System.Console.CmdArgs.Implicit
import System.Directory
import System.FilePath.Posix

programName = "makeltx"

-- Hold arguments for program
data Arguments = Install | Run
  { docType        :: String
  , fontSize       :: String
  , docSides       :: String
  , paperSize      :: String
  , pkg            :: [String]
  , imports        :: [String]
  , author         :: String
  , date           :: String
  , title          :: String
  , subTitle       :: String
  , notes          :: [String]
  , fileName       :: FilePath
  } | Template 
  { name_           :: String
  , file            :: FilePath
  , url             :: String
  , showall         :: Bool
  , download        :: String
  , fileName        :: FilePath
  }

  deriving (Show, Data, Typeable)

--  Default Run Arguments
run = Run
  { docType     = "article"   &= help "What type of document is this?"
  , fontSize    = "12pt"      &= help "Font size, ie '12pt'"
  , docSides    = "oneside"   &= help "Number of sides: 'oneside' or 'twoside'"
  , paperSize   = "a4paper"   &= help "Paper size. Defaults to 'a4paper'"
  , pkg         = []          &= help "Packages to include. Use [options] for options, ie 'geometry[letterpaper,left=1in]'"
  , imports     = []          &= help "import statement. ie 'file1.tex, path/to/file2.tex'"
  , author      = "A Very Interesting Person" &= help "Who are you???"
  , date        = "\\today"   &= help "Date of publication"
  , title       = "A Very Interesting Read"   &= help "... and what are you doing here???"
  , subTitle    = ""          &= help "...... and have you seen my pants???????"
  , notes       = []          &= help "Comments on header"
  , fileName    = "main.tex"  &= help "Name of tex file to be created"
  }

-- Default Template arguments
template = Template
  { name_        = "" &= help "Name of installed template"
  , file         = "" &= help "Path to template outside of install path"
  , url         = "" &= help "Url of template to download to current directory"
  , showall     = False &= help "Show all local templates"
  , download    = "" &= help "Install template by url"
  , fileName    = "" &= help "Name of created tex file"
  }
install = Install

readDataFile :: FilePath -> IO String
readDataFile f = do
  mldir <- getAppUserDataDirectory programName
  let filePath = mldir </> f
  readFile filePath


