local Mainpos = CFrame.new(0,15,0)
local Moving = false
local Flying = false
sine = 30*tick()
pcall(function()
    Mainpos = owner.Character.HumanoidRootPart.CFrame
end)
warn("Loading!")
local Char = nil
local Player,Mouse do
    Player= owner
    pcall(function()
        local OldMouseFolder = Player.MouseFolder
        for _,v in pairs(Player:GetDescendants()) do
            if v:IsDescendantOf(OldMouseFolder) then
                game:GetService("Debris"):AddItem(v,0)
            end
        end
        wait(0.1)
        OldMouseFolder:Destroy()
    end)
    task.wait()
    local MouseFolder = Instance.new("Folder",Player)
    MouseFolder.Name = "MouseFolder"
    local Remote = Instance.new("RemoteEvent",MouseFolder)
    Remote.Name = "MainRemote"
    local MoveRemote = Instance.new("RemoteEvent",MouseFolder)
    MoveRemote.Name = "MoveRemote"
    function mouseEvent (name)
        local Bind = Instance.new("BindableEvent",MouseFolder)
        Bind.Name = name
        return Bind
    end
    FakeMouse = {KeyDown = mouseEvent("KeyDown"), KeyUp = mouseEvent("KeyUp"), Button1Down = mouseEvent("Button1Down"), Button1Up = mouseEvent("Button1Up")}
    Mouse = {Hit = CFrame.new(0, 0, 0), Target = nil, KeyDown = FakeMouse.KeyDown.Event, KeyUp = FakeMouse.KeyUp.Event, Button1Down = FakeMouse.Button1Down.Event, Button1Up = FakeMouse.Button1Up.Event}
    Remote.OnServerEvent:Connect(function(plr,Method,arg1,arg2)
        local Event = MouseFolder:FindFirstChild(Method)
        if Event then
            Event:Fire(arg1)
        end
    end)
    MoveRemote.OnServerEvent:Connect(function(plr,Method,arg1,arg2,arg3)
        if Method == "Mainpos" then
            Mainpos,Moving,Flying = arg1,arg2,arg3
            sine = 30*tick()
        end
    end)
    task.spawn(function()
        while MoveRemote:IsDescendantOf(Player) do
            task.wait()
            pcall(function()
                MoveRemote:FireAllClients({Char,Char:GetDescendants()})
            end)
        end
    end)
    NLS([==[
task.wait()
script.Parent = nil

local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local MouseFolder = Player.MouseFolder
local Event = nil
repeat wait()
Event = MouseFolder:FindFirstChild("MainRemote")
until Event ~= nil
warn("Loaded!")
local input = game:GetService("UserInputService")
warn(Event,MouseFolder)
local function oninput(io,k)
    if k then
        return
    end
    if io.UserInputState == Enum.UserInputState.Begin then
        if io.UserInputType == Enum.UserInputType.MouseButton1 then
            Event:FireServer("Button1Down")
        elseif io.UserInputType == Enum.UserInputType.Keyboard then
            Event:FireServer("KeyDown",io.KeyCode.Name:lower())
        end
    elseif io.UserInputState == Enum.UserInputState.End then
        if io.UserInputType == Enum.UserInputType.MouseButton1 then
            Event:FireServer("Button1Up")
        elseif io.UserInputType == Enum.UserInputType.Keyboard then
            Event:FireServer("KeyUp",io.KeyCode.Name:lower())
        end
    end
end
input.InputEnded:Connect(oninput)
input.InputBegan:Connect(oninput)
game:GetService("RunService").RenderStepped:Connect(function()
    pcall(function()
        Event:FireServer("MouseData",Mouse.Hit,Mouse.Target)
    end)
    pcall(function()
    workspace.CurrentCamera.CameraSubject = Player.Character:FindFirstChild("Humanoid")
    end)
end)
    ]==], Player.PlayerGui)
    NLS([==[
    script.Name = "{Event-Client}"
    if not game.Loaded then
    game.Loaded:Wait()
end
wait(1/60)
script.Parent = nil
local WalkSpeed = 65
local FlyMode = false
local CFrameValue = Instance.new("CFrameValue")
CFrameValue.Value = CFrame.new(0, 15, 0)
local LocalPlayer = game:GetService("Players").LocalPlayer
local mainpos = CFrame.new(0,25,0)
local PotentialCFrame, OldCFrame, Moving, LastFrame = mainpos, mainpos, false, tick()
CFrameValue.Value = mainpos
local UserInputService = game:GetService("UserInputService")
local Mode = "default"
local RayProperties = RaycastParams.new()
RayProperties.IgnoreWater,RayProperties.FilterType = true,Enum.RaycastFilterType.Blacklist
local function KeyDown(Key)
    return not game:GetService("UserInputService"):GetFocusedTextBox() and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode[Key]) or false
end
local function KeyUp(Key)
    return not game:GetService("UserInputService"):GetFocusedTextBox() and not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode[Key]) or false
end
UserInputService.InputBegan:connect(function(input,s)
if s then return end
if input.KeyCode.Name:lower() == "f" then
FlyMode = not FlyMode
end
end)
owner.MouseFolder.MoveRemote.OnClientEvent:connect(function(wl)
            RayProperties.FilterDescendantsInstances = wl
end)
    local MouseProps,Hit,Target = RaycastParams.new(),CFrame.new(),nil
game:GetService("RunService").RenderStepped:Connect(function()
    local LookVector = workspace.CurrentCamera.CFrame.LookVector
    local Closest, __L = math.huge, nil
    local _Ray = nil
    local _Raycasts = {}
    if (UserInputService.MouseBehavior ~= Enum.MouseBehavior.Default) then
        if not FlyMode then
            mainpos = CFrame.new(mainpos.p,Vector3.new(mainpos.X+LookVector.X,mainpos.Y,mainpos.Z+LookVector.Z))
        else
            mainpos = CFrame.new(mainpos.p,mainpos.p+LookVector)
        end
    end
    pcall(function()
        game:GetService'TweenService':Create(CFrameValue,TweenInfo.new(0.1),{
            Value = mainpos
        }):Play()
        owner.MouseFolder.MoveRemote:FireServer("Mainpos",CFrameValue.Value,Moving,FlyMode)
    end)
    pcall(function()
    Part = workspace[LocalPlayer.Name].Head
    workspace.CurrentCamera.CameraSubject = Part
    end)
    if FlyMode then
        PotentialCFrame = CFrame.new(mainpos.p,mainpos.p+LookVector)
    else
        PotentialCFrame = CFrame.new(mainpos.p,Vector3.new(mainpos.X+LookVector.X,mainpos.Y,mainpos.Z+LookVector.Z))
    end
    OldCFrame = mainpos
        local _Raycast = workspace:Raycast(mainpos.Position-Vector3.new(0,1,0),Vector3.new(0,-9e9,0),RayProperties)
        local Magnitude = (mainpos.Position-_Raycast.Position).Magnitude
        if Magnitude < Closest then
            Closest,_Ray = Magnitude,_Raycast
        end
    if not FlyMode then
   if _Ray then
   
    mainpos = CFrame.new(0,(_Ray.Position.Y-mainpos.Y)+3,0)*mainpos
    end
    end
    if KeyDown("W") then
        PotentialCFrame = PotentialCFrame *  CFrame.new(0,0,-1)
    end
    if KeyDown("A") then
        PotentialCFrame   = PotentialCFrame *  CFrame.new(-1,0,0)
    end
    if KeyDown("S") then
        PotentialCFrame = PotentialCFrame * CFrame.new(0,0,1)
    end
    if KeyDown("D") then
        PotentialCFrame = PotentialCFrame * CFrame.new(1,0,0)
    end
    if (PotentialCFrame.X ~= OldCFrame.X or PotentialCFrame.Z ~= OldCFrame.Z) then
        Moving = true
        mainpos = mainpos:Lerp(CFrame.new(mainpos.p,PotentialCFrame.p)*CFrame.new(0,0,(tick()-LastFrame)*-(WalkSpeed)), 0.65)
    else
        Moving = false
    end
    LastFrame = tick()
end)
warn("same")
]==],Player.PlayerGui)
end
wait()
local Rng = Random.new()
owner.Character.Archivable = true
task.wait()
Size = {}
local Character = owner.Character:Clone()
Changed = {}
Changed2 = {}
for _,v in pairs(Character:GetDescendants()) do
    if v:IsA("BasePart") == true and v.Parent == Character then
        local new = Instance.new("SpawnLocation",Character)
        new.Name = v.Name
        new.CFrame = v.CFrame
        new.Size = v.Size
        new.Anchored = true
        Size[v.Name] = v.Size
        new.CanCollide = false
        new.Name = v.Name
        new.Neutral = false
        task.spawn(function()
            task.wait()
            game:GetService("Debris"):AddItem(v,0)
        end)
    end
