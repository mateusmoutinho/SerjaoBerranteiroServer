local files = dtw.list_files_recursively("src",true)

local replacers = {
   { item="lw.globals.get_type",target="LuaCEmbed_get_global_type"},
   {item="lw.globals.get_long",target="LuaCEmbed_get_global_long"},
   {item="lw.has_errors",target="LuaCEmbed_has_errors"},
   {item="lw.get_error_message",target="LuaCEmbed_get_error_message"},
   {item= "lw.types.NILL",target="LUA_CEMBED_NIL"},
   {item="lw.types.TABLE",target="LUA_CEMBED_TABLE"},
   {item="lw.types.BOOLEAN",target="LUA_CEMBED_BOOL"},
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
    {item="lw.args.get_table",target="LuaCEmbed_get_table_arg"},
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
    {item="lw.tables.has_key",target="LuaCEmbedTable_has_key"},
    {item="lw.tables.set_long_prop",target="LuaCEmbedTable_set_long_prop"},
    {item="lw.tables.get_type_prop",target="LuaCEmbedTable_get_type_prop"},
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