open! Base
module C = Configurator.V1

let strptime_l_code =
  {|
#define _GNU_SOURCE

#include <time.h>
#include <locale.h>

int main() {
  locale_t loc;
  struct tm tm;

  loc = newlocale(LC_TIME_MASK, "en_US.UTF-8", NULL);
  strptime_l("2025-12-12 14:30:00", "%Y-%m-%d %H:%M:%S", &tm, loc);
  return 0;
}
|}
;;

let () =
  C.main ~name:"core_unix_config_h" (fun c ->
    C.C_define.gen_header_file
      c
      ~fname:"core_unix_config.h"
      [ "JSC_STRPTIME_L", Switch (C.c_test c strptime_l_code) ])
;;
