local files = dtw.list_files_recursively("src",true)


for i=1,#files do 
    local current_file = files[i]
    local path = dtw.newPath(current_file)
    local name = path.get_name()
    if name == "declaration.h" then 
        dtw.remove_any(current_file )
    end 
    if name == "definition.h" then 
        dtw.remove_any(current_file )
    end
    if name =="uniq.declarations_requirement.h" then 
        dtw.remove_any(current_file )
    end
    if name == "uniq.definitions_requirements.h" then 
        dtw.remove_any(current_file )
    end
    
end