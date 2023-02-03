--// Made by Mr. Lolegic \\--
--// Not much of a concept just showing how I think roblox works, also showing some OOP cuz why not.

--// Game class definition
local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)

    self.Players = {
        LocalPlayer = {
            AccountAge = 10
        }
    }

    return self
end

function Game:GetService(Service)
    if Service == "Players" then
        return self.Players
    end
end

--// Creating an instance of the Game class
_G.game = Game.new()

--// Testing
print("Regular way Example: " .. game.Players.LocalPlayer.AccountAge)
print("GetService Example: " .. game:GetService("Players").LocalPlayer.AccountAge)

--// Using getfenv()
print("Getfenv Example: " .. getfenv()["game"]["Players"]["LocalPlayer"]["AccountAge"])
print("Getfenv - GetService, Example: " .. getfenv()["game"]["GetService"](getfenv()["game"], "Players")["LocalPlayer"]["AccountAge"])
