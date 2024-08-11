getgenv().Farm = true
getgenv().webhook = "https://discord.com/api/webhooks/1269871147122561108/Bg_UJma9Tg0Xzc1C6apKUzDhS3xXykoj1kDhfGm4C-ek0E4zVEkzuIZP10Vl8BMKXGp_"

-->> Config <<--
getgenv().delay = 0.8 -- works fine for 60 ping, may need to increase if you have higher ping

-->> Teleport Bypass <<--
local OldNamecallTP;
OldNamecallTP = hookmetamethod(game, '__namecall', newcclosure(function(self, ...)
    local Arguments = {...}
    local Method =  getnamecallmethod()
        
    if Method == "InvokeServer" and Arguments[1] == "idklolbrah2de" then
        return "  ___XP DE KEY"
    end
    
    return OldNamecallTP(self, ...)
end))

-->> Timestop detect & bypass <<--
getgenv().oldpos = nil -- do not change this
workspace.Living.DescendantAdded:Connect(function(a)
    if a.Name == "TimeStopping" then
        if game.Players.LocalPlayer:DistanceFromCharacter(workspace.Living[tostring(a.Parent)].HumanoidRootPart.Position) < 25 then
            oldpos = game.Players.LocalPlayer.Character.PrimaryPart.CFrame
            task.wait(0.1)
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame += Vector3.new(800,1000,500)
            task.wait(getgenv().delay)
            game.Players.LocalPlayer.Character.PrimaryPart.CFrame = oldpos
            print("hiu")
        else
            return
        end
    end
end)

local plrs = game:GetService("Players")
local plr = plrs.LocalPlayer
local BP = plr:WaitForChild("Backpack")
local PlrStats = plr:WaitForChild("PlayerStats")
local Stand = PlrStats:WaitForChild("Stand")
local vim = game:GetService("VirtualInputManager")



function SendMessage(url, message)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["content"] = message
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

function SendMessageEMBED(url, embed)
    local http = game:GetService("HttpService")
    local headers = {
        ["Content-Type"] = "application/json"
    }
    local data = {
        ["embeds"] = {
            {
                ["title"] = embed.title,
                ["description"] = embed.description,
                ["color"] = embed.color,
                ["fields"] = embed.fields,
                ["footer"] = {
                    ["text"] = embed.footer.text
                }
            }
        }
    }
    local body = http:JSONEncode(data)
    local response = request({
        Url = url,
        Method = "POST",
        Headers = headers,
        Body = body
    })
    print("Sent")
end

function StatPoints()
    local ohString1 = "LearnSkill"
    local ohTable2 = {
        ["Skill"] = "Worthiness II",
        ["SkillTreeType"] = "Character"
    }

    workspace.Living[plr.Name].RemoteFunction:InvokeServer(ohString1, ohTable2)
end

function Roka()
    local arrow = BP:FindFirstChild("Rokakaka") -- Find the tool instance
    local gui = plr.PlayerGui
    local Main = gui:WaitForChild("HUD"):WaitForChild("Main")
    local Stands = Main.Frames:WaitForChild("Stands")
    local ScrollingFrame = Stands:WaitForChild("ScrollingFrame")
    local Equipped = ScrollingFrame:WaitForChild("Equipped")

    if arrow then
        if not Equipped:FindFirstChild("Shiny") then
        plr.Character:WaitForChild("Humanoid"):EquipTool(arrow) -- Equip the tool
        arrow:Activate()
        workspace.Living[plr.Name]:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-246, 284, 308)
        task.wait(0.7)
        vim:SendMouseButtonEvent(0, 0, 0, true, game, 1) task.wait() vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        
        local PLRGUI = plr:WaitForChild("PlayerGui")
        local Option1 = PLRGUI:WaitForChild("DialogueGui"):WaitForChild("Frame"):WaitForChild("Options"):WaitForChild("Option1").TextButton

        for _,connection in pairs(getconnections(Option1.MouseButton1Click)) do
            connection:Fire()
        end
    else
        warn("Rokakaka not found in the backpack")
    end
end
end

