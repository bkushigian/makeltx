{-# LANGUAGE DeriveDataTypeable #-}
module Latex
  ( texString
  , writeTexStdOut
  , writeTexToFile
  , writeTemplateToFile
  ) where
import Data.List
import System.IO
import System.Directory
import System.FilePath.Posix
import Args

import Lib

texString :: Arguments -> String
texString (Install {}) = error "Cannot form a LaTeX string while installing"
texString a@Generate {} = intercalate "\n" [ assembleFileHeader a
                               , assemblePackages $ pkg a
                               , "\\author{" ++ author a ++ "}"
                               , "\\title{"  ++ title  a ++ "}"
                               , "\\date{"   ++ date   a ++ "}"
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
templateString :: Arguments -> IO String
templateString Install {}    = error "Install is not a Template"
templateString Generate {}   = error "Generate is not a Template"
templateString a@Template {} = do
  appDir <- getAppUserDataDirectory programName 
  let filePath = appDir </> "templates" </> name_ a
  readFile filePath
  

writeTexStdOut :: Arguments -> IO ()
writeTexStdOut Install{} = error "Cannot form a LaTeX string while installing"
writeTexStdOut Template{} = error "writeTexStdOut(Template)!! unimplemented"
writeTexStdOut a = putStrLn $ texString a

writeTexToFile :: Arguments -> IO ()
writeTexToFile Install {}  = error "Cannot form a LaTeX string while installing"
writeTexToFile Template {} = error "writeTexToFile(Template)!! unimplemented"
writeTexToFile a           = writeFile (fileName a) (texString a)

writeTemplateToFile :: Arguments -> IO ()
writeTemplateToFile Install  {} = error "Install is not a template"
writeTemplateToFile Generate {} = error "Run is not a template"
writeTemplateToFile a = do 
  contents <- templateString a
  writeFile (fileName a) contents

