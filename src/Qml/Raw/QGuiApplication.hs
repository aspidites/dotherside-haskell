{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Qml.Raw.QGuiApplication where

import Language.C.Inline qualified as C

import Qml.Raw.Context

C.context (C.baseCtx <> dosContext)

C.include "<DOtherSide/DOtherSide.h>"

qGuiApplicationCreate :: IO ()
qGuiApplicationCreate = [C.block|
  void {
    dos_qguiapplication_create();
  }
|]


qGuiApplicationDelete :: IO ()
qGuiApplicationDelete = [C.block|
  void {
    dos_qguiapplication_delete();
  }
|]


qGuiApplicationExec :: IO ()
qGuiApplicationExec = [C.block|
  void {
    dos_qguiapplication_exec();
  }
|]
