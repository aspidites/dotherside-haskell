# DOtherSide
Haskell bindings to [DOtherSide](https://github.com/filcuc/dotherside), which itself is a C library for binding to [Qt QML](https://doc.qt.io/qt-6/qmlapplications.html).

## Why another library?
Astute readers may be wondering why I'm writing another set of
bindings instead of using Robin Kay's
[HsQML](https://hackage.haskell.org/package/hsqml). A few
reasons:
- I wanted to lean how to bind C libraries for use in Haskell
- I wanted to do something akin to the [SDL2
  bindings](https://hackage.haskell.org/package/sdl2) and
  provide both a lower-level "Raw" binding that mirrored DOtherSide closely,
  and a higher-level, more idiomatic binding to use
- I want to (eventually) experiment with generics as a way to expose normal Haskell data types for use in QML
- I wanted to explore whether it was worth exposing QML as a DSL inside of Haskell such that you didn't have to write separate QML files

By all means, however, if you want to use QML in your Haskell project, HsQML is the way to go today. Perhaps I'll get far along enough in these bindings to make the choice less obvious, but for now, that's certainly true. 

If you're still curious about how these libraries differ
syntactically, here's a brief example, porting the code from
["Deploying QML
Applications"](https://doc.qt.io/qt-6/qtquick-deployment.html)

```qml
// application.qml
import QtQuick

Rectangle { 
    width: 100
    height: 100
    color: "red" 
}
```

You would typically write the following C++:
```c++
#include <QGuiApplication>
#include <QQuickView>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQuickView view;
    view.setSource(QUrl::fromLocalFile("application.qml"));
    view.show();

    return app.exec();
}
```

With HsQML, you can replace the C++ with the following:
```haskell
import Graphics.QML

main :: IO ()
main = do
    runEngineLoop defaultEngineConfig
        { initialDocument = fileDocument "application.qml" }
```


With DOtherSide, the API is a bit more verbose since it's a [C API](https://filcuc.github.io/dotherside/index.html):
```c
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <DOtherSide/DOtherSide.h>

int main() {
  dos_qguiapplication_create();
  DosQQuickView *view = dos_qquickview_create();
  DosQUrl *url = dos_qurl_create("application.qml", 1);

  dos_qquickview_set_source_url(view, url);
  dos_qquickview_show(view);

  dos_qguiapplication_exec();

  dos_qurl_delete(url);
  dos_qquickview_delete(view);
  dos_qguiapplication_delete();

  return 0;
}
```

And here's what that would look like using the low-level bindings of this library:
```haskell
module Main where

import Qml.Raw

main :: IO ()
main = do
  qGuiApplicationCreate
  view <- qQuickViewCreate
  url <- newCString "applicaiton.qml"
  qUrl <- qUrlCreate url 0

  qQuickViewSetSourceUrl view qUrl
  qQuickViewShow view

  qGuiApplicationExec

  qUrlDelete qUrl
  qQuickViewDelete view
  qGuiApplicationDelete
```

Pretty faithful reproduction of the C API, but definitely not pleasant to use! Here's the same app with the high-level API:
```haskell
module Main where

import Qml

main :: IO ()
main = runQQuickView "applicaiton.qml"
```

Much better!
