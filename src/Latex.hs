{-# LANGUAGE DeriveDataTypeable #-}
module Latex
  ( texString
  , writeTexStdOut
  , writeTexToFile
  ) where
import Data.List
import System.IO

import Lib

texString :: Arguments -> String
texString (Install {}) = error "Cannot form a LaTeX string while installing"
texString a@Run {} = intercalate "\n" [ assembleFileHeader a
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
writeTexStdOut Install{} = error "Cannot form a LaTeX string while installing"
writeTexStdOut a = putStrLn $ texString a

writeTexToFile :: Arguments -> IO ()
writeTexToFile Install {} = error "Cannot form a LaTeX string while installing"
writeTexToFile a = writeFile (fileName a) (texString a)
