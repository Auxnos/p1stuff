pcall(function()
    owner.UI_Event:Destroy()
end)

local Console = Instance.new("SpawnLocation",script)
Console.CFrame = owner.Character.HumanoidRootPart.CFrame * CFrame.new(-3,2,-5) * CFrame.Angles(0,math.rad(90),0)
Console.Neutral = false
Console.CanCollide = false
Console.Anchored = false
Console.Material = "Glass"
Console.Transparency = 1
Console.Name = "Console"
Console.Size = Vector3.new(0.2, 4.2, 10)
script.Name = "Aux's Console (".. owner.Name
local ui_ = Instance.new("SurfaceGui",Console)
ui_.Name = "ConsoleSurface"
ui_.Face = "Left"
ui_.ClipsDescendants = false
ui_.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
ui_.CanvasSize = Vector2.new(ui_.CanvasSize.X*2,ui_.CanvasSize.Y*2)
local ui_2 = Instance.new("SurfaceGui",Console)
ui_2.Name = "ConsoleSurface"
ui_2.Face = "Right"
ui_2.ClipsDescendants = false
ui_2.SizingMode = Enum.SurfaceGuiSizingMode.FixedSize
ui_2.CanvasSize = Vector2.new(ui_2.CanvasSize.X*2,ui_2.CanvasSize.Y*2)
local ui2 = ui_:Clone()
ui2.Parent = Console
local frame = Instance.new("Frame",ui2)
frame.Name = "BackgroundFrame"
frame.Size = UDim2.new(1, 0,1, 0)
frame.BorderSizePixel = 0
frame.BackgroundColor3 = Color3.fromRGB()
local framee = Instance.new("Frame",ui2)
framee.Name = "BackgroundFrame2"
framee.Size = UDim2.new(0.23, 0,1, 0)
framee.Position = UDim2.new(1.5,0,0,0)
framee.BorderSizePixel = 0
framee.BackgroundColor3 = Color3.fromRGB(50,50,50)
local frameee
do
     frameee =frame:Clone()
    frameee.Parent = ui_2
end
local textboxe = Instance.new("TextBox",framee)
textboxe.Name = "Server_Text"
textboxe.Text = "FPS: NaN"
textboxe.TextScaled = false
textboxe.Size = UDim2.new(0.1, 0,0.2, 0)
textboxe.TextTransparency = 0
textboxe.TextColor3 = Color3.fromRGB(255,255,255)
textboxe.TextXAlignment = Enum.TextXAlignment.Left
textboxe.BackgroundTransparency = 1
textboxe.BorderSizePixel = 0
ts= 0
w = 0
task.spawn(function()
    wait(1)
    while textboxe:IsDescendantOf(script) do
        textboxe.TextColor3 = Color3.fromRGB(255,255,255)
        textboxe.Text = " Server FPS: ".. tostring((2/wait())):sub(1,4).."\n Task.Wait: "..tostring(ts):sub(1,5).."\n Wait: "..tostring(w):sub(1,5) .."\n Server Memory: "..math.floor(gcinfo()/1000).."MB".."\n Players: ".. #game:GetService("Players"):GetPlayers().. "/".. game:GetService("Players").MaxPlayers
        textboxe.TextSize = 24
    end
end)
task.spawn(function()
    while true do
        ts = task.wait()
    end
end)
task.spawn(function()
    while true do 
        w = wait()
    end
end)
currenttextbox = 0
Visible= false
task.spawn(function()
    while task.wait() do
        framee.Visible = Visible
    end
end)
local ui = ui_:Clone()
ui.Parent = Console
ui.AlwaysOnTop = true
ui_:Destroy()
local text_ = Instance.new("UIListLayout")
text_.Parent = ui
local text_ = Instance.new("UIListLayout")
text_.Parent = framee
local text_3 = Instance.new("UIListLayout")
text_3.Parent = ui_2
local text_2 = Instance.new("UIListLayout")
text_2.Parent = ui2
text_2.FillDirection = Enum.FillDirection.Horizontal
local textbox = Instance.new("TextBox",ui)
textbox.Name = "Server_Text"
textbox.Text = "swaggie_auxnos's terminal loaded!"
textbox.Size = UDim2.new(1, 0,0.1, 0)
textbox.TextTransparency = 0
textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
textbox.TextXAlignment = Enum.TextXAlignment.Left
textbox.BackgroundTransparency = 1
textbox.BorderSizePixel = 0
currenttextbox = 1
textboxes = {}
textboxes[1] = textbox
function newtextbox ()
    if #textboxes == 6 then
        for i,v in pairs(textboxes) do
            v:Destroy()
        end
        table.clear(textboxes)
        currenttextbox = 1
        return
        end
    FirstTextBox = Instance.new("TextBox",ui)
    FirstTextBox.Name = "Server_Text"
    FirstTextBox.Text = ""
    FirstTextBox.Size = UDim2.new(1, 0,0.1, 0)
    FirstTextBox.TextTransparency = 0
    FirstTextBox.TextColor3 = Color3.fromRGB(178, 178, 178)
    FirstTextBox.TextXAlignment = Enum.TextXAlignment.Left
    FirstTextBox.BackgroundTransparency = 1
    FirstTextBox.BorderSizePixel = 0
    currenttextbox+=1
    textboxes[currenttextbox] = FirstTextBox
