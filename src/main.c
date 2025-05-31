#include "definitions.c"

CwebHttpResponse *main_sever(CwebHttpRequest *request) {
  cbrq = request;
  create_request(l);
  LuaCEmbed_evaluate(l, "serverresponse,server_status_code  = "
                 "server_callback(request_main_server)");

  if (LuaCEmbed_has_errors(l)) {
    char *error = LuaCEmbed_get_error_message(l);
    printf("%s\n", error);
    LuaCEmbed_clear_errors(l);
    return cweb_send_text("Interno server error", 500);
  }

  int status_code = 200;
  
  int status_type = LuaCEmbed_get_global_type(l, "server_status_code");

  if (status_type != LUA_CEMBED_NIL) {
    status_code = LuaCEmbed_get_global_long(l, "server_status_code");
  }

  if (LuaCEmbed_has_errors(l)) {
    char *error = LuaCEmbed_get_error_message(l);
    printf("%s\n", error);
    LuaCEmbed_clear_errors(l);

    return cweb_send_text("Interno server error", 500);
  }

  int response_type = LuaCEmbed_get_global_type(l, "serverresponse");

  if (response_type == LUA_CEMBED_STRING) {
    char *value = LuaCEmbed_get_global_string(l, "serverresponse");
    return cweb_send_text(value, status_code);
  }

  if (response_type == LUA_CEMBED_TABLE) {
    LuaCEmbedTable *table = LuaCembed_get_global_table(l, "serverresponse");

    if (its_a_component(table)) {
      TextOrError content = render_component_raw(table);
      if (content.error) {
        printf("error:%s\n", content.error->string_val);
        private_LuaCEmbedResponse_free(content.error);
        return cweb_send_text("Interno server error", 500);
      }
      return cweb_send_var_html_cleaning_memory(content.text,
                                                       status_code);
    }

    if (LuaCEmbedTable_get_type_prop(table, "response_pointer") == LUA_CEMBED_NUMBER) {
      LuaCEmbedTable_set_bool_prop(table, "its_a_reference", true);
      CwebHttpResponse *response_cb =  (CwebHttpResponse *)(serjao_ptr_cast)LuaCembedTable_get_long_prop(table,"response_pointer");
      if (LuaCEmbed_has_errors(l)) {
        char *error = LuaCEmbed_get_error_message(l);
        printf("%s\n", error);
        LuaCEmbed_clear_errors(l);

        return cweb_send_text("Interno server error", 500);
      }

      return response_cb;
    }
    cJSON *parsed = lua_fluid_json_dump_table_to_cJSON(table);
    CwebHttpResponse *response =
        cweb_send_cJSON_cleaning_memory(parsed, status_code);
    return response;
  }

  return NULL;
}

int serjao_berranteiro_start_point(lua_State *state) {
  l = newLuaCEmbedLib(state);

  calbback_main();

  commandsHTML();

  creat_table_for_config_server();

  return LuaCembed_perform(l);
}
