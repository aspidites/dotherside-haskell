module Qml.QGuiApplication 
  ( runQGuiApplication
  ) where

import Qml.Raw

runQGuiApplication :: IO () -> IO ()
runQGuiApplication action = do
  qGuiApplicationCreate

  action

  qGuiApplicationExec
  qGuiApplicationDelete
