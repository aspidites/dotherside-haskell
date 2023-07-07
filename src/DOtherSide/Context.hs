{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE OverloadedStrings #-}
module DOtherSide.Context where

import Data.Map.Strict qualified as M

import Language.C.Inline qualified as C
import Language.C.Inline.Context qualified as C
import Language.C.Types

data QQmlApplicationEngine = QQmlApplicationEngine

dosContext :: C.Context
dosContext = mempty 
  { C.ctxTypesTable = M.fromList
    [ ( TypeName "DosQQmlApplicationEngine", [t| QQmlApplicationEngine |])
    ]
  }

