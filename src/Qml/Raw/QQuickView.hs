{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Qml.Raw.QQuickView where

import Foreign.C.String
import Foreign.Ptr
import Language.C.Inline qualified as C

import Qml.Raw.Context

C.context (C.baseCtx <> dosContext)

C.include "<DOtherSide/DOtherSide.h>"

qQuickViewCreate :: IO (Ptr QQuickView)
qQuickViewCreate = [C.block| 
  DosQQuickView* {
    return dos_qquickview_create();
  }
|]

qQuickViewSetSourceUrl :: Ptr QQuickView -> Ptr QUrl -> IO ()
qQuickViewSetSourceUrl view url = do
  [C.block|
    void {
      dos_qquickview_set_source_url($(DosQQuickView* view), $(DosQUrl* url));
    }
  |]

qQuickViewSetSource :: Ptr QQuickView -> String -> IO ()
qQuickViewSetSource view path = do
  cPath <- newCString path
  [C.block|
    void {
      dos_qquickview_set_source($(DosQQuickView* view), $(char* cPath));
    }
  |]

qQuickViewShow :: Ptr QQuickView -> IO ()
qQuickViewShow view = [C.block|
  void {
    dos_qquickview_show($(DosQQuickView* view));
  }
|]

qQuickViewDelete :: Ptr QQuickView -> IO ()
qQuickViewDelete view = [C.block|
  void {
    dos_qquickview_delete($(DosQQuickView* view));
  }
|]