function Arrow()
    -- Redefine variables after using Rokakaka
    BP = plr:WaitForChild("Backpack")
    local gui = plr.PlayerGui
    local Main = gui:WaitForChild("HUD"):WaitForChild("Main")
    local Stands = Main.Frames:WaitForChild("Stands")
    local ScrollingFrame = Stands:WaitForChild("ScrollingFrame")
    local Equipped = ScrollingFrame:WaitForChild("Equipped")


    local arrow = BP:FindFirstChild("Mysterious Arrow") -- Find the tool instance
    if arrow then
        if not Equipped:FindFirstChild("Shiny") then

        workspace.Living[plr.Name]:WaitForChild("Humanoid"):EquipTool(arrow) -- Equip the tool     
        arrow:Activate()
        workspace.Living[plr.Name]:WaitForChild("HumanoidRootPart").CFrame = CFrame.new(-246, 284, 308)
        task.wait(0.7)
        vim:SendMouseButtonEvent(0, 0, 0, true, game, 1) task.wait() vim:SendMouseButtonEvent(0, 0, 0, false, game, 1)
        
        local PLRGUI = plr:WaitForChild("PlayerGui")
        local Option1 = PLRGUI:WaitForChild("DialogueGui"):WaitForChild("Frame"):WaitForChild("Options"):WaitForChild("Option1").TextButton

        for _,connection in pairs(getconnections(Option1.MouseButton1Click)) do
            connection:Fire()
        end

        local PlrStats = plr:WaitForChild("PlayerStats")
        local Stand = PlrStats:WaitForChild("Stand")

        -- Wait until Stand value is not "None"
        while Stand.Value == "None" do
            task.wait(0.5)
        end

        local gui = plr.PlayerGui
        local Main = gui:WaitForChild("HUD"):WaitForChild("Main")
        local Stands = Main.Frames:WaitForChild("Stands")
        local ScrollingFrame = Stands:WaitForChild("ScrollingFrame")
        local Equipped = ScrollingFrame:WaitForChild("Equipped")

        local IsShiny
        local ShinyP

        if Equipped:FindFirstChild("Shiny") then
            IsShiny = "Shiny"
            ShinyP = "Yes"
        else
            IsShiny = "Nonshiny"
            ShinyP = "No"
        end

        -- Notification
        local embed = {
            ["title"] = "Your Bizzare Adventure - "..game.Players.LocalPlayer.DisplayName,
            ["description"] = "Stand Farm",
            ["color"] = 65280,
            ["fields"] = {
                {
                    ["name"] = "You got a Stand!",
                    ["value"] = "Stand: " .. Stand.Value .. "\n Shiny: " .. ShinyP .. "\n Skin Name: ".. Equipped:FindFirstChild("TextLabel").Text
                },
            },
            ["footer"] = {
                ["text"] = ""
            }
        }

        if ShinyP == "Yes" then
            SendMessage(getgenv().webhook, "@everyone")
            SendMessageEMBED(getgenv().webhook, embed)
        end


        -- Notification
        local Notifications = loadstring(game:HttpGet("https://raw.githubusercontent.com/tacolift/notification-library/main/library.lua"))()
        Notifications.Create("Stand", "You got a "..IsShiny.. " " .. Stand.Value, 1, Color3.fromRGB(255, 255, 255))
        task.wait(3)
        Notifications.Clear()
    else
        warn("Mysterious Arrow not found in the backpack")
    end
end
end

-- Execute Roka function
local gui = plr.PlayerGui
local Main = gui:WaitForChild("HUD"):WaitForChild("Main")
local Stands = Main.Frames:WaitForChild("Stands")
local ScrollingFrame = Stands:WaitForChild("ScrollingFrame")
local Equipped = ScrollingFrame:WaitForChild("Equipped")

while getgenv().Farm == true do
    if Equipped:FindFirstChild("Shiny") then
        break
    end
    if Stand.Value == "None" then
        StatPoints()
        task.wait(1)
        Arrow()
        if Equipped:FindFirstChild("Shiny") then
            break
        end
    else
        Roka()
        task.wait(5)
    
        -- Execute StatPoints function
        StatPoints()
    
        -- Wait a moment to ensure StatPoints completes
        task.wait(1)
    
        -- Execute Arrow function
        Arrow()
        if Equipped:FindFirstChild("Shiny") then
            break
        end
    end
    if Equipped:FindFirstChild("Shiny") then
        break
    end
end
