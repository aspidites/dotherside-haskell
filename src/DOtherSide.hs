{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module DOtherSide where

import Language.C.Inline qualified as C
import Foreign.Ptr
import Foreign.C.String

import DOtherSide.Context

C.context (C.baseCtx <> dosContext)

C.include "<DOtherSide/DOtherSide.h>"

qApplicationCreate :: IO ()
qApplicationCreate = [C.block| 
  void { 
    dos_qapplication_create(); 
  } 
|]

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

qApplicationExec :: IO ()
qApplicationExec = [C.block|
  void {
    dos_qapplication_exec();
  }
|]

qQmlApplicationEngineDelete :: Ptr QQmlApplicationEngine -> IO ()
qQmlApplicationEngineDelete engine = [C.block|
  void {
    dos_qqmlapplicationengine_delete($(DosQQmlApplicationEngine* engine));
  }
|]

qApplicationDelete :: IO ()
qApplicationDelete = [C.block|
  void {
    dos_qapplication_delete();
  }
|]
