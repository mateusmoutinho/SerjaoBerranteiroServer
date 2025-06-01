//silver_chain_scope_start
//mannaged by silver chain: https://github.com/OUIsolutions/SilverChain
#include "../../../src/imports/imports.fdeclare.h"
//silver_chain_scope_end


LuaCEmbedResponse *initserver(LuaCEmbed *arg) {
  unsigned short initport = (unsigned short)LuaCEmbed_get_long_arg(arg, 0);
  bool its_a_number = (LUA_CEMBED_NUMBER == LuaCEmbed_get_arg_type(arg, 1));

  const unsigned short lastport =
      its_a_number ? (unsigned short)LuaCEmbed_get_long_arg(arg, 1) : initport;
  unsigned short port = initport;

  if (LuaCEmbed_has_errors(arg)) {
    return LuaCEmbed_send_error("Uninformed arguments");
  }

  const char *functionvalue = "function(value) server_callback = value end";
  LuaCEmbed_generate_arg_clojure_evalation(arg, its_a_number ? 2 : 1,
                                         functionvalue);

  if (LuaCEmbed_has_errors(arg)) {
    return LuaCEmbed_send_error("Uninformed arguments");
  }

  bool errorInit = true;
  for (unsigned short i = initport; i <= lastport; i++) {
    struct CwebServer serverTEMP = newCwebSever(i, main_sever);
    serverTEMP.function_timeout = 100;
    get_params_for_server_config(&serverTEMP);

    errorInit = CwebServer_start(&serverTEMP);
    if (errorInit) {
      continue;
    }

    port = i;
    break;
  }
  if (errorInit) {
    return LuaCEmbed_send_error("Não foi possivel usar das portas %hd a %hd.",
                                  initport, lastport);
  }
  return NULL;
}
