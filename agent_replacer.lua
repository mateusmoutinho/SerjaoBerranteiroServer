local files = dtw.list_files_recursively("src",true)

local replacers = {
   { item="lw.globals.get_type",target="LuaCEmbed_get_global_type"},
   {item="lw.globals.get_long",target="LuaCEmbed_get_global_long"},
   {item="lw.has_errors",target="LuaCEmbed_has_errors"},
   {item="lw.get_error_message",target="LuaCEmbed_get_error_message"},
   {item= "lw.types.NILL",target="LUA_CEMBED_NIL"},
   {item="lw.perform",target="LuaCembed_perform"},
   {item="lw.evaluate",target="LuaCEmbed_evaluate"},
   {item="lw.tables.set_string_prop",target="LuaCEmbedTable_set_string_prop"}
    {item="lw.clear_errors",target="LuaCEmbed_clear_errors"},
    {item="lw.response.send_table",target="LuaCEmbed_send_table"}
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