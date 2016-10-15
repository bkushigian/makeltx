{-# LANGUAGE DeriveDataTypeable #-}
module Args
    ( generate
    , template
    , install
    , Arguments(..)
    ) where

import System.Console.CmdArgs.Implicit

-- Hold arguments for program
data Arguments = Install | Generate
  { docType        :: String    -- Type of document (article, book, etc)
  , fontSize       :: String    -- Font size (10pt, 11pt, 12pt)
  , docSides       :: String    -- 1 or 2 sided document
  , paperSize      :: String    -- Paper size (A4, etc)
  , pkg            :: [String]  -- Which packages to 
  , imports        :: [String]  -- Paths to import
  , author         :: String    -- Author name
  , date           :: String    -- Current date
  , title          :: String    -- Title of Paper
  , subTitle       :: String    -- Subtitle
  , notes          :: [String]  -- Notes for heading
  , fileName       :: FilePath 
  , getConfDir     :: Bool
  } | Template 
  { name_           :: String
  , file            :: FilePath
  , url             :: String
  , showall         :: Bool
  , download        :: String
  --, fileName        :: FilePath
  } 
  deriving (Show, Data, Typeable)

--  Default Run Arguments
generate = Generate
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
  , getConfDir  = False       &= help "Get configuration directory path and exit."
  }

-- Default Template arguments
template = Template
  { name_         = "" &= help "Name of installed template"
  , file          = "" &= help "Path to template outside of install path !! NOT IMPL"
  , url           = "" &= help "Url of template to download to current directory NOT IMPL"
  , showall       = False &= help "Show all local templates"
  , download      = "" &= help "Install template by url !! NOT IMPL"
  --, fileName      = "" &= help "Name of created tex file"
  }
install = Install

