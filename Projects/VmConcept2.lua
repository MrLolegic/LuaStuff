--// Lua 5.4.4 Vm Concept made by Mr Lolegic \\--
--// This concept was made for people who want to try and make a luau obf in luau. \\--
--// This is not a fully working virtual machine \\--
--// This is just a concept \\--

--[[

--// print("Hello, World!") | Disassembled into instructions




]]--


--// Virtual Machine Library \\--
local vm = setmetatable(
    { --// Virtual Machine Library
        opcodes = {
            [6] = "LOADK";
            [7] = "MOVE";
            [8] = "GETGLOBAL";
            [22] = "CALL";
            [23] = "RETURN";
        };
    },
    { --// Metatable
        __index = function(self, index) --// Get the index of the Virtual Machine Library
            if self[index] then --// If the index exists in the Virtual Machine Library
                return self[index] --// Return the index
            else --// If the index does not exist in the Virtual Machine Library
                error("Index '" .. index .. "' does not exist in the Virtual Machine Library") --// Throw an error
            end
        end
    }
); --/ You're probably thinking | Mr Lolegic why tf do you do this every time | Well it's just a design choice.

