#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <DOtherSide/DOtherSide.h>

int main() {
  // create app
  dos_qguiapplication_create();
  DosQQuickView *view = dos_qquickview_create();
  DosQUrl *url = dos_qurl_create("application.qml", 1);

  dos_qquickview_set_source_url(view, url);
  dos_qquickview_show(view);

  // run app
  dos_qguiapplication_exec();

  // delete app
  dos_qurl_delete(url);
  dos_qquickview_delete(view);
  dos_qguiapplication_delete();

  return 0;
}
