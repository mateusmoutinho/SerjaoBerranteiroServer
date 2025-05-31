
#include "../uniq.definitions_requirements.h"

void get_params_for_server_config(struct CwebServer *struct_server_TEMP) {
  #ifdef __linux__
  struct_server_TEMP->single_process =
      LuaCembedTable_get_bool_prop(set_server, "single_process");
    #endif
  struct_server_TEMP->allow_cors =
      LuaCembedTable_get_bool_prop(set_server, "allow_cors");
  struct_server_TEMP->use_static =
      LuaCembedTable_get_bool_prop(set_server, "use_folder");
  struct_server_TEMP->static_folder =
      LuaCembedTable_get_string_prop(set_server, "static_folder");
  struct_server_TEMP->function_timeout =
      LuaCembedTable_get_long_prop(set_server, "function_timeout");
  struct_server_TEMP->client_timeout =
      LuaCembedTable_get_long_prop(set_server, "client_timeout");
  struct_server_TEMP->max_queue =
      LuaCembedTable_get_long_prop(set_server, "max_queue");
  struct_server_TEMP->max_requests =
      LuaCembedTable_get_long_prop(set_server, "max_request");

}

void creat_table_for_config_server() {
  set_server = LuaCembed_new_global_table(serjao_lua_state, "set_server");
  LuaCEmbedTable_set_bool_prop(set_server, "single_process", false);
  LuaCEmbedTable_set_bool_prop(set_server, "allow_cors", true);
  LuaCEmbedTable_set_bool_prop(set_server, "use_folder", true);
  LuaCEmbedTable_set_string_prop(set_server, "static_folder", "static");
  LuaCEmbedTable_set_long_prop(set_server, "function_timeout", 30);
  LuaCEmbedTable_set_long_prop(set_server, "client_timeout", 5);
  LuaCEmbedTable_set_long_prop(set_server, "max_queue", 100);
  LuaCEmbedTable_set_long_prop(set_server, "max_request", 1000);
  LuaCEmbedTable_set_string_prop(set_server, "nullterminator", "NULL");
}
