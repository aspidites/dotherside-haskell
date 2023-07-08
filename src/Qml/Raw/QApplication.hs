{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Qml.Raw.QApplication where

import Language.C.Inline qualified as C

import Qml.Raw.Context

C.context (C.baseCtx <> dosContext)
C.include "<DOtherSide/DOtherSide.h>"

qApplicationCreate :: IO ()
qApplicationCreate = [C.block| 
  void { 
    dos_qapplication_create(); 
  } 
|]

qApplicationExec :: IO ()
qApplicationExec = [C.block|
  void {
    dos_qapplication_exec();
  }
|]

qApplicationDelete :: IO ()
qApplicationDelete = [C.block|
  void {
    dos_qapplication_delete();
  }
|]