end
function CharacterScripts(v)
    for _,v in pairs(v:GetDescendants()) do
        if v:IsA("LocalScript") or v:IsA("Animator") then
            game:GetService("Debris"):AddItem(v,0)
        end
    end
end
CharacterScripts(Character)
Character.Parent = owner
Character.Humanoid.Name = Rng:NextNumber(1,1000000)
Character.Name = Rng:NextNumber(1,1000000)
Character.HumanoidRootPart:Destroy()
wait(1)
for _,v in pairs(Character:GetDescendants()) do
    if v:IsA("Decal") then
        v:Destroy()
    elseif v:IsA("BasePart") then
        pcall(function()
            v.Anchored = true
            v.Color = Color3.fromRGB(155,155,155)
        end)
    elseif v:IsA("Accessory") then
        v:Destroy()
    elseif v:IsA("BodyColors") then
        v:Destroy()
    elseif v:IsA("Shirt") or v:IsA("Pants") then
        v:Destroy()
    elseif v:IsA("Humanoid") then
        v:Destroy()
    end
end
local Player = owner
Plr = Player
local CharName = ""
function SetCharName(len)
    local len = (len or math.random(1,45))
    CharName = ""
    ("."):rep(len):gsub(".",function()
        CharName = CharName.. utf8.char(math.random(62,462))
    end)
