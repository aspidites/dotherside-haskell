module Qml.QQmlApplicationEngine where

import Control.Monad.Reader 
import Foreign.C.String

import Qml.Raw
import Qml.Types

loadData :: String -> Qml ()
loadData qml = do
  engine <- ask
  src <- liftIO $ newCString qml
  liftIO $ qQmlApplicationEngineLoadData engine src
