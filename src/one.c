#include "definitions.c"

CwebHttpResponse *main_sever(CwebHttpRequest *request) {
  serjao_cweb_global_requiest = request;
  create_request(serjao_lua_state);
  LuaCEmbed_evaluate(serjao_lua_state, "serverresponse,server_status_code  = "
                 "server_callback(request_main_server)");

  if (LuaCEmbed_has_errors(serjao_lua_state)) {
    char *error = LuaCEmbed_get_error_message(serjao_lua_state);
    printf("%s\n", error);
    LuaCEmbed_clear_errors(serjao_lua_state);
    return cweb_send_text("Interno server error", 500);
  }

  int status_code = 200;
  
  int status_type = LuaCEmbed_get_global_type(serjao_lua_state, "server_status_code");

  if (status_type != LUA_CEMBED_NIL) {
    status_code = LuaCEmbed_get_global_long(serjao_lua_state, "server_status_code");
  }

  if (LuaCEmbed_has_errors(serjao_lua_state)) {
    char *error = LuaCEmbed_get_error_message(serjao_lua_state);
    printf("%s\n", error);
    LuaCEmbed_clear_errors(serjao_lua_state);

    return cweb_send_text("Interno server error", 500);
  }

  int response_type = LuaCEmbed_get_global_type(serjao_lua_state, "serverresponse");

  if (response_type == LUA_CEMBED_STRING) {
    char *value = LuaCEmbed_get_global_string(serjao_lua_state, "serverresponse");
    return cweb_send_text(value, status_code);
  }

  if (response_type == LUA_CEMBED_TABLE) {
    LuaCEmbedTable *table = LuaCembed_get_global_table(serjao_lua_state, "serverresponse");

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
      if (LuaCEmbed_has_errors(serjao_lua_state)) {
        char *error = LuaCEmbed_get_error_message(serjao_lua_state);
        printf("%s\n", error);
        LuaCEmbed_clear_errors(serjao_lua_state);

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
  serjao_lua_state = newLuaCEmbedLib(state);

  calbback_main();

  commandsHTML();

  creat_table_for_config_server();

  return LuaCembed_perform(serjao_lua_state);
}
