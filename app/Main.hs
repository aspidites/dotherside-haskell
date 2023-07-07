module Main where

import DOtherSide
import Foreign.C.String

main :: IO ()
main = do 
  contents <- readFile "./example/window.qml"
  qml <- newCString contents

  qApplicationCreate
  engine <- qQmlApplicationEngineCreate
  qQmlApplicationEngineLoadData engine qml

  qApplicationExec

  qQmlApplicationEngineDelete engine
  qApplicationDelete
