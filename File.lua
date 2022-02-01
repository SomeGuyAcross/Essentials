--У скрипта есть проблема, что нельзя добавить тип nil в файл. 
local File = {}

File.__index = File 

function File.new(Name,Text)  -- Создаёт новый файл с указанными аргументами.
    local self = setmetatable({},File) 
    self.Name = Name
    writefile(Name,Text or "")
    return self
end

function File.get(Name) 
    if isfile(Name) then 
        local self = setmetatable({},File)
        self.Name = Name
        return self
    end
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

--У скрипта есть проблема, что нельзя добавить тип nil в файл. 
local File = {}

File.__index = File 

function File.new(Name,Text)  -- Создаёт новый файл с указанными аргументами.
    local self = setmetatable({},File) 
    self.Name = Name
    writefile(Name,Text or "")
    return self
end

function File.get(Name) 
    if isfile(Name) then 
        local self = setmetatable({},File)
        self.Name = Name
        return self
    end
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

function File:Changed(func) -- Если текст файла изменён то исполняет функцию. (В теории может вызвать лаги из-за большого вызова функции readfile.)
    local old = readfile(self.Name) 
    local con;
    con = game:GetService("RunService").RenderStepped:Connect(function()
        local new = readfile(self.Name) 
        if old ~= new then 
            coroutine.wrap(func)(new)
            con:Disconnect()
        end
    end)
end

return File
