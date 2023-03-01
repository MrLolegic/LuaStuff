--// Made by Mr. Lolegic \\--
--// Not much of a concept just showing how I think roblox works, also showing some OOP cuz why not.
-- Game class definition
local Game = {}
Game.__index = Game

function Game.new()
    local self = setmetatable({}, Game)
    self.Players = {
        LocalPlayer = {
            AccountAge = 10,
            Name = "Player 1",
            Character = {
                Humanoid = {
                    Health = 100
                }
            }
        }
    }
    self.Services = {
        Players = self.Players,
    }
    return self
end

function Game:GetService(Service)
    return self.Services[Service]
end

function Game:AddPlayer(name)
    table.insert(self.Players, {Name = name, AccountAge = 0, Character = {Humanoid = {Health = 100}}})
    print("Player " .. name .. " has joined the game!")
end

function Game:GetPlayerCount()
    return #self.Players
end

function Game:FindFirstChild(childName)
    for i, player in ipairs(self.Players) do
        if player.Name == childName then
            return player
        end
    end

    return nil
end

function Game:WaitForChild(childName)
    repeat
        local child = self:FindFirstChild(childName)
        if child then
            return child
        end
    until false
end

-- Creating an instance of the Game class
local game = Game.new()

-- Testing
print("Regular way Example: " .. game.Players.LocalPlayer.AccountAge)
print("GetService Example: " .. game:GetService("Players").LocalPlayer.AccountAge)

game:AddPlayer("Player 2")
print("Number of players: " .. game:GetPlayerCount())

local player = game:FindFirstChild("Player 2")
if player then
    print("Found player: " .. player.Name .. " with health " .. player.Character.Humanoid.Health)
else
    print("Player not found")
end

local player = game:WaitForChild("Player 2")
print("Found player: " .. player.Name .. " with health " .. player.Character.Humanoid.Health)
