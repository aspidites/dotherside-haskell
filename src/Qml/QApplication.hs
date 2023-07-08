module Qml.QApplication 
  ( runQApplication
  ) where

import Control.Monad.Reader

import Qml.Types
import Qml.Raw

runQApplication :: Qml () -> IO ()
runQApplication action = do
  qApplicationCreate
  engine <- qQmlApplicationEngineCreate
  flip (runReaderT . runQml) engine $ do

    action

  qApplicationExec
  qQmlApplicationEngineDelete engine
  qApplicationDelete
