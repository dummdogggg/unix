local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

repeat wait()
until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
local mouse = game.Players.LocalPlayer:GetMouse()
repeat wait() until mouse

function loadModule(url)
	return loadstring(game:HttpGet(url))()
end

local oreModule = loadModule("https://raw.githubusercontent.com/dummdogggg/The-Survival-Game/main/modules/ore-farming.lua")
local treeModule = loadModule("https://raw.githubusercontent.com/dummdogggg/The-Survival-Game/main/modules/choppable-farm.lua")
local farmModule = loadModule("https://raw.githubusercontent.com/dummdogggg/The-Survival-Game/main/modules/farming.lua")
local pickupRangeModule = loadModule("https://raw.githubusercontent.com/dummdogggg/The-Survival-Game/main/modules/increase-range.lua")






local function stopAllModules()
    oreModule.stopFarmingOre()
    treeModule.stopFarmingChoppable()
    pickupRangeModule.regularPickupRange()
    farmModule.stopTillingUnderPlayer()
end


local Character = game.Players.LocalPlayer.Character
local Humanoid = Character.Humanoid


local RUN = false
Humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
    if RUN then
        Humanoid.WalkSpeed = 15
    end
end)

local Window = Fluent:CreateWindow({
    Title = "Fluent " .. Fluent.Version,
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Main", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" })
}

local Options = Fluent.Options

do
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dummdogggg/The-Survival-Game/main/modules/fix.lua"))()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/dummdogggg/unix/main/log.lua"))()


    local Dropdown = Tabs.Main:AddDropdown("Dropdown", {
        Title = "Dropdown",
        Values = {"Iron Ore", "Copper Ore", "Coal Ore", "Stone", "Boulder", "Gold Vein", "all"},
        Multi = false,
        Default = 1,
    })

    Dropdown:SetValue("four")

    Dropdown:OnChanged(function(Value)
        print("Dropdown changed:", Value)
        oresel = Value
    end)

    Tabs.Main:AddButton({
        Title = "mine all",
        Description = "Very important button",
        Callback = function()
            print(oresel)
            RUN = true
            Humanoid.WalkSpeed = 15
            stopAllModules()
            oreModule.startFarmingOre(oresel)
        end
    })



    Tabs.Main:AddButton({
        Title = "stop mine",
        Description = "Very important button",
        Callback = function()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
            stopAllModules()
        end
    })






-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("FluentScriptHub")
SaveManager:SetFolder("FluentScriptHub/specific-game")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
    Title = "unix",
    Content = "unix has loaded",
    Duration = 8
})


-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
end

