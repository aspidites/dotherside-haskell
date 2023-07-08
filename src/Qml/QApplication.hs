module Qml.QApplication 
  ( exec
  , runQApplication
  ) where

import Control.Monad.Reader

import Qml.Types
import Qml.Raw

exec :: Qml ()
exec = liftIO qApplicationExec

runQApplication :: Qml () -> IO ()
runQApplication action = do
  qApplicationCreate
  engine <- qQmlApplicationEngineCreate
  flip (runReaderT . runQml) engine $ do

    action
    exec

  qQmlApplicationEngineDelete engine
  qApplicationDelete
