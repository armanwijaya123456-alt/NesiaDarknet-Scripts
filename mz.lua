
local Executor = "Delta 2.701"
local Player = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")

-- SIMPLE LOG
print("======================================")
print("NESIA DARKNET LOADING FOR "..Executor)
print("======================================")

-- BASIC PROTECTION
local OldNamecall
OldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
    local Method = getnamecallmethod()
    if Method:lower():find("kick") or Method:lower():find("ban") then
        return nil
    end
    return OldNamecall(self, ...)
end)

-- FEATURE 1: AUTO COLLECT MONEY
task.spawn(function()
    while task.wait(0.5) do
        pcall(function()
            -- COLLECT CASH OBJECTS
            for _, Obj in pairs(workspace:GetDescendants()) do
                if Obj:IsA("Part") and (Obj.Name:find("Cash") or Obj.Name:find("Money") or Obj.Name:find("Coin")) then
                    if Player.Character and Player.Character:FindFirstChild("HumanoidRootPart") then
                        Player.Character.HumanoidRootPart.CFrame = Obj.CFrame
                    end
                end
            end
            
            -- AUTO CLAIM FROM REMOTES
            for _, Remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if Remote:IsA("RemoteEvent") and Remote.Name:find("Reward") then
                    Remote:FireServer("Claim", 10000)
                end
            end
        end)
    end
end)

-- FEATURE 2: VEHICLE SPEED HACK
task.spawn(function()
    while task.wait(0.1) do
        pcall(function()
            if Player.Character then
                local Vehicle = Player.Character:FindFirstChild("VehicleSeat") or 
                              Player.Character:FindFirstChild("Motor") or
                              Player.Character:FindFirstChildWhichIsA("Model")
                
                if Vehicle then
                    -- SPEED MULTIPLIER
                    local CurrentVel = Vehicle.Velocity
                    Vehicle.Velocity = Vector3.new(CurrentVel.X * 6, CurrentVel.Y, CurrentVel.Z * 6)
                    
                    -- UNLIMITED NITRO
                    local Nitro = Vehicle:FindFirstChild("Nitro") or Vehicle:FindFirstChild("Boost")
                    if Nitro then
                        Nitro.Value = 100
                    end
                    
                    -- NO GRAVITY
                    local BodyForce = Instance.new("BodyForce")
                    BodyForce.Force = Vector3.new(0, 196.2, 0)
                    BodyForce.Parent = Vehicle
                    task.delay(0.5, function() BodyForce:Destroy() end)
                end
            end
        end)
    end
end)

-- FEATURE 3: AUTO CLAIM LIMITED ITEMS
task.spawn(function()
    while task.wait(2) do
        pcall(function()
            -- TRY DIFFERENT METHODS
            local Methods = {
                function() game:GetService("ReplicatedStorage").Remotes.ClaimLimited:FireServer() end,
                function() game:GetService("ReplicatedStorage").Events.GetLimited:FireServer() end,
                function() game:GetService("ReplicatedStorage").Functions.GetItem:InvokeServer("Limited", 1) end
            }
            
            for _, Method in pairs(Methods) do
                pcall(Method)
            end
        end)
    end
end)

-- FEATURE 4: SIMPLE GUI
task.spawn(function()
    local GUI = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local Text = Instance.new("TextLabel")
    
    GUI.Name = "NesiaDarknetGUI"
    GUI.Parent = game:GetService("CoreGui")
    
    Frame.Size = UDim2.new(0, 250, 0, 40)
    Frame.Position = UDim2.new(0.5, -125, 0, 10)
    Frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Frame.BackgroundTransparency = 0.5
    Frame.Parent = GUI
    
    Text.Size = UDim2.new(1, 0, 1, 0)
    Text.Text = "🔥 NESIA DARKNET AKTIF | DELTA 2.701"
    Text.TextColor3 = Color3.fromRGB(255, 0, 0)
    Text.BackgroundTransparency = 1
    Text.Font = Enum.Font.GothamBold
    Text.Parent = Frame
end)

-- SUCCESS NOTIFICATION
task.spawn(function()
    wait(1)
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "NESIA DARKNET",
        Text = "SCRIPT LOADED! 😈",
        Icon = "rbxassetid://4483345998",
        Duration = 5
    })
end)

-- FINAL MESSAGE
print("🔥 NESIA DARKNET BERHASIL DIEKSEKUSI!")
print("✅ Auto Money: AKTIF")
print("✅ Speed Hack: AKTIF")
print("✅ Limited Claim: AKTIF")
print("✅ Delta 2.701: COMPATIBLE")
print("======================================")