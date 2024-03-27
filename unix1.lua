if not _G.hackexecuted then
    _G.hackexecuted=true
local HWIDs = loadstring(game:HttpGet("https://raw.githubusercontent.com/dummdogggg/unix/main/hwid.txt"))()

local http_request = (syn and syn.request) or http_request or request or httprequest or httpRequest or Request;
local body = http_request({Url = 'https://httpbin.org/get'; Method = 'GET'}).Body;
local decoded = game:GetService('HttpService'):JSONDecode(body)
local headers = decoded.headers
local hwid;

for i,v in pairs(headers) do
    if type(i)=="string" and i:lower():match("fingerprint") then hwid = v end
end
if not hwid then game.Players.LocalPlayer:Kick("Khong check duoc whitelist") return end
if table.find(HWIDs, hwid) then
print"FearlessCheat v1.1"
print(hwid)


spawn(function() --begin
                   if settings["FastTools"] then
for i, v in next, getgc(game) do
if typeof(v) == "function" then
for i1, v1 in next, debug.getupvalues(v) do
if typeof(v1) == "table" then
if rawget(v1, "actionTime") then
rawset(v1, "actionTime", 0.1)
end
end
end
end
end
                   end
                        

if game.Players.LocalPlayer.Character:FindFirstChild("stamina") then
game.Players.LocalPlayer.Character.stamina:Remove()
end
if game.Players.LocalPlayer.Character:FindFirstChild("fallDamage") then
game.Players.LocalPlayer.Character.fallDamage:Remove()
end

local Meta = getrawmetatable(game);
setreadonly(Meta, false);

local RealIndex = Meta.__index;
Meta.__index = function(self, Key)
   if (Key == "WalkSpeed") and not checkcaller() then
       return 16;
   end;
   return RealIndex(self, Key);
end;
setreadonly(Meta, true);
local function walkspeedget(speed)
local plusnum = {
["Ate_Spicy_Food"] = speed/24,
["Well_Rested"] = speed/12,
["Pooped"] = speed/12
}
for i, v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.Main.effects:GetChildren()) do
if v:FindFirstChild("ImageButton") and v.ImageButton.BackgroundTransparency ~= 1 and plusnum[tostring(v)] then
speed = speed + plusnum[tostring(v)]
end
end
return speed
end
game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(v)
if v == "WalkSpeed" and settings["SpeedHack"] == true then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedget(38)
end
end)
              if settings["SpeedHack"] == true then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedget(38)
              end

local UIS = game:GetService("UserInputService")
UIS.InputBegan:Connect(function(input)
if UIS:IsKeyDown(Enum.KeyCode.Space) and game.Players.LocalPlayer.Character:FindFirstChild("Humanoid") and settings["InfiniteJump"] then
game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
end
end)

game.Players.LocalPlayer.CharacterAdded:Connect(function()
game.Players.LocalPlayer.Character:WaitForChild("Humanoid")
game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart")
game.Players.LocalPlayer.Character:WaitForChild("stamina")
game.Players.LocalPlayer.Character:WaitForChild("fallDamage")
wait(1)
                             if settings["FastTools"] then
for i, v in next, getgc(game) do
if typeof(v) == "function" then
for i1, v1 in next, debug.getupvalues(v) do
if typeof(v1) == "table" then
if rawget(v1, "actionTime") then
rawset(v1, "actionTime", 0.1)
end
end
end
end
end
                             end
wait(1)
game.Players.LocalPlayer.Character.stamina:Remove()
game.Players.LocalPlayer.Character:WaitForChild("fallDamage"):Remove()
game.Players.LocalPlayer.Character.Humanoid.Changed:Connect(function(v)
if v == "WalkSpeed" and settings["SpeedHack"] == true then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedget(38)
end
end)
                        if settings["SpeedHack"] == true then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = walkspeedget(38)
                        end
end)


end) --end

wait(1)

