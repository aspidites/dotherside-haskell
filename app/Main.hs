module Main where

import Qml
import Qml.QGuiApplication

main :: IO ()
main = do
  app <- readFile "./example/qml/main.qml"
  runQGuiApplication $ do
    loadData app
