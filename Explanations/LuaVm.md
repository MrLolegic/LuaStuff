
# Lua Virtual Machine (VM) | Explanation
## Introduction

Think of the Lua 5.1 virtual machine (VM) as a machine that processes instructions to execute Lua code. At its core is a stack, a structure that stores and manipulates data in a Last In, First Out (LIFO) manner - like a deck of cards, with the last card dealt being the first one to be drawn. The stack is made up of slots that can hold a single value, like a hand that can hold a single card. These values can be any of the basic types in Lua, such as numbers, strings, and booleans, as well as more complex types like tables and functions.

## Instructions
Instructions are like recipes that tell the VM what to do. They are represented as integers and stored in a contiguous block of memory known as the instruction stream. Each instruction is made up of an opcode, a single byte that specifies the operation to be performed, and zero or more operands, additional bytes that provide extra information needed for the operation. For instance, the LOADK instruction loads a constant value onto the stack - it's like a chef retrieving a specific ingredient from the pantry. The opcode is like the recipe's title, and the operand is like the ingredient's name.

### Execution
The VM executes instructions one at a time, like a person following a recipe step by step. It retrieves the next instruction from the stream, decodes it to understand the operation, and performs the operation. Some operations are simple, like LOADK and ADD, which only manipulate the stack and don't have any other effects. Others are more complex, like CALL and RETURN, which invoke functions and alter the call stack - think of these as calling on a sous chef to help with a task, or sending them back to their station once the task is complete. Still others, like JMP and TEST, alter the flow of control by jumping to a different instruction or branching based on a condition - these are like taking a detour or making a choice while following a recipe.

### Closures
The VM also supports closures, which are values that represent a function and its lexical environment. These are like a chef's secret recipe, complete with a list of ingredients (the function prototype) and a set of specialized tools (the upvalues) needed to make the dish. When a closure is called, the VM creates a new activation record, a stack frame that stores the function's local variables and arguments, like a new cutting board for a specific task. It then executes the function's code, using the upvalues as needed, like a chef using their specialized tools. When the function returns, the VM removes the activation record from the call stack and returns control to the calling function - like a chef cleaning up their station and returning to their duties.

### Garbage Collector
Finally, the VM uses a garbage collector to manage the memory used by the interpreter. Imagine this as a janitor that periodically sweeps through the heap, a block of memory that stores Lua values, and removes any trash - values that are no longer being used. The garbage collector uses a combination of mark-and-sweep and incremental techniques to minimize the impact on the interpreter's performance, and it supports weak references, which allow values to be garbage collected even if they are still referenced by other values.

## Conclusion
In conclusion, the Lua 5.1 virtual machine is a powerful tool that executes Lua code by processing instructions and manipulating a stack of values. It supports a wide range of data types and operations, and uses a garbage collector to manage memory efficiently. Understanding how the VM works can help you write more efficient and effective Lua code, and can also give you a deeper appreciation for the inner workings of the language. "Remember, a good chef knows their tools inside and out, and the same is true for a good programmer!"

## References
* [Lua 5.1 Reference Manual](https://www.lua.org/manual/5.1/manual.html)
* ["Programming in Lua" by Roberto Ierusalimschy](https://www.lua.org/pil/)
* [A No-Frills Introduction to Lua 5.1 VM Instructions | PDF](http://underpop.free.fr/l/lua/docs/a-no-frills-introduction-to-lua-5.1-vm-instructions.pdf)

## License
This work is licensed under a GNU Free Documentation License 1.3. To view a copy of this license, visit [https://www.gnu.org/licenses/fdl-1.3.html](https://www.gnu.org/licenses/fdl-1.3.html) or send a letter to Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.

## Contact
Discord: Mr Lolegic#0773 \
We are Devs: [Mr Lolegic](https://wearedevs.net/profile?uid=85021) \
Discord Server: [Logistical Studio's](https://discord.gg/8RHfwxseDa) \
Discord Server 2: [Jupiter](https://discord.gg/ZpAmSKuxgs)

## by Mr Lolegic