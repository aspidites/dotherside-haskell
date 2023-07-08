module Qml.Types where

import Control.Monad.Reader
import Foreign.Ptr
import Qml.Raw

newtype Qml a = Qml { runQml :: ReaderT (Ptr QQmlApplicationEngine) IO a }
  deriving (Functor, Applicative, Monad, MonadIO, MonadReader (Ptr QQmlApplicationEngine))
