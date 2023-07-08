{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
module Qml.Raw.QUrl 
  ( qUrlCreate
  , qUrlDelete
  , qUrlToString
  , qUrlIsValid
  ) where

import Foreign.Ptr
import Foreign.C.Types
import Foreign.C.String
import Language.C.Inline qualified as C

import Qml.Raw.Context

C.context (C.baseCtx <> dosContext)

C.include "<DOtherSide/DOtherSide.h>"

qUrlCreate :: CString -> CInt -> IO (Ptr QUrl)
qUrlCreate url mode = [C.block| 
  DosQUrl* {
    return dos_qurl_create($(char* url), $(int mode));
  }
|]

qUrlDelete :: Ptr QUrl -> IO ()
qUrlDelete url = [C.block| 
  void {
    return dos_qurl_delete($(DosQUrl* url));
  }
|]

qUrlToString :: Ptr QUrl -> IO CString
qUrlToString url = [C.block| 
  char* {
    return dos_qurl_to_string($(DosQUrl* url));
  }
|]

qUrlIsValid :: Ptr QUrl -> IO C.CBool
qUrlIsValid url = [C.block|
  bool {
    return dos_qurl_isValid($(DosQUrl* url));
  }
|]
