#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <DOtherSide/DOtherSide.h>

int main() {
  // read file
  FILE *fp = fopen("./hello.qml", "r");
  fseek(fp, 0L, SEEK_END);

  long lSize = ftell(fp);
  rewind(fp);

  char *app = calloc(1, lSize + 1);
  fread(app, lSize, 1, fp);
  fclose(fp);

  // create app
  dos_qapplication_create();
  DosQQmlApplicationEngine *engine = dos_qqmlapplicationengine_create();
  dos_qqmlapplicationengine_load_data(engine, app);

  // run app
  dos_qapplication_exec();

  // delete down
  dos_qqmlapplicationengine_delete(engine);
  dos_qapplication_delete();
  free(app);

  return 0;
}
