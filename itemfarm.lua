local function findItem(itemName)
    local ItemsDict = {
        ["Position"] = {},
        ["ProximityPrompt"] = {},
        ["Items"] = {}
    }

    for _,item in pairs(game:GetService("Workspace")["Item_Spawns"].Items:GetChildren()) do
        if item:FindFirstChild("MeshPart") and item.ProximityPrompt.ObjectText == itemName then
            if item.ProximityPrompt.MaxActivationDistance == 8 then
                table.insert(ItemsDict["Items"], item.ProximityPrompt.ObjectText)
                table.insert(ItemsDict["ProximityPrompt"], item.ProximityPrompt)
                table.insert(ItemsDict["Position"], item.MeshPart.CFrame)
            else
                print("FAKE?")
            end
        end
    end
    return ItemsDict
end

--count amount of items for checking if full of item
local function countItems(itemName)
    local itemAmount = 0

    for _,item in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if item.Name == itemName then
            itemAmount += 1;
        end
    end

    print(itemAmount)
    return itemAmount
end

--teleport not to get caught
local function getitem(item, itemIndex)
    local gotItem = false
    local timeout = getgenv().waitUntilCollect + 5

    if Character:FindFirstChild("SummonedStand") then
        if Character:FindFirstChild("SummonedStand").Value then
            RemoteFunction:InvokeServer("ToggleStand", "Toggle")
        end
    end

    LocalPlayer.Backpack.ChildAdded:Connect(function()
        gotItem = true
    end)
    
    task.spawn(function()
        while not gotItem do
            task.wait()
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = item["Position"][itemIndex] - Vector3.new(0,10,0)
        end
    end)

    task.wait(getgenv().waitUntilCollect)

    task.spawn(function()
        fireproximityprompt(item["ProximityPrompt"][itemIndex])
        
        local screenGui = LocalPlayer.PlayerGui:WaitForChild("ScreenGui",5)
        
        if not screenGui then
            return
        end

        local screenGuiPart = screenGui:WaitForChild("Part")
        for _, button in pairs(screenGuiPart:GetDescendants()) do
            if button:FindFirstChild("Part") then
                if button:IsA("ImageButton") and button:WaitForChild("Part").TextColor3 == Color3.new(0, 1, 0) then
                    repeat
                        firesignal(button.MouseEnter)
                        firesignal(button.MouseButton1Up)
                        firesignal(button.MouseButton1Click)
                        firesignal(button.Activated)
                        task.wait()
                    until not LocalPlayer.PlayerGui:FindFirstChild("ScreenGui")
                end
            end
        end
    end)
    
    task.spawn(function()
        for i=timeout, 1, -1 do
            task.wait(1)
        end

        if not gotItem then
            gotItem = true
            return
        end
    end)


    while not gotItem do
        task.wait()
    end
end

local function farmItem(itemName, amount)
    local items = findItem(itemName)
    local amountFirst = countItems(itemName) == amount

    for itemIndex, _ in pairs(items["Position"]) do
        if countItems(itemName) == amount or amountFirst then
            print("SUCCESSFULLY BROKE")
            break
        else
            getitem(items, itemIndex)
        end
    end
    
    return true
end
