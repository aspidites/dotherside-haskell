module Qml.QQuickView 
  ( runQQuickView
  ) where

import Control.Monad.Trans
import Qml.Raw
import Qml.QGuiApplication

runQQuickView :: FilePath -> IO ()
runQQuickView path = runQGuiApplication $ do
  view <- liftIO qQuickViewCreate
  cPath <- liftIO $ newCString path
  url <- liftIO $ qUrlCreate cPath 0
  liftIO $ qQuickViewSetSourceUrl view url
  liftIO $ qQuickViewShow view
