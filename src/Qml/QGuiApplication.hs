module Qml.QGuiApplication 
  ( runQGuiApplication
  ) where

import Control.Monad.Reader
import Qml.Raw
import Qml.Types

runQGuiApplication :: Qml () -> IO ()
runQGuiApplication action = do
  qGuiApplicationCreate
  engine <- qQmlApplicationEngineCreate
  flip (runReaderT . runQml) engine $ do

    action

  qGuiApplicationExec
  qQmlApplicationEngineDelete engine
  qGuiApplicationDelete
