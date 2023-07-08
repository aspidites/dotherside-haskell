{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Qml.Raw.QQmlApplicationEngine where

import Foreign.Ptr
import Foreign.C.String
import Language.C.Inline qualified as C

import Qml.Raw.Context

C.context (C.baseCtx <> dosContext)
C.include "<DOtherSide/DOtherSide.h>"

qQmlApplicationEngineCreate :: IO (Ptr QQmlApplicationEngine)
qQmlApplicationEngineCreate = [C.block| 
  DosQQmlApplicationEngine* {
    return dos_qqmlapplicationengine_create();
  }
|]

qQmlApplicationEngineLoadData :: Ptr QQmlApplicationEngine -> CString -> IO ()
qQmlApplicationEngineLoadData engine qml = [C.block| 
  void { 
    dos_qqmlapplicationengine_load_data($(DosQQmlApplicationEngine* engine), $(char* qml));
  } 
|]

qQmlApplicationEngineDelete :: Ptr QQmlApplicationEngine -> IO ()
qQmlApplicationEngineDelete engine = [C.block|
  void {
    dos_qqmlapplicationengine_delete($(DosQQmlApplicationEngine* engine));
  }
|]

