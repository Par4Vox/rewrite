local OldNamecallTP;
OldNamecallTP = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local Arguments = {...}
    local Method =  getnamecallmethod()
        
    if Method == "InvokeServer" and Arguments[1] == "idklolbrah2de" then
        return "  ___XP DE KEY"
    end
    
    return OldNamecallTP(self, ...)
end))


local Living = workspace:WaitForChild("Living")
Living.DescendantAdded:Connect(function(TimeStopping)
    if TimeStopping.Name ~= "TimeStopping" then return end
    
    --//Updating Variables\\--
    local LocalPlayer = game.Players.LocalPlayer
    local Character = LocalPlayer.Character
    local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    
    local OldCFrame = HumanoidRootPart.CFrame
    local TimestopOwner = TimeStopping.Parent
    local TimeStopOwnerRoot = TimestopOwner:WaitForChild("HumanoidRootPart")
    
    if TimestopOwner == LocalPlayer or LocalPlayer:DistanceFromCharacter(TimeStopOwnerRoot.Position) > 200 then return end
    
    HumanoidRootPart.CFrame = CFrame.new(0,10000,0)
    TimestopOwner:WaitForChild("TimeStopResistant")
    
    HumanoidRootPart.CFrame = OldCFrame
end)
