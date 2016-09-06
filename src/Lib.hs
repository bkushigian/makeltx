{-# LANGUAGE DeriveDataTypeable #-}
module Lib
    ( printArgs
    , arguments
    ) where

import System.Console.CmdArgs.Implicit
import Data.List
data Arguments = Arguments 
  { docType        :: String
  , fontSize       :: String
  , docSides       :: String
  , paperSize      :: String
  , pckgs          :: [String]
  , imports        :: [String]
  , author         :: String
  , date           :: String
  , title          :: String
  , subTitle       :: String
  , headerComments :: [String]
  , fileName       :: String
  } deriving (Show, Data, Typeable)

arguments = Arguments  
  { docType     = "article" &= help "What type of document is this?"
  , fontSize = "12pt"    &= help "Font size, ie '12pt'"
  , docSides    = "oneside" &= help "Number of sides: 'oneside' or 'twoside'"
  , paperSize   = "a4paper" &= help "Paper size. Defaults to 'a4paper'"
  , pckgs       = []        &= help "Packages to include. Use [options] for options, ie 'geometry[letterpaper,left=1in]'"
  , imports     = []        &= help "import statement. ie 'file1.tex, path/to/file2.tex'"
  , author      = ""        &= help "Who are you???"
  , date        = "\\today" &= help "Date of publication"
  , title       = "A Very Interesting Read" &= help "... and what are you doing here???"
  , subTitle    = ""        &= help "...... and have you seen my pants???????"
  , headerComments = []     &= help "Comments on header"
  ,fileName     = "main.tex" &= help "Name of tex file to be created"
  }

printArgs :: Arguments -> IO ()
printArgs a = do
  let dtype    = docType a
      fontsize = fontSize a
  putStrLn $ "docType:     " ++  docType a
  putStrLn $ "fontSize:    " ++ fontSize a
  putStrLn $ "docSides:    " ++ docSides a
  putStrLn $ "paperSize:   " ++ paperSize a
  putStrLn $ "packages:    " ++ intercalate "," (pckgs a)
  putStrLn $ "imports:     " ++ intercalate "," (imports a)