end
local function SetCharacter()
    pcall(function()
        game:GetService("Debris"):AddItem(Char, 0)
    end)
    Char = Character:Clone()
    Char.Parent = workspace
    pcall(function()
        Char.Torso.CFrame = Mainpos
    end)
    SetCharName()
    Char.Name = owner.Name
    Char.Parent = workspace
end
SetCharacter()
rbg= false
Mouse.KeyDown:Connect(function(Key)
    if Key == "p" then
        SetCharacter()
    elseif Key == "m" then
        rbg = not rbg
    end
end)
script.Parent = game:GetService("ServerScriptService")
script.Name = Rng:NextNumber(1,1000000)
local TextService = game:GetService("TextService")
local ChatService = game:GetService("Chat")
local RunService = game:GetService("RunService")
function filter(enc,len)
    return ChatService:FilterStringForBroadcast(len,Plr)
end
Player.Chatted:connect(function(a)
    local filtered_text = filter("utf",a)
    local chatted,value = pcall(function()
        ChatService:Chat(Char.Head,filtered_text,3)
    end)
    if (not chatted) then
        --warn("ChatError!"..value)
    end
end)
local Torso = CFrame.new()
local Head = CFrame.new(0,1.5,0)
local RightArm = CFrame.new(1.5,0,0)
local LeftArm = CFrame.new(-1.5,0,0)
local RightLeg = CFrame.new(.5,-2,0)
local LeftLeg = CFrame.new(-.5,-2,0)
song = Instance.new("Sound",owner)
timepos = 0
function MainLoop(step)
    pcall(function()
        timepos = song.TimePosition
    end)
    local succ,msg = pcall(function()
        if Char then
            song.Parent = Char:FindFirstChild("Head")
        end
        song.Looped = true
        song.Playing = true
        song.Volume = 1.5
        if not rbg then
            song.SoundId = "rbxassetid://6810954667"
            song.PlaybackSpeed = 0.623
        else
            song.SoundId = "rbxassetid://2371543268"
            song.PlaybackSpeed = 1+0.5*math.sin(sine/45)
        end
    end)
    if not song or not succ then
        --warn(msg)
        game:GetService("Debris"):AddItem(song,0)
        song = Instance.new("Sound")
        song.Parent = Char:FindFirstChild("Head")
        song.Name = math.random()
        song.SoundId = "rbxassetid://2371543268"
        song.TimePosition = timepos
        song.Looped = true
        song.Playing = true
        song.Volume = 1.5
    end
    if not Flying then
            if not rbg then
                Head = Head:Lerp(CFrame.new(0,1.5,0),0.2)
                Torso = Torso:Lerp(CFrame.Angles(math.rad(3*math.sin(sine/32)),0,0),0.2)
                RightArm = RightArm:Lerp(CFrame.new(1.5,-0.2,-0.1)*CFrame.Angles(0,math.rad(6-2*math.sin(sine/32)),0),0.2)
                LeftArm = LeftArm:Lerp(CFrame.new(-1.5,-0.2,-0.1)*CFrame.Angles(0,math.rad(-6+2*math.sin(sine/32)),0),0.2)
                RightLeg = RightLeg:Lerp(CFrame.new(.5,-2,0)*CFrame.Angles(0,math.rad(6-2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-3*math.sin(sine/32)),0,0),0.2)
                LeftLeg = LeftLeg:Lerp(CFrame.new(-.5,-2,0)*CFrame.Angles(0,math.rad(-6+2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-3*math.sin(sine/32)),0,0),0.2)
            else
                Head = Head:Lerp(CFrame.new(0,1.5,0),0.2)
            Torso = Torso:Lerp(CFrame.Angles(math.rad(360*math.sin(sine/32)),math.rad(360*math.sin(sine/32)),math.rad(360*math.sin(sine/32))),0.2)
            RightArm = RightArm:Lerp(CFrame.new(1.5,-0.2,-0.1)*CFrame.Angles(math.rad(360*math.sin(sine/32)),math.rad(6-360*math.sin(sine/32)),math.rad(360*math.sin(sine/32))),0.2)
            LeftArm = LeftArm:Lerp(CFrame.new(-1.5,-0.2,-0.1)*CFrame.Angles(math.rad(360*math.sin(sine/32)),math.rad(-6+360*math.sin(sine/32)),math.rad(360*math.sin(sine/32))),0.2)
            RightLeg = RightLeg:Lerp(CFrame.new(.5,-2,0)*CFrame.Angles(0,math.rad(6-360*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-360*math.sin(sine/32)),math.rad(360*math.sin(sine/32)),math.rad(360*math.sin(sine/32))),0.2)
            LeftLeg = LeftLeg:Lerp(CFrame.new(-.5,-2,0)*CFrame.Angles(0,math.rad(-6+360*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-360*math.sin(sine/32)),math.rad(360*math.sin(sine/32)),math.rad(360*math.sin(sine/32))),0.2)
            end
    else
        if not Moving then
           Head = Head:Lerp(CFrame.new(0,1.5,0),0.2)
            Torso = Torso:Lerp(CFrame.new(-3*math.cos(sine/32),3*math.sin(sine/32),-4*math.sin(sine/24)),0.2)
            RightArm = RightArm:Lerp(CFrame.new(.5,-0.2,0.5)*CFrame.Angles(0,0,math.rad(-45)),0.2)
           LeftArm = LeftArm:Lerp(CFrame.new(-.5,-0.4,-0.4)*CFrame.Angles(math.rad(70),0,math.rad(-89)),0.2)
           RightLeg = RightLeg:Lerp(CFrame.new(.5,-1.75,-0.2)*CFrame.Angles(math.rad(-20-12*math.sin(sine/32)),math.rad(6-2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-3*math.sin(sine/32)),0,0),0.2)
            LeftLeg = LeftLeg:Lerp(CFrame.new(-.5,-2,0)*CFrame.Angles(0,math.rad(-6+2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-3*math.sin(sine/32)),0,0),0.2)
        else
            Head = Head:Lerp(CFrame.new(0,1.5,0)*CFrame.Angles(math.rad(45),0,0),0.2)
            Torso = Torso:Lerp(CFrame.new(-3*math.cos(sine/32),3*math.sin(sine/32),-4*math.sin(sine/24))*CFrame.Angles(math.rad(-65),0,0),0.2)
            RightArm = RightArm:Lerp(CFrame.new(1.5,-0.2,-0.4)*CFrame.Angles(math.rad(0),0,math.rad(3)),0.2)
            LeftArm = LeftArm:Lerp(CFrame.new(-1.5,-0.4,-0.4)*CFrame.Angles(math.rad(0),0,math.rad(-5.283)),0.2)
            RightLeg = RightLeg:Lerp(CFrame.new(.5,-1.75,-0.2)*CFrame.Angles(math.rad(-20-12*math.sin(sine/32)),math.rad(-6-2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(-3*math.sin(sine/32)),0,0),0.2)
            LeftLeg = LeftLeg:Lerp(CFrame.new(-.5,-2,0)*CFrame.Angles(0,math.rad(6+2*math.sin(sine/32)),0)*CFrame.Angles(math.rad(3*math.sin(sine/32)),0,0),0.2)
        end
    end
    if Player.Character then
        game:GetService("Debris"):AddItem(Player.Character,0)
        Player.Character = nil
    end
    pcall(function()
        for _,v in pairs(Char:GetDescendants()) do
            if v:IsA("Decal") then
                v:Destroy()
            elseif v:IsA("BasePart") then
                pcall(function()
                    v.Anchored = true
                    if not rbg then
                        v.Color = Color3.fromRGB(155,155,155)
                        v.Transparency = 0
                        v.Reflectance = Rng:NextNumber(0.5,1)
                        v.Material = Enum.Material:GetEnumItems()[math.random(1,#Enum.Material:GetEnumItems())]
                    else
                        v.Color = Color3.fromHSV((tick()%1/1),1,1)
                        v.Transparency = 0
                        v.Reflectance = Rng:NextNumber(0.5,1)
                        v.Material = "ForceField"
                    end
                    if v.Transparency ~= 0 then
                        SetCharacter()
                    end
                    if v.Size ~= Size[v.Name] then
                        SetCharacter()
                    end
                end)
            elseif v:IsA("Accessory") then
                v:Destroy()
            elseif v:IsA("BodyColors") then
                v:Destroy()
            elseif v:IsA("Shirt") or v:IsA("Pants") then
                v:Destroy()
            elseif v:IsA("SpecialMesh") then
                v:Destroy()
            end
        end
    end)
    local succ,msg=pcall(function()
        Char.Parent = workspace
        Char:BreakJoints()
        Char.Torso.CFrame = Mainpos*Torso
        Char.Head.CFrame = Mainpos*Torso*Head
        Char["Right Arm"].CFrame = Mainpos*Torso*RightArm
        Char["Left Arm"].CFrame = Mainpos*Torso*LeftArm
        Char["Right Leg"].CFrame = Mainpos*Torso*RightLeg
        Char["Left Leg"].CFrame = Mainpos*Torso*LeftLeg
    end)
    if not succ then
        SetCharacter()
    end
end

game:GetService("RunService").Stepped:Connect(MainLoop)
game:GetService("RunService").Heartbeat:Connect(MainLoop)
