local Plr do
    Plr = owner
end
local Part = Instance.new("SpawnLocation")
DefaultSize = Vector3.new(5,5,5)
DefaultColor = Part.Color
Part.Anchored = true
local BodyPosition = Instance.new("BodyPosition")
BodyPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
BodyPosition.D = 1250
BodyPosition.P = 10000
local BodyAngularVelocity = Instance.new("BodyAngularVelocity")
BodyAngularVelocity.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
BodyAngularVelocity.P = 10000
Part.Parent = script
local Part2 = Part:Clone()
local BodyPosition2 = BodyPosition:Clone()
local BodyAngularVelocity2 = BodyAngularVelocity:Clone()
local Part4 = Part:Clone()
Pos = CFrame.new()
RootPos = CFrame.new()
x = 0
c = 0
RootPos = Plr.Character.HumanoidRootPart.CFrame * CFrame.new(0,math.random(10,100),0)*CFrame.Angles(math.rad(math.random(-15,15)),math.rad(math.random(-15,15)),math.rad(math.random(-15,15)))
Part3 = Instance.new("SpawnLocation")
song = Part3:Clone()
Part5 = Part3:Clone()
Mesh2 = Instance.new("SpecialMesh")
Part3.Anchored = true
Follow = false
j = {}
MusicId = "rbxassetid://0"
Pitch = 1
owner.Chatted:Connect(function(msg)
    if msg == "$follow" then
        Follow = not Follow
    end
    pcall(function()
        local args = msg:split("$cmd ")
        if args[2]:sub(1,2) == "id" then
            MusicId = "rbxassetid://".. tostring(args[2]:sub(3))
            warn(MusicId)
            song:Play()
            song.Playing = true
        elseif args[2]:sub(1,5) == "pitch" then
            Pitch = args[2]:sub(6)
        end
    end)
end)
RootPos2 = RootPos
Mesh = Instance.new("SpecialMesh")
HaloLocation =  RootPos
Selection = Instance.new("SelectionBox")
ClockTime = 0
--4784915254
game:GetService("RunService").Stepped:Connect(function()
    sine = (30*tick())
    x += 0.2
    c += 0.5
    ClockTime += 0.05 
    if ClockTime >= 24 then ClockTime = 0 end
    if x>=360 then x = 0 end
    if c>=360 then c = 0 end
    pcall(function()
        owner.Character.Humanoid.DisplayName = "[ REDACTED ]"
    end)
    pcall(function()
        if Follow then
           RootPos = owner.Character.HumanoidRootPart.CFrame
        end
        RootPos2 = owner.Character.HumanoidRootPart.CFrame
    end)
    if not Selection or not pcall(function()
            Selection.LineThickness = 0.45
            Selection.Color = Color3.new(1,0,0)
            Selection.Adornee = Halo
            Selection.Parent = workspace
        end) then
        game:GetService("Debris"):AddItem(Selection,0)
        Selection = Instance.new("SelectionBox")
    end
    HaloLocation =  RootPos2 * CFrame.new(0,6,0)
    Pos = RootPos * CFrame.new(0,15,0) * CFrame.new(24*math.cos(sine/25),5+7*math.cos(sine/62),-24*math.sin(sine/25))*CFrame.Angles(math.rad(-x),math.rad(x),math.rad(c))
    local Pos2 = RootPos * CFrame.new(8*math.cos(sine/25),8,-8*math.sin(sine/25))*CFrame.Angles(math.rad(-x),math.rad(x),math.rad(c))
    j[1] = Part
    j[2] = Part2
    j[3] = Part3
    j[4] = Part4
    j[5] = Part5
    j[6] = Halo
    for _,v in pairs(j) do
        pcall(function()
            v.Neutral = false
            v.CanCollide = false
        end)
    end
    if not Part or not pcall(function()
            Part.Parent = script
            Part.Size = DefaultSize
            Part.Color = DefaultColor
            Part.Material = "Plastic"
            Part.Anchored = false
        end) then
        game:GetService("Debris"):AddItem(Part,0)
        Part = Instance.new("SpawnLocation")
        Part.Anchored = true
    end
    if not Part3 or not pcall(function()
            Part3.Parent = script
            Part3.Size = Vector3.new(75,75,75)
            Part3.CastShadow = false
            Part3.Color = DefaultColor
            Part3.CFrame = RootPos
            Part3.CanCollide = false
            Part3.Material = "ForceField"
            Part3.Shape = "Ball"
            Part3.Anchored = true
        end) then
        game:GetService("Debris"):AddItem(Part,0)
        Part3 = Instance.new("SpawnLocation")
        Part3.Anchored = true
    end
    if not Part2 or not pcall(function()
            Part2.Parent = script
            Part2.Size = DefaultSize
            Part2.Color = DefaultColor
            Part2.Material = "Plastic"
            Part2.Anchored = false
        end) then
        game:GetService("Debris"):AddItem(Part2,0)
        Part2 = Instance.new("SpawnLocation")
        Part2.Anchored = true
    end
    if not Part4 or not pcall(function()
            Part4.Size = Vector3.new(0,0,0)
            Part4.CanCollide = false
            Part4.Name = "Orbit".. tostring(1)
            Part4.Parent = script
            Part4.Color = Color3.fromRGB()
            Part4.CFrame = RootPos * CFrame.new(0, 2, 0)*CFrame.Angles(0,math.rad(x),0)
        end) then
        game:GetService("Debris"):AddItem(Part4,0)
        Part4 = Instance.new("SpawnLocation")
        Part4.Anchored = true
    end
    if not Part5 or not pcall(function()
            Part5.Size = Vector3.new(0,0,0)
            Part5.CanCollide = false
            Part5.Anchored = true
            Part5.Name = "Orbit".. tostring(2)
            Part5.Parent = script
            Part5.Color = Color3.fromRGB(255,255,255)
            Part5.CFrame = RootPos * CFrame.new(0, 2, 0)*CFrame.Angles(0,math.rad(x),0)
        end) then
        game:GetService("Debris"):AddItem(Part5,0)
        Part5 = Instance.new("SpawnLocation")
        Part5.Anchored = true
    end
    pcall(function()
        timepos =song.TimePosition
    end)
    if not song or not pcall(function()
            song.Parent = Part4
            song.Looped = true
            song.Pitch = Pitch
            song.RollOffMaxDistance = 1750
            song.RollOffMinDistance = 25
            song.Playing = true
            song.SoundId = MusicId
            song.Volume = 2
        end) then
        game:GetService("Debris"):AddItem(song,0)
        song = Instance.new("Sound")
        
    end
    if not Mesh or not pcall(function()
            Mesh.Parent = Part4
            Mesh.MeshId = "rbxassetid://5821358985"
            Mesh.TextureId = ""
            Mesh.Scale = Mesh.Scale:Lerp(Vector3.new(9, 9, 9),0.025)
        end) then
        game:GetService("Debris"):AddItem(Mesh,0)
        Mesh = Instance.new("SpecialMesh")
    end
    if not Mesh2 or not pcall(function()
            Mesh2.Parent = Part5
            Mesh2.MeshId = "rbxassetid://5821358985"
            Mesh2.TextureId = ""
            Mesh2.Scale = Mesh2.Scale:Lerp(Vector3.new(13.97, 13.97, 13.97),0.02382213)
        end) then
        game:GetService("Debris"):AddItem(Mesh2,0)
        Mesh2 = Instance.new("SpecialMesh")
    end
    if not BodyAngularVelocity or not pcall(function()
            BodyAngularVelocity.MaxTorque = Vector3.new(15,15,15)
            BodyAngularVelocity.P = 1
            BodyAngularVelocity.Parent = Part
            BodyAngularVelocity.AngularVelocity = Vector3.new(-x,-c,c)
        end) then
        game:GetService("Debris"):AddItem(BodyAngularVelocity,0)
        BodyAngularVelocity = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BodyAngularVelocity.P = 10000
    end
    if not BodyAngularVelocity2 or not pcall(function()
            BodyAngularVelocity2.MaxTorque = Vector3.new(32,2,6)
            BodyAngularVelocity2.P = 1
            BodyAngularVelocity2.Parent = Part2
            BodyAngularVelocity2.AngularVelocity = Vector3.new(-x,-c,c)
        end) then
        game:GetService("Debris"):AddItem(BodyAngularVelocity2,0)
        BodyAngularVelocity2 = Instance.new("BodyAngularVelocity")
        BodyAngularVelocity2.MaxTorque = Vector3.new(math.huge,math.huge,math.huge)
        BodyAngularVelocity2.P = 10000
    end
    if not BodyPosition or not pcall(function()
            BodyPosition.Parent = Part
            BodyPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            BodyPosition.D = 1250
            BodyPosition.Position = Pos.p
            BodyPosition.P = 10000
        end) then
        game:GetService("Debris"):AddItem(BodyPosition,0)
        BodyPosition = Instance.new("BodyPosition")
        BodyPosition.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        BodyPosition.D = 1250
        BodyPosition.P = 10000
    end
    if not BodyPosition2 or not pcall(function()
            BodyPosition2.Parent = Part2
            BodyPosition2.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
            BodyPosition2.D = 1250
            BodyPosition2.Position = Pos2.p
            BodyPosition2.P = 10000
        end) then
        game:GetService("Debris"):AddItem(BodyPosition2,0)
        BodyPosition2 = Instance.new("BodyPosition")
        BodyPosition2.MaxForce = Vector3.new(math.huge,math.huge,math.huge)
        BodyPosition2.D = 1250
        BodyPosition2.P = 10000
    end
end)
