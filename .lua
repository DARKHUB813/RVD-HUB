local Window = Rayfield:CreateWindow({
   Name = "RVD HUB",
   Icon = 0, 
   LoadingTitle = "RVD HUB",
   LoadingSubtitle = "",
   Theme = "Default",
   DisableRayfieldPrompts = false,
   DisableBuildWarnings = false, 

   ConfigurationSaving = {
      Enabled = true,
      FolderName = nil, -- Create a custom folder for your hub/game
      FileName = "Big Hub"
   },

   Discord = {
      Enabled = true, 
      Invite = "https://discord.gg/UgNE3qsa2C", 
      RememberJoins = true

   KeySystem = false,
   KeySettings = {
      Title = "Untitled",
      Subtitle = "Key System",
      Note = "No method of obtaining the key is provided", -- Use this to tell the user how to get a key
      FileName = "Key", 
      SaveKey = true, 
      GrabKeyFromSite = false,
      Key = {"Hello"} 
   }
})

Rayfield:Notify({
   Title = "RVD HUB EXECUTADO",
   Content = "RVD HUB EXECTADO",
   Duration = 6.5,
   Image = 4483362458,
})

if not isfolder("BloxFruits") then makefolder("BloxFruits") end
local ConfigFile = "BloxFruits/config.json"
local HttpService = game:GetService("HttpService")

local defaultConfig = {
    AutoFarm = true,
    AutoQuest = true,
    AutoBoss = true,
    AutoHaki = true,
    SafeMode = true,
    ShowESP = true,
    AutoAwakening = true,
    AutoFruit = true,
    AutoRaceV4 = true,
    AutoStoreFruit = true,
    AutoUpdate = true,
    AutoStatus = true,
    AutoBuyHaki = true,
    AutoBuySwords = true,
    EnableWebhook = false,
    FPSBoost = true,
    AutoFarmLevel = true,
    AutoSkill = true,
    AutoChest = true,
    AutoEquipHaki = true,
    AutoJoinCrew = false,
    AutoDefenseMode = false,
    AutoKillPlayer = false,
    AutoJoinRaid = false,
    AutoObservation = false,
    AutoMeleeFarm = false,
    AntiAfk = true,
    AutoBuyFightingStyles = true,
    AutoSaberBoss = true,
    AutoEliteHunters = true,
    AutoSeaEvents = true,
    ServerHop = true,
    AutoFarmMaterials = true,
    AutoAccessoryEquip = true,
    AutoTradeFruits = true,
    TeleportGUI = true
}

function SaveConfig()
    writefile(ConfigFile, HttpService:JSONEncode(_G.Config))
end

function LoadConfig()
    if isfile(ConfigFile) then
        local data = readfile(ConfigFile)
        _G.Config = HttpService:JSONDecode(data)
    else
        _G.Config = defaultConfig
        SaveConfig()
    end
end

LoadConfig()

spawn(function()
    while wait(3) do
        if _G.Config.AutoEquipHaki then
            game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
        end
    end
end)

spawn(function()
    while wait(2) do
        if _G.Config.AutoSkill then
            for _, v in pairs({"Z", "X", "C", "V"}) do
                local vim = game:GetService("VirtualInputManager")
                vim:SendKeyEvent(true, v, false, game)
                wait(0.2)
                vim:SendKeyEvent(false, v, false, game)
            end
        end
    end
end)

spawn(function()
    while wait(10) do
        if _G.Config.AutoChest then
            for _, chest in pairs(workspace:GetDescendants()) do
                if chest:IsA("Model") and chest.Name:lower():find("chest") then
                    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = chest.PrimaryPart.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5)
                end
            end
        end
    end
end)

spawn(function()
    if _G.Config.AntiAfk then
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:connect(function()
            vu:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
            wait(1)
            vu:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
        end)
    end
end)

local extras = {
    {"Farm Level", "AutoFarmLevel"},
    {"Skill Z/X/C/V", "AutoSkill"},
    {"Pegar Baús", "AutoChest"},
    {"Ativar Haki", "AutoEquipHaki"},
    {"Entrar Crew", "AutoJoinCrew"},
    {"Modo Defesa", "AutoDefenseMode"},
    {"Auto PvP", "AutoKillPlayer"},
    {"Auto Join Raid", "AutoJoinRaid"},
    {"Obs. Haki", "AutoObservation"},
    {"Farm Corpo a Corpo", "AutoMeleeFarm"},
    {"Anti AFK", "AntiAfk"},
    {"Comprar Fighting Styles", "AutoBuyFightingStyles"},
    {"Saber Boss", "AutoSaberBoss"},
    {"Elite Hunters", "AutoEliteHunters"},
    {"Eventos no Mar", "AutoSeaEvents"},
    {"Server Hop", "ServerHop"},
    {"Farm Materiais", "AutoFarmMaterials"},
    {"Equipar Acessórios", "AutoAccessoryEquip"},
    {"Trocar Frutas", "AutoTradeFruits"},
    {"Teleport GUI", "TeleportGUI"}
}

for i, opt in ipairs(extras) do
    CreateToggle(opt[1], opt[2], (#options + i - 1) * 30)
end
