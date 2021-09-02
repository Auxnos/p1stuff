local parts = {}
where = owner.Character.Head.CFrame * CFrame.new(0,-3,0)
for i = 1, 6 do
    task.wait()
    local part = Instance.new("SpawnLocation",script)
    part.Material = "SmoothPlastic"
    part.Anchored = true
    part.Size = Vector3.new(1,0.2,1)
    part.CFrame = where*CFrame.new(i,0,0)
    part.Neutral = false
    parts[#parts+1] = part
end
for v2 = 1,5 do
    for i = 1, 6 do
        task.wait()
        local part = Instance.new("SpawnLocation",script)
        part.Material = "SmoothPlastic"
        part.Anchored = true
        part.Size = Vector3.new(1,0.2,1)
        part.CFrame = where*CFrame.new(i,0,-v2)
        part.Neutral = false
        parts[#parts+1] = part
    end
end

rgb = false
red = false
green = false
blue = false
owner.Chatted:connect(function(msg)
    if msg == "$rainbow" then
        rgb = not rgb
    elseif msg == "$red" then
        red = not red
    elseif msg == "$green" then
        green = not green
    elseif msg == "$blue" then
        blue = not blue
    end
end)
basecframes = {}
wait(0.5)
for i,v in pairs(parts) do
    basecframes[i] = v.CFrame
end
wait(0.1)
task.spawn(function()
    while task.wait() do
        for i,v in pairs(parts) do
            v.CFrame = basecframes[i]*CFrame.new(0,(i/42)*math.sin((tick()*30)/45),0)
        end
    end
end)
while task.wait() do
    for i,v in pairs(parts) do
        if rgb then
            game:GetService("TweenService"):Create(v,TweenInfo.new((i/16)),{
                Color = Color3.fromHSV((tick()%15/15),1,1)
            }):Play()
        elseif red then
            game:GetService("TweenService"):Create(v,TweenInfo.new(1),{
                Color = Color3.new(i,0,0)
            }):Play()
            task.wait()
        elseif green then
            game:GetService("TweenService"):Create(v,TweenInfo.new(1),{
                Color = Color3.new(0,i,0)
            }):Play()
            task.wait()
        elseif blue then
            game:GetService("TweenService"):Create(v,TweenInfo.new(1),{
                Color = Color3.new(0,0,i)
            }):Play()
            task.wait()
        end
    end
end
