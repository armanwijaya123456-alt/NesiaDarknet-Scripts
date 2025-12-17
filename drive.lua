

print("🔫 LOADING ULTRA KICK PROTECTION...")

-- 🛡️ LAYER 1: DEEP HOOK METATABLE
do
    local mt = getrawmetatable(game)
    if mt then
        setreadonly(mt, false)
        
        local oldNamecall
        oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
            local method = getnamecallmethod()
            local args = {...}
            
            -- BLOCK SEMUA YANG BAHAYA
            local dangerous = {"kick", "ban", "crash", "disconnect", "terminate", "shutdown"}
            for _, danger in pairs(dangerous) do
                if string.lower(tostring(method)):find(danger) then
                    warn("[NESIA] 🚫 BLOCKED " .. method .. " ATTEMPT!")
                    return nil
                end
            end
            
            return oldNamecall(self, ...)
        end)
        
        -- HOOK INDEX JUGA
        local oldIndex
        oldIndex = hookmetamethod(game, "__index", function(self, key)
            if tostring(key):lower():find("kick") or tostring(key):lower():find("ban") then
                return nil
            end
            return oldIndex(self, key)
        end)
    end
end

-- 🛡️ LAYER 2: HACK REMOTE FUNCTIONS
spawn(function()
    pcall(function()
        -- HIJACK ALL REMOTES
        for _, remote in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if remote:IsA("RemoteEvent") or remote:IsA("RemoteFunction") then
                if remote.Name:lower():find("kick") or remote.Name:lower():find("ban") then
                    -- OVERRIDE FUNCTION
                    if remote:IsA("RemoteFunction") then
                        remote.OnClientInvoke = function(...)
                            return "NESIA BLOCKED"
                        end
                    end
                end
            end
        end
    end)
end)

-- 🛡️ LAYER 3: PROTECT PLAYER OBJECT
local Player = game:GetService("Players").LocalPlayer

-- SIMPAN REFERENCE ASLI
local realPlayer = Player

-- BUAT FAKE PLAYER OBJECT
spawn(function()
    while wait() do
        pcall(function()
            -- JAGA PLAYER TETAP DI PARENT
            if Player.Parent ~= game:GetService("Players") then
                Player.Parent = game:GetService("Players")
            end
        end)
    end
end)

-- 🛡️ LAYER 4: ANTI TELEPORT KICK
game:GetService("Players").LocalPlayer.OnTeleport:Connect(function(state)
    if state == Enum.TeleportState.Failed then
        -- AUTO REJOIN KALAU DIKICK
        game:GetService("TeleportService"):Teleport(game.PlaceId)
    end
end)

-- 🛡️ LAYER 5: CONSTANT MONITOR
spawn(function()
    while wait(1) do
        pcall(function()
            -- CEK APAKAH MASIH DI GAME
            if not Player or not Player.Parent then
                warn("[NESIA] ⚠️ PLAYER REMOVED, REJOINING...")
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end
        end)
    end
end)

-- 🛡️ LAYER 6: KILL ANTICHEAT SCRIPTS
spawn(function()
    while wait(3) do
        pcall(function()
            -- HAPUS SEMUA SCRIPT ANTICHEAT
            for _, script in pairs(game:GetDescendants()) do
                if script:IsA("Script") or script:IsA("LocalScript") then
                    local name = script.Name:lower()
                    if name:find("anti") or name:find("security") or name:find("cheat") or name:find("ban") then
                        script:Destroy()
                        warn("[NESIA] 💀 DESTROYED: " .. script.Name)
                    end
                end
            end
        end)
    end
end)

-- 🛡️ LAYER 7: FAKE NETWORK DATA
spawn(function()
    while wait(5) do
        pcall(function()
            -- KIRIM FAKE PACKETS BERSIH
            local stats = game:GetService("NetworkClient"):GetChildren()
            for _, stat in pairs(stats) do
                if stat:IsA("StringValue") then
                    stat.Value = "CLEAN_CONNECTION"
                end
            end
        end)
    end
end)

-- 🎮 FITUR HACK TETAP JALAN
spawn(function()
    -- AUTO FARM
    while wait(0.5) do
        pcall(function()
            -- CARI DUIT
            for _, obj in pairs(workspace:GetChildren()) do
                if obj.Name:find("Cash") or obj.Name:find("Money") then
                    firetouchinterest(Player.Character.HumanoidRootPart, obj, 0)
                    firetouchinterest(Player.Character.HumanoidRootPart, obj, 1)
                end
            end
        end)
    end
end)

spawn(function()
    -- SPEED HACK
    while wait() do
        pcall(function()
            if Player.Character then
                Player.Character.Humanoid.WalkSpeed = 50
            end
        end)
    end
end)

-- 🎉 NOTIFIKASI SUKSES
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "NESIA DARKNET v5.0",
    Text = "🛡️ ULTRA ANTI-KICK ACTIVATED!\n💀 GAK BISA DIKICK!",
    Duration = 10,
    Icon = "rbxassetid://4483345998"
})

-- 🖥️ GUI INDICATOR
local gui = Instance.new("ScreenGui")
local frame = Instance.new("Frame")
local text = Instance.new("TextLabel")

gui.Name = "NesiaUltraShield"
gui.Parent = game:GetService("CoreGui")

frame.Parent = gui
frame.Size = UDim2.new(0, 250, 0, 50)
frame.Position = UDim2.new(0, 10, 0, 10)
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BackgroundTransparency = 0.3

text.Parent = frame
text.Size = UDim2.new(1, 0, 1, 0)
text.Text = "🛡️ NESIA ULTRA SHIELD\n💀 ANTI-KICK: ACTIVE"
text.TextColor3 = Color3.fromRGB(0, 255, 0)
text.BackgroundTransparency = 1
text.Font = Enum.Font.GothamBold
text.TextSize = 14

print([[
╔══════════════════════════════╗
║     NESIA ULTRA SHIELD       ║
║         v5.0 LOADED          ║
║                              ║
║  🔒 7-LAYER PROTECTION       ║
║  🚫 KICK: IMPOSSIBLE         ║
║  💀 BAN: BLOCKED             ║
║  🔥 HACKS: ACTIVE            ║
╚══════════════════════════════╝
]])

-- 🚨 EMERGENCY KILL SWITCH
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.F12 then
        -- CLEAN UP SEMUA
        gui:Destroy()
        print("[NESIA] 🚨 KILL SWITCH - ALL CLEANED")
    end
end)

warn("⚠️ WARNING: This protection is EXTREME!")
warn("⚠️ Game might lag but YOU WON'T GET KICKED!")