end
local UI_Event = Instance.new("RemoteEvent")
UI_Event.Name = "UI_Event"
UI_Event.Parent = owner
local currenttext = ""
local song = Instance.new("Sound",Console)
song.Name = "ok joe"
song.Playing = false
nn = 0
song.Looped = true
PlayBackLoudness = 0
UI_Event.OnServerEvent:Connect(function(sender,method,text,position)
    if method == "TextData" then
        textboxes[currenttextbox].Text = text.. "■"
        currenttext = text
    elseif method == "TextBox" then
        task.spawn(function()
            wait(0.1)
            currenttext = string.sub(textboxes[currenttextbox].Text,1,#textboxes[currenttextbox].Text-1)
            textboxes[currenttextbox].Text = string.sub(textboxes[currenttextbox].Text,1,#textboxes[currenttextbox].Text-1)
            newtextbox ()
        end)
    elseif method == "RunCode" then
        NS(text,script)
    elseif method == "Clear" then
        task.spawn(function()
            for i,v in pairs(textboxes) do
                v:Destroy()
            end
            table.clear(textboxes)
            currenttextbox = 1
        end)
    elseif method == "NoScripts" then
        for _,v in pairs(script:GetChildren()) do
            if v:IsA("Script") then
                v:Destroy()
            end
        end
    elseif method == "Play" then
        song:Stop()
        song.Looped = true
        song.SoundId = "rbxassetid://".. text
        song:Play()
    elseif method == "Stop" then
        song:Stop()
    elseif method == "Visible" then
        Visible= not Visible
    elseif method == "Loudness" then
        PlayBackLoudness = text
    elseif method == "Sync" then
        for _,v in pairs(workspace:GetDescendants()) do
            if v:IsA("Sound") == true and v ~= song then
                pcall(function()
                    v.TimePosition = song.TimePosition
                end)
            end
        end
    
    end
end)
Sine = 0
local pos = Instance.new("BodyPosition", Console)
local gyro = Instance.new("BodyGyro", Console)
pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
pos.position = Console.CFrame.p
gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
gyro.cframe = Console.CFrame
uwu = CFrame.new()
task.spawn(function()
    while task.wait() do
        Sine = 10*tick()
        song.Looped = true
        pcall(function()
            uwu = owner.Character.HumanoidRootPart.CFrame
        end)
        local cframe = uwu * CFrame.new(0,2-0.2*math.cos(Sine/10),-5) * CFrame.Angles(math.rad(5*math.sin(Sine/10)),math.rad(90-5*math.sin(Sine/10)),0)
        pos.maxForce = Vector3.new(math.huge, math.huge, math.huge)
        pos.position = cframe.p
        gyro.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
        gyro.cframe = cframe
        textboxes[1] = textbox
        for i,v in pairs(textboxes) do
            pcall(function()
                v.Font = Enum.Font.Code
                v.TextScaled = true
                if song.Playing == true then
                    local a = 0.015*PlayBackLoudness
                    if a >= 1 then
                        a = 1
                    end
                    v.TextColor3 = Color3.fromHSV((tick()%1/1),a,a)
                else
                    v.TextColor3 = Color3.fromRGB(255,255,255)
                end
            end)
        end
    end
end)
NLS([==[
task.wait()
script.Parent = nil
local holder = workspace:FindFirstChild("Aux's Console (".. owner.Name)
local Remote = owner.UI_Event
local Console = holder.Console
local Song = Console:FindFirstChild("ok joe")
local ConsoleSurface = Console.ConsoleSurface
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = owner.PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.Name = "ConsoleGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.DisplayOrder = 0
local TextBox = Instance.new("TextBox")
TextBox.Text = ""
TextBox.ClearTextOnFocus = false
TextBox.Position = UDim2.new(5,0,5,0)
TextBox.Size = UDim2.new(0,0,0,0)
TextBox.TextTransparency = 1
TextBox.BackgroundTransparency = 1
TextBox.Name = "..."
TextBox.BorderSizePixel = 0
TextBox.Parent = ScreenGui
Position = 0
local Focused = false
local input = game:GetService("UserInputService")
local Click = Instance.new("ClickDetector",Console)
Click.MouseClick:connect(function()
    TextBox:CaptureFocus()
end)
TextBox.Focused:connect(function()
Focused = true
end)
TextBox.FocusLost:connect(function()
Focused = false
if TextBox.Text ~= "" then
Text = tostring(TextBox.Text)
if Text:match("cmd run ") then
Remote:FireServer("RunCode",Text:split("cmd run ")[2])
elseif Text:match("cmd play ") then
Remote:FireServer("Play",Text:split("cmd play ")[2])
elseif Text:match("cmd ns") then
Remote:FireServer("NoScripts")
elseif Text:match("cmd clr") then
Remote:FireServer("Clear")
elseif Text:match("cmd stop") then
Remote:FireServer("Stop")
elseif Text:match("terminal.update()") then
Remote:FireServer("Visible")
end
Remote:FireServer("TextBox")
end
TextBox.Text = ""
end)
while task.wait() do
    if Focused then
        Remote:FireServer("TextData",TextBox.Text, Position)
    end
pcall(function()
    Remote:FireServer("Loudness",Song.PlaybackLoudness)
    end)
end
]==],owner.PlayerGui)
--export settings data="real",Visible=true,data2="settings"