spawn(function() --begin
local espcolor = Color3.new(0,205,0)
local armorcolor = {["Naked"] = Color3.new(236,188,180),
["Leather"] = Color3.new(144,107,82),
["Bronze"] = Color3.new(255,165,0),
["Iron"] = Color3.new(255,255,255),
["Steel"] = Color3.new(176,179,183),
["Bluesteel"] = Color3.new(51,171,249),
["Darksteel"] = Color3.new(91,73,101)}


assert(Drawing, "exploit cua ban khong ho tro drawing library");

local function getcolor(a)
local r = a.R/255
local g = a.G/255
local b = a.B/255
return Color3.new(r, g, b)
end
-- services
local run_service = game:GetService("RunService");
local players = game:GetService("Players");
local workspace = game:GetService("Workspace");

-- variables
local camera = workspace.CurrentCamera;
local get_pivot = workspace.GetPivot;
local wtvp = camera.WorldToViewportPoint;
local viewport_size = camera.ViewportSize;
local localplayer = players.LocalPlayer;
local cache = {};
local meshCache = {}
local armorlist = {}

-- locals
local new_drawing = Drawing.new;
local new_vector2 = Vector2.new;
local new_color3 = Color3.new;
local rad = math.rad;
local tan = math.tan;
local floor = math.floor;

-- functions
function create_esp(player)
   local esp = {};

   esp.name = new_drawing("Text", true);
   esp.name.Color = espcolor;
   esp.name.Size = 14;
   esp.name.Center = true;

   esp.distance = new_drawing("Text", true);
   esp.distance.Color = espcolor;
   esp.distance.Size = 14;
   esp.distance.Center = true;

   esp.armor = new_drawing("Text", true);
   esp.armor.Color = espcolor;
   esp.armor.Size = 14;
   esp.armor.Center = true;

   cache[player] = esp;
end

function remove_esp(player)
   for _, drawing in next, cache[player] do
       drawing:Remove();
   end

   cache[player] = nil;
   armorlist[tostring(player)] = nil
end

   function getArmorName(char) 
       local armor = char:FindFirstChild("Shirt") or char:FindFirstChild("Helmet") or char:FindFirstChild("Pants")
       if not armor then
       armorlist[char.Name] = "Naked"
           return
       end

       local mesh
       for i,v in next, armor:GetDescendants() do 
           if v:IsA("MeshPart") and v.Name:match("Meshes") then 
               mesh = v
               break
           end
       end

       if not mesh then 
       armorlist[char.Name] = "Naked"
           return
       end

       if not meshCache[mesh] then
           local craftingTrees = game.Players.LocalPlayer.PlayerGui.Crafting.trees  
           for i,v in next, craftingTrees:GetDescendants() do
               if v.Name == mesh.Name then 
                   meshCache[mesh] = v:FindFirstAncestorOfClass("ImageButton").Name:split(" ")[1]
               end
           end
       end

       armorlist[char.Name] = tostring(meshCache[mesh])
   end

spawn(function()
while wait(.2) do
for i, v in pairs(game.Players:GetPlayers()) do
if v.Character and v ~= game.Players.LocalPlayer then
getArmorName(v.Character)
end
end
end
end)

function update_esp()
                   pcall(function()
   for player, esp in next, cache do
       local character = player and player.Character;
       if character then
           local cframe = get_pivot(character);
           local position, visible = wtvp(camera, cframe.Position);

           esp.name.Visible = visible;
           esp.distance.Visible = visible;
           esp.armor.Visible = visible;

           if visible then
           local lmao
           if armorlist[player.Name] and armorlist[player.Name] ~= nil then
           lmao = armorlist[player.Name]
           else
           lmao = "Naked"
           end
               local scale_factor = 1 / (position.Z * tan(rad(camera.FieldOfView * 0.5)) * 2) * 100;
               local width, height = floor(35 * scale_factor), floor(50 * scale_factor);
               local x, y = floor(position.X), floor(position.Y);
               if _G.toggled == true and player.Team ~= localplayer.Team then
               esp.name.Text = (player.Name .. " [ON]");
               else
                                                      if settings["ESP_DisplayName"] then
               esp.name.Text = (player.DisplayName);
                                                      else
               esp.name.Text = (player.Name);
                                                      end
               end
               if player.Team ~= game.Players.LocalPlayer.Team then
               esp.name.Color = Color3.new(205,0,0)
               esp.distance.Color = Color3.new(205,0,0)
               else
               esp.name.Color = Color3.new(0,205,0)
               esp.distance.Color = Color3.new(0,205,0)
               end

               esp.name.Position = new_vector2(x, floor(y - height * 0.5 - esp.name.TextBounds.Y));

               esp.distance.Text = (floor(position.Z) .. " studs " .. floor(player.Character.Humanoid.Health));
               esp.distance.Position = new_vector2(x, floor(y + height * 0.5));

               if armorcolor[string.gsub(lmao, " ", "")] then
               esp.armor.Color = getcolor(armorcolor[string.gsub(lmao, " ", "")])
               end
               esp.armor.Text = lmao
               esp.armor.Position = new_vector2(x, floor(y - height * 0.5 - esp.name.TextBounds.Y - 10));
           end
       else
           esp.name.Visible = false;
           esp.distance.Visible = false;
           esp.armor.Visible = false;
       end
   end
                        end)
end

-- connections
players.PlayerAdded:Connect(create_esp);
players.PlayerRemoving:Connect(remove_esp);
run_service.RenderStepped:Connect(update_esp);

for _, player in next, players:GetPlayers() do
   if player ~= localplayer then
       create_esp(player);
   end
end

end) --end



spawn(function() --hitbox
local Meta = getrawmetatable(game);
setreadonly(Meta, false);

local RealIndex = Meta.__index;
Meta.__index = function(self, arg)
   if (arg == "Size") and not checkcaller() then
       return Vector3.new(2, 2, 1);
   end;
   return RealIndex(self, arg);
end;
setreadonly(Meta, true);

local function checkbow()
local lmao = false
for i, v in next, game.Players.LocalPlayer.Character:GetDescendants() do
if tostring(v) == "Arrow" and v:IsA("Model") and v.Parent.Parent and v.Parent.Parent:IsA("Tool") then
lmao = true
end
end
return lmao
end

while wait(0.1) do
pcall(function()
for i, v in next, game.Players:GetPlayers() do
if v ~= game.Players.LocalPlayer and v.Character and (v.Character:FindFirstChild("Humanoid") and v.Character:FindFirstChild("HumanoidRootPart")) then
if v.Character.Humanoid.Sit ~= true then
local check = checkbow()
if check == false then
v.Character.HumanoidRootPart.Size = Vector3.new(12, 12, 12)
v.Character.HumanoidRootPart.CanCollide = false
else
v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
end
else
v.Character.HumanoidRootPart.Size = Vector3.new(2, 2, 1)
end
end
end
end)
end


end) --end


else
setclipboard("discord.gg/Avp48C3zPZ")
game.Players.LocalPlayer:Kick("Ban chua duoc whitelist, gia nhap discord.gg/Avp48C3zPZ de duoc whitelist mien phi. Duong link da duoc copy ve may")
end

else
                             if settings["SpeedHack"] == true then
game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 38
                        end
end
