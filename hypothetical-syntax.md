```haskell
-- option A
module Main where
import Qml (runQQuickView, registerType, addFunction) 

factorial :: Int -> Int
factorial n = if n == 0 then 1 else n * factorial (n-1)

main :: IO ()
main = runQQuickView "application.qml" do
  registerType "Math" 1 0 $ do
    addFunction "factorial" factorial
    addFunction "add" $ \x y -> x + y
```

```haskell
-- option B
module Main where
import Qml (QmlType(..), QmlContext(customTypes), defaultContext, runQQuickView)

-- defaultContext = QmlContext { customTypes = [ QmlType "Haskell.Prelude" 9 4 [ ("map", map), ...] ] }

factorial :: Int -> Int
factorial n = if n == 0 then 1 else n * factorial (n-1)

main :: IO ()
main = runQQuickView "application.qml" defaultContext
  { customTypes = defaultTypes <>
    [ QmlType "Math" 1 0 $ M.fromList 
      [ ("factorial", factorial)
      , ("add", \x y -> x + y)
      ]
    ]
```

```haskell
-- option C
module Main where
import Qml (QmlContext(..), QmlFunction(..), defaultContext, runQQuickView)

-- defaultContext = QmlContext { customTypes = [ QmlType "Haskell.Prelude" 9 4 [ QmlFunction "map" map, ...] ] } 

factorial :: Int -> Int
factorial n = if n == 0 then 1 else n * factorial (n-1)

main :: IO ()
main = runQQuickView 
  "application.qml" 
  defaultContext
    { customTypes = 
      [ QmlType "Math" 1 0 $
        [ QmlFuncion "factorial" factorial
        , QmlFunction "add" $ \x y -> x + y
        ]
      ]
    }
```

```qml
import QtQuick 6.0
import Haskell.Prelude 9.2 as P
import Math 1.0

Text {
  text: Math.add(P.sum(P.map(Math.factorial, [4, 9, 1])), 1); // 362906
}
````
