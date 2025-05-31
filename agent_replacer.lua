local files = dtw.list_files_recursively("src",true)

local replacers = {
   { item="lw.globals.get_type",target="LuaCEmbed_get_global_type"},
   {item="lw.globals.get_long",target="LuaCEmbed_get_global_long"},
   {item="lw.has_errors",target="LuaCEmbed_has_errors"},
   {item="lw.get_error_message",target="LuaCEmbed_get_error_message"},
   {item= "lw.types.NILL",target="LUA_CEMBED_NIL"},
   {item="lw.types.TABLE",target="LUA_CEMBED_TABLE"},
   {item="lw.types.BOOL",target="LUA_CEMBED_BOOL"},
   {item="lw.types.FUNCTION",target="LUA_CEMBED_FUNCTION"},
    {item="lw.args.size",target="LuaCEmbed_get_args_size"},
    {item="lw.types.NUMBER",target="LUA_CEMBED_NUMBER"},
   {item="lw.perform",target="LuaCembed_perform"},
   {item="lw.evaluate",target="LuaCEmbed_evaluate"},
   {item="lw.tables.set_string_prop",target="LuaCEmbedTable_set_string_prop"},
    {item="lw.clear_errors",target="LuaCEmbed_clear_errors"},
    {item="lw.response.send_table",target="LuaCEmbed_send_table"},
    {item="lw.add_callback",target="LuaCEmbed_add_callback"},
    {item="lw.types.STRING",target="LUA_CEMBED_STRING"},
    {item="lw.args.get_type",target="LuaCEmbed_get_arg_type"},
    {item="lw.args.get_str",target="LuaCEmbed_get_str_arg"},
    {item="lw.tables.get_size",target="LuaCEmbedTable_get_full_size"},
    {item="lw.tables.get_bool_prop",target="LuaCembedTable_get_bool_prop"},
    {item="lw.args.get_long",target="LuaCEmbed_get_long_arg"},
    {item="lw.args.get_table",target="LuaCEmbed_get_arg_table"},
    {item="lw.args.get_double",target="LuaCEmbed_get_double_arg"},

    {item="lw.tables.new_anonymous_table",target="LuaCembed_new_anonymous_table"},
    {item="lw.globals.new_table",target="LuaCembed_new_global_table"},
    {item="lw.globals.get_table",target="LuaCembed_get_global_table"},
    {item="lw.response.send_error",target="LuaCEmbed_send_error"},
    {item="lw.add_global_callback",target="LuaCEmbed_add_global_callback"},
    {item="lw.tables.get_sub_table_prop",target="LuaCEmbedTable_get_sub_table_by_key"},
    {item="lw.tables.set_string_prop",target="LuaCEmbedTable_set_string_prop"},
    {item="lw.globals.get_string",target="LuaCEmbed_get_global_string"},
    {item="lw.tables.get_type_by_index",target="LuaCEmbedTable_get_type_by_index"},
    {item="lw.tables.has_key",target="LuaCembedTable_has_key_at_index"},
    {item="lw.tables.set_long_prop",target="LuaCEmbedTable_set_long_prop"},
    {item="lw.tables.get_type_prop",target="LuaCEmbedTable_get_type_prop"},

    {item="lw.args.generate_arg_clojure_evalation",target="LuaCEmbed_generate_arg_clojure_evalation"},
    {item="lw.tables.get_string_prop",target="LuaCembedTable_get_string_prop"},
    {item="lw.tables.set_bool_prop", target="LuaCEmbedTable_set_bool_prop"},
    {item="lw.tables.get_string_prop",target="LuaCEmbedTable_get_string_prop"},
    {item="lw.response.send_str",target="LuaCEmbed_send_str"},
    {item="lw.tables.set_method", target="LuaCEmbedTable_set_method"},
    {item="lw.tables.get_key_by_index", target="LuaCembedTable_get_key_by_index"},
    {item="lw.tables.get_sub_table_by_index", target="LuaCEmbedTable_get_sub_table_by_index"},
    {item="lw.tables.append_double", target="LuaCEmbedTable_append_double"},
    {item="lw.response.send_raw_string", target="LuaCEmbed_send_raw_string"},
    {item="lw.args.get_raw_str", target="LuaCEmbed_get_raw_str_arg"},
    {item="lw.tables.get_double_by_index", target="LuaCEmbedTable_get_double_by_index"},
    {item="lw.response.send_bool", target="LuaCEmbed_send_bool"},
    {item="lw.args.get_bool", target="LuaCEmbed_get_bool_arg"},
    {item="lw.tables.get_string_by_index", target="LuaCEmbedTable_get_string_by_index"},
    {item="lw.tables.get_long_prop", target="LuaCembedTable_get_long_prop"},
    {item="lw.globals.get_raw_string", target="LuaCEmbed_get_global_raw_string"},
    {item="lw.tables.append_string",target="LuaCEmbedTable_append_string"},
    {item="lw.tables.set_sub_table_prop", target="LuaCEmbedTable_set_sub_table_prop"}
    {item="lw.tables.get_bool_by_index", target="LuaCEmbedTable_get_bool_by_index"},
}


for i=1,#files do 
    local current_file = files[i]
    local content = dtw.load_file(current_file)

    for _, replacer in ipairs(replacers) do
        content = content:gsub(replacer.item, replacer.target)
    end
    dtw.write_file(current_file, content)
    print("Replaced in file: " .. current_file)
end