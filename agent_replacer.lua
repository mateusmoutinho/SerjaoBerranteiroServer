local files = dtw.list_files_recursively("src",true)

local replacers = {
   { item="lw.globals.get_type",target="LuaCEmbed_get_global_type"}
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