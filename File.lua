--У скрипта есть проблема, что нельзя добавить тип nil в файл. 
local File = {}

File.__index = File 

function File.new(Name,Text)  -- Создаёт новый файл с указанными аргументами, а если уже создан файл то перезаписывает его.
    local self = setmetatable({},File) 
    local self = setmetatable({},File) 
    self.Name = Name
    writefile(Name,Text or "")
    return self
end

function File:Exists() -- Проверяет существует ли файл.
    return isfile(self.Name)
end

function File:Read() -- Возращает текст файла.
    return readfile(self.Name) 
end

function File:Rewrite(Text) -- Перезаписывает  файл.
    if isfile(self.Name) then 
        writefile(self.Name,Text)
    end
end

function File:Append(...) -- Добавляет в файл указанные аргументы. 
    local String = ""
    for _,Arguement in pairs({...}) do 
        String = String..tostring(Arguement).." "
    end 
    appendfile(self.Name,String)
end 

function File:Load() -- Воспроизводит луа код в файле если он есть.
    loadfile(self.Name)()
end

function File:Delete() -- Удаляет файл.
    delfile(self.Name)
    self = nil
end 

return File
