
#include "../uniq.definitions_requirements.h"

void calbback_main() {
  LuaCEmbed_add_callback(l, "server", initserver);
  LuaCEmbed_add_callback(l, "desktop", initdesktop);
  LuaCEmbed_add_callback(l, "send_file", send_file);
  LuaCEmbed_add_callback(l, "send_html", send_HTML);
  LuaCEmbed_add_callback(l, "send_json_string", send_json_string);
  LuaCEmbed_add_callback(l, "send_json", send_json);
  LuaCEmbed_add_callback(l, "send_raw", send_raw);
  LuaCEmbed_add_callback(l, "send_text", send_text);
  LuaCEmbed_add_callback(l, "component", create_component);
  LuaCEmbed_add_callback(l, "fragment", create_fragment);
  LuaCEmbed_add_callback(l, "kill", kill_server);
}
