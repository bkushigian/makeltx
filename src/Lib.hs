{-# LANGUAGE DeriveDataTypeable #-}
module Lib
    ( printArgs
    , defaultArgs
    , writeTexStdOut
    , writeTexToFile
    ) where

import Data.List
import System.Console.CmdArgs.Implicit
import System.IO

-- Hold arguments for program
data Arguments = Arguments 
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
  , notes :: [String]
  , fileName       :: FilePath
  } deriving (Show, Data, Typeable)

-- defaultArgs Default Arguments
defaultArgs = Arguments  
  { docType     = "article" &= help "What type of document is this?"
  , fontSize = "12pt"    &= help "Font size, ie '12pt'"
  , docSides    = "oneside" &= help "Number of sides: 'oneside' or 'twoside'"
  , paperSize   = "a4paper" &= help "Paper size. Defaults to 'a4paper'"
  , pkg         = []        &= help "Packages to include. Use [options] for options, ie 'geometry[letterpaper,left=1in]'"
  , imports     = []        &= help "import statement. ie 'file1.tex, path/to/file2.tex'"
  , author      = "A Very Interesting Person" &= help "Who are you???"
  , date        = "\\today" &= help "Date of publication"
  , title       = "A Very Interesting Read" &= help "... and what are you doing here???"
  , subTitle    = ""        &= help "...... and have you seen my pants???????"
  , notes       = []     &= help "Comments on header"
  , fileName    = "main.tex" &= help "Name of tex file to be created"
  }

printArgs :: Arguments -> IO ()
printArgs a = do
  putStrLn $ "docType:        " ++  docType a
  putStrLn $ "fontSize:       " ++ fontSize a
  putStrLn $ "docSides:       " ++ docSides a
  putStrLn $ "paperSize:      " ++ paperSize a
  putStrLn $ "packages:       " ++ intercalate "," (pkg a)
  putStrLn $ "imports:        " ++ intercalate "," (imports a)
  putStrLn $ "author:         " ++ author a
  putStrLn $ "date:           " ++ date a
  putStrLn $ "title:          " ++ title a
  putStrLn $ "subTitle:       " ++ subTitle a
  putStrLn $ "notes:          " ++ intercalate "\n%% " (replicate 80 '%' : notes a)
  putStrLn $ "output file:    " ++ fileName a

texString :: Arguments -> String
texString a = intercalate "\n" [ assembleFileHeader a
                               , assemblePackages $ pkg a
                               , beginDocument
                               , makeTitle
                               , documentBody
                               , endDocument
                               ]
  where 
    fullLineComment = replicate 80 '%'

    commentString :: String -> String
    commentString xs = "%% " ++ xs
    beginDocument = "\n\n\\begin{document}"
    endDocument   = "\n\n\\end{document}"
    makeTitle     = "\\maketitle"
    documentBody  = "\n\n" ++ "%% Your latex code goes here"

    assembleFileHeader :: Arguments -> String
    assembleFileHeader a = 
      fullLineComment ++ 
      intercalate "\n%% " (
        ["\n%% Author:           " ++ author a
        ,"Title:            " ++ title a
        ,"Date:             Current Date Here"
        ] ++ ( notes a) )
      ++ ('\n':fullLineComment)

        
    -- formatPackage s = "\usepackage" ++ extractPackageOptions s
    formPackageString :: String -> String
    formPackageString xs = let 
      (pkgName, pkgOpt) = span (/= '[') xs in 
      "\\usepackage" ++ pkgOpt ++ ( '{' : (pkgName ++ "}"))

    assemblePackages = intercalate "\n" . map formPackageString

writeTexStdOut :: Arguments -> IO ()
writeTexStdOut a = putStrLn $ texString a

writeTexToFile :: Arguments -> IO ()
writeTexToFile a = writeFile (fileName a) (texString a)
