module Qml.QUrl where

import Control.Exception
import Foreign.C.String
import Foreign.Ptr
import Qml.Raw qualified as Raw

data ParsingMode
  = TolerantMode
  | StrictMode
  | DecodeMode
  deriving (Eq, Ord, Enum)

qUrlCreate :: String -> ParsingMode -> IO (Ptr Raw.QUrl)
qUrlCreate url mode = do
  cUrl <- newCString url 
  Raw.qUrlCreate cUrl (fromIntegral $ fromEnum mode)

withQUrl :: String -> ParsingMode -> (Ptr Raw.QUrl -> IO ()) -> IO ()
withQUrl url mode k = 
  bracket 
    (flip Raw.qUrlCreate (fromIntegral $ fromEnum mode) =<< newCString url)
    k
    Raw.qUrlDelete

qUrlToString :: Ptr Raw.QUrl -> IO String
qUrlToString url = Raw.qUrlToString url >>= peekCString

qUrlIsValid :: Ptr Raw.QUrl -> IO Bool
qUrlIsValid url = do
  word <- Raw.qUrlIsValid url
  pure $ word > 0
