{-# LANGUAGE DeriveDataTypeable #-}
module Main where

import Lib
import System.Console.CmdArgs.Implicit

data Arguments = Arguments 
  { docType        :: String
  , fontSize    :: String
  , docSides       :: String
  , paperType      :: String
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
  , paperType   = "a4paper" &= help "Paper type. Defaults to 'a4paper'"
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
  let dtype = docType a
  putStrLn $ "docType = " ++ dtype

main = do 
  parsedArgs <- cmdArgs arguments
  printArgs parsedArgs
