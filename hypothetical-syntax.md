```haskell
import Qml

main1 = runQQuickView "application.qml" do
  registerType "Math" 1 0 $ do
    addFunction "factorial" factorial
    addFunction "add" $ \x y -> x + y

main2 = runQQuickView "application.qml" defaultContext
  { customTypes =
    { QmlType "Math" 1 0 $ M.fromList 
      [ ("factorial", factorial)
      , ("add", \x y -> x + y)
      ]
    }

main3 = runQQuickView 
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
import Math 1.0

Text {
  text: Math.add(Math.factorial(3), 9)
}
````
