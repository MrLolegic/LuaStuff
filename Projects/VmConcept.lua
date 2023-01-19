--// VM concept made by Mr Lolegic \\--
--// This is a concept for a virtual machine that I am working on \\--
--// This is not a fully working virtual machine \\--
--// This is just a concept \\--
--// whitespace
---// Virtual Machine Library \\---
local vm = setmetatable( --// Set the metatable of the Virtual Machine Library
    { --// Virtual Machine Library
        opcodes = { --// Opcodes
            [0] = "MOVE",       --// Move a value from one register to another
            [1] = "LOADK",      --// Load a constant value into a register
            [5] = "GETGLOBAL",  --// Get a global value into a register
            [28] = "CALL",      --// Call a function
            [30] = "RETURN"     --// Return a value
        },
        environment = getfenv() --// Get a funcs env
    },
    { --// Metatable
        __index = function(self, index) --// Get the index of the Virtual Machine Library
            if self[index] then --// If the index exists in the Virtual Machine Library
                return self[index] --// Return the index
            else --// If the index does not exist in the Virtual Machine Library
                error("Index '" .. index .. "' does not exist in the Virtual Machine Library") --// Throw an error
            end --// end if condition
        end --// end function
    } --// close table
) --// parentheses 
vm.program = { --// Program
    [0] = { --// Instruction 1
        opcode = vm.opcodes[5], --// GETGLOBAL
        reg_a = 0, --// Load the global value into register A
        reg_b = 1, --// Load the global value into register B
        global_name = "print" --// The name of the global variable to retrieve
    }, --// close table
    [1] = { --// Instruction 2
        opcode = vm.opcodes[1], --// LOADK
        reg_a = 1, --// Load the constant value into register A
        reg_b = 2, --// Load the constant value into register B
        constant = "Hello, World!" --// The constant value to push onto the stack
    }, --// close table
    [2] = { --// Instruction 3
        opcode = vm.opcodes[28], --// CALL
        reg_a = 0, --// Call the function in register A
        num_args = 2, --// Call the function with 2 arguments
        num_returns = 1 --// Return 1 result
    }, --// close table
    [3] = { --// Instruction 4
        opcode = vm.opcodes[30], --// RETURN
        num_returns = 1 --// Return 1 value
    } --// close table
} --// close table
local function pack(...) --// Pack the arguments into a table
    return { --// Return the table
        n = select("#", ...), --// Get the number of arguments
        ... --// Return the arguments
    } --// close table
end --// end function
--// whitespace
function vm:interpret() --// Interpret the program
    local pc = 0 --// Program Counter
    local top = -1 --// Top of the stack
    local stack = {} --// Stack
    local env = self.environment --// Environment
    while true do --// start a while loop
        --// @Local: inst - The current instruction
        pc = pc + 1 --// Increment the program counter
        local inst = self.program[pc - 1] --// Get the current instruction
        if inst.opcode == "LOADK" then --// If op LOADK
            stack[inst.reg_a] = inst.constant --// Push the constant onto the stack
        elseif inst.opcode == "GETGLOBAL" then --// If op GETGLOBAL
            stack[inst.reg_a] = env[inst.global_name] --// Push the global onto the stack
        elseif inst.opcode == "CALL" then --// If op CALL
            --// @Local: num_params - The number of parameters
            --// @Local: num_ret - The number of returns
            local num_params = inst.num_args > 0 and inst.num_args - 1 or top - inst.reg_a --// Get the number of parameters
            local num_ret = pack(stack[inst.reg_a](unpack(stack, inst.reg_a + 1, inst.reg_a + num_params))) --// Call the function and get the number of returns
            if inst.num_returns > 0 then --// If the number of returns is greater than 0
                num_ret = inst.num_returns - 1 --// Get the number of returns
            else --// If the number of returns is not greater than 0
                top = inst.reg_a + num_ret - 1 --// Set the top of the stack
            end --// end
        elseif inst.opcode == "RETURN" then --// If op RETURN
            return unpack(stack, 1, inst.num_returns) --// Return the values on the stack
        end --// end if
    end --// end while
end --// end func
--// whitespace
vm:interpret() --// Interpret the program
--// whitespace
--[[

--// Simple explanation on how the vm actually works \\--

The VM is a tool that allows you to execute a specific set of instructions, called "opcodes", to perform a task or solve a problem. These "opcodes" are defined in a "vm.opcodes" table and represent different operations that the VM can execute, such as loading a constant value onto the stack or calling a function.

The "vm.program" table stores a series of instructions that the VM will execute. Each instruction is represented by a table with fields that correspond to the arguments of the respective "opcode". For example, the "LOADK" opcode has three arguments: "reg_a", "reg_b", and "constant", which represent the registers to load the constant value into and the constant value to push onto the stack, respectively.

Registers are temporary storage locations within the VM that are used to store values during execution. The VM has a set of registers that are used to store values that are used by the "opcodes".

During execution, the VM maintains a "stack" table to store the values that are used by the "opcodes". The "vm:interpret()" function executes the instructions in the "vm.program" table, using a "pc" (program counter) variable to keep track of the current instruction being executed and a "top" variable to store the top of the stack.

The "environment" table stores global variables that are accessible to the VM. The "pack()" and "unpack()" functions allow you to pack and unpack values from tables, respectively.


]]--
