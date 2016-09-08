{-# LANGUAGE Arrows, NoMonomorphismRestriction #-}
module XML ( Template(..)
           , readTemplates
           , copyTemplate
           ) where

import Text.XML.HXT.Core
import System.Directory
import System.FilePath.Posix

import qualified Lib
 
data Template = Template
  { name_
  , location
  , files
  , desc
  , author
  , source
  , url
  , notes
  , pkgs :: String
  } deriving (Show, Eq)

atTag tag = deep (isElem >>> hasName tag)
text = getChildren >>> getText
 
getTemplates = atTag "template" >>>
  proc t -> do
    nam_      <- text <<< atTag "name"     -< t
    locn_     <- text <<< atTag "location" -< t
    files_    <- text <<< atTag "files"    -< t
    desc_     <- text <<< atTag "desc"     -< t
    author_   <- text <<< atTag "author"   -< t
    source_   <- text <<< atTag "source"   -< t
    url_      <- text <<< atTag "url"      -< t
    notes_    <- text <<< atTag "notes"    -< t
    pkgs_     <- text <<< atTag "pkgs"     -< t
    returnA   -< Template
      { name_       = nam_
      , location    = locn_
      , files       = files_
      , desc        = desc_
      , author      = author_
      , source      = source_
      , url         = url_
      , notes       = notes_
      , pkgs        = pkgs_
      }
 
-- Our final choices
 
copyTemplate t = do
  let locn = ("templates" </> location t)
  let thefiles = read (files t) :: [FilePath]
  mldir <- getAppUserDataDirectory "makeltx"
  let src  = mldir </> locn
  dest <- getCurrentDirectory
  mapM_ (\x -> copyFile (src </> x) (dest </> x)) thefiles


readTemplates = do
  mldir <- getAppUserDataDirectory "makeltx"
  template <- runX (readDocument [withValidate no] (mldir </> "templates" </> "template.xml")
            >>> getTemplates)
  return template

