module Qml.QQuickView 
  ( runQQuickView
  ) where

import Qml.Raw
import Qml.QGuiApplication

runQQuickView :: FilePath -> IO ()
runQQuickView path = runQGuiApplication $ do
  view <- qQuickViewCreate
  cPath <- newCString path
  url <- qUrlCreate cPath 0
  qQuickViewSetSourceUrl view url
  qQuickViewShow view
