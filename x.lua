-- Nocturnal By noc (Nooked.cc)
--[[
    NOOKED BY NOC v2.1
    (c) 2026 Nooked.cc Elite Mobile Framework
    Status: PROTECTED / EXECUTABLE
    Developer: lins9921
    Auth Key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIP77TaQKNx58CkcE6Jq4fb3TO6dLhzL1h/+YOgvd2OdY
]]

local function _0xNOC(data)
    local b='ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/'
    data = string.gsub(data, '[^'..b..'=]', '')
    return (data:gsub('.', function(x)
        if (x == '=') then return '' end
        local r,f='',(b:find(x)-1)
        for i=6,1,-1 do r=r..(f%2^i-f%2^(i-1)>0 and '1' or '0') end
        return r;
    end):gsub('%d%d%d%d%d%d%d%d', function(x)
        local c=0
        for i=1,8 do c=c+(x:sub(i,i)=='1' and 2^(8-i) or 0) end
        return string.char(c)
    end))
end

local _URL = _0xNOC("aHR0cDovLzEwNC4yOC4xNTIuOTk6ODA4MC92ZXJpZnk=")
local _AUTH = false

local function _UI_LOADER()
    local Nocturnal = {}
    Nocturnal.__index = Nocturnal
    function Nocturnal.CreateWindow(t)
        local g=Instance.new("ScreenGui",game:GetService("CoreGui"))
        local m=Instance.new("Frame",g)
        m.Size,m.Position,m.BackgroundColor3=UDim2.new(0,350,0,400),UDim2.new(0.5,-175,0.5,-200),Color3.fromRGB(12,12,15)
        local h=Instance.new("TextLabel",m)
        h.Size,h.BackgroundColor3,h.Text,h.TextColor3=UDim2.new(1,0,0,40),Color3.fromRGB(18,18,25),"  "..t,Color3.fromRGB(150,150,255)
        h.Font,h.TextXAlignment=Enum.Font.GothamBold,Enum.TextXAlignment.Left
        local c=Instance.new("ScrollingFrame",m)
        c.Size,c.Position,c.BackgroundTransparency=UDim2.new(1,-20,1,-50),UDim2.new(0,10,0,45),1
        c.CanvasSize,c.ScrollBarThickness=UDim2.new(0,0,2,0),0
        local l=Instance.new("UIListLayout",c)
        l.Padding=UDim2.new(0,5)
        return setmetatable({g=g,c=c},Nocturnal)
    end
    function Nocturnal:AddToggle(t,s,cb)
        local b=Instance.new("TextButton",self.c)
        b.Size,b.BackgroundColor3,b.Text=UDim2.new(1,0,0,35),s and Color3.fromRGB(45,45,90) or Color3.fromRGB(30,30,40),t..(s and " [ON]" or " [OFF]")
        b.TextColor3,b.Font=Color3.fromRGB(255,255,255),Enum.Font.Gotham
        b.MouseButton1Click:Connect(function() s=not s;b.BackgroundColor3=s and Color3.fromRGB(45,45,90) or Color3.fromRGB(30,30,40);b.Text=t..(s and " [ON]" or " [OFF]");cb(s) end)
    end
    return Nocturnal
end

local function _START_AUTH()
    local Http = game:GetService("HttpService")
    local kgui = Instance.new("ScreenGui", game:GetService("CoreGui"))
    local frame = Instance.new("Frame", kgui)
    frame.Size,frame.Position,frame.BackgroundColor3=UDim2.new(0,300,0,220),UDim2.new(0.5,-150,0.5,-110),Color3.fromRGB(15,15,18)
    local title = Instance.new("TextLabel", frame)
    title.Size,title.Text,title.TextColor3,title.BackgroundTransparency=UDim2.new(1,0,0,40),"NOOKED AUTH",Color3.fromRGB(200,200,255),1
    local box = Instance.new("TextBox", frame)
    box.Size,box.Position,box.PlaceholderText=UDim2.new(0.8,0,0,40),UDim2.new(0.1,0,0.25,0),"Paste Key Here"
    local sub = Instance.new("TextButton", frame)
    sub.Size,sub.Position,sub.Text=UDim2.new(0.8,0,0,40),UDim2.new(0.1,0,0.5,0),"AUTHENTICATE"
    local copy = Instance.new("TextButton", frame)
    copy.Size,copy.Position,copy.Text=UDim2.new(0.8,0,0,30),UDim2.new(0.1,0,0.75,0),"Get Key (Discord)"
    sub.MouseButton1Click:Connect(function()
        sub.Text = "Connecting..."
        task.spawn(function()
            local s, r = pcall(function() 
                return game:HttpGet(_URL .. "?key=" .. box.Text, true) 
            end)
            
            if s then
                local ok, json = pcall(Http.JSONDecode, Http, r)
                if ok and json and json.status == "success" then
                    _AUTH = true; kgui:Destroy()
                    return
                end
            end

            -- Se chegou aqui, falhou. r contém o erro técnico.
            sub.Text = "RETRY"
            warn("[NOC-DEBUG] Error: " .. tostring(r))
            box.Text = ""
            box.PlaceholderText = "Check F9 Console"
        end)
    end)
    copy.MouseButton1Click:Connect(function() 
        if setclipboard then 
            setclipboard("https://discord.gg/kxmj9rPNP") 
            copy.Text = "Link Copied!"
            task.delay(2, function() copy.Text = "Get Key (Discord)" end)
        end 
    end)
end

task.spawn(function()
    _START_AUTH()
    repeat task.wait() until _AUTH
    
    local _INTERNAL = _0xNOC("bG9jYWwgdl9DID0ge0FpbUVuYWJsZWQ9dHJ1ZSxUcmlnZ2VyYm90PWZhbHNlLFByZWRpY3Rpb249dHJ1ZSxCdWxsZXRTcGVlZD0xMDAwLEZPVj0xMjAsQWltUGFydD0iSGVhZCIsRGFtYWdlTW9kPTEuMixXYWxsQ2hlY2s9dHJ1ZSxVdGlsaXR5PXtIaXRTb3VuZD10cnVlfX0KbG9jYWwgTm9jdHVybmFsID0gX1VJX0xPQURFUigpCmxvY2FsIGxpYiA9IE5vY3R1cm5hbC5DcmVhdGVXaW5kb3coIk5PT0tFRCBCWSBOT0MiKQpsaWI6QWRkVG9nZ2xlKCJBaW1ib3QgTWFzdGVyIiwgdl9DLkFpbUVuYWJsZWQsIGZ1bmN0aW9uKHYpIHZfQy5BaW1FbmFibGVkID0gdiBlbmQpCmxpYjpBZGRUb2dnbGUoIlRyaWdnZXJib3QiLCB2X0MuVHJpZ2dlcmJvdCwgZnVuY3Rpb24odikgdl9DLlRyaWdnZXJib3QgPSB2IGVuZCkKbG9jYWwgdV9VPWdhbWU6R2V0U2VydmljZSgiUnVuU2VydmljZSIpCmxvY2FsIHBfUD1nYW1lOkdldFNlcnZpY2UoIlBsYXllcnMiKQpsb2NhbCB3X1dTPWdhbWU6R2V0U2VydmljZSgiV29ya3NwYWNlIikKbG9jYWwgcF9MTD1wX1AuTG9jYWxQbGF5ZXIKbG9jYWwgY19DQT13X1dTLkN1cnJlbnRDYW1lcmEKbG9jYWwgdF9USCx0X1RTUCxsX0xQLG1fTUQ9bmlsLG5pbCxuaWwsMTUwMAp1X1UuSGVhcnRiZWF0OkNvbm5lY3QoZnVuY3Rpb24oKQpjX0NBPXdfV1MuQ3VycmVudRDYW1lcmEKbG9jYWwgY3A9Y19DQS5DRnJhbWUuUG9zaXRpb24KbG9jYWwgY2w9Y19DQS5DRnJhbWUuTG9va1ZlY3RvcgppZiBsX0xQIGFuZCBsX0xQLkNoYXJhY3RlciB0aGVuCmxvY2FsIGg9bF9MUC5DaGFyYWN0ZXI6RmluZEZpcnN0Q2hpbGQodl9DLkFpbVBhcnQpCmlmIGggdGhlbgp0X1RIPWgKbG9jYWwgcG9zLG9uPWNfQ0E6V29ybGRUb1ZpZXdwb3J0UG9pbnQoaC5Qb3NpdGlvbikKaWYgb24gdGhlbiB0X1RTUD1WZWN0b3IyLm5ldyhwb3MuWCxwb3MuWSkgZWxzZSBsX0xQPW5pbCBlbmQKcmV0dXJuCmVuZAplbmQKbG9jYWwgYmVzdCxkaXN0PW5pbCxtYXRoLmh1Z2UKZm9yIF8scCBpbiBwYWlycyhwX1A6R2V0UGxheWVycygpKWRvCmlmIHA9fnBfTEwgYW5kIHAuQ2hhcmFjdGVyIHRoZW4KbG9jYWwgaD1wLkNoYXJhY3RlcjpGaW5kRmlyc3RDaGlsZCh2X0MuQWltUGFydCkKaWYgaCB0aGVuCmxvY2FsIGQ9KGguUG9zaXRpb24tY3ApLk1hZ25pdHVkZQpsb2NhbCBkb3Q9KGguUG9zaXRpb24tY3ApLlVuaXQ6RG90KGNsKQppZiBtYXRoLmRlZyhtYXRoLmFjb3MoZG90KSk8PSh2X0MuRk9WLzIpIGFuZCBkPGRpc3QgdGhlbiBkaXN0LGJlc3Q9ZCxwIGVuZAplbmQKZW5kCmVuZAppZiBiZXN0IHRoZW4KbF9MUD1iZXN0CnRfVEg9YmVzdC5DaGFyYWN0ZXI6RmluZEZpcnN0Q2hpbGQodl9DLkFpbVBhcnQpCmxvY2FsIHBvcz1jX0NBOldvcmxkVG9WaWV3cG9ydFBvaW50KHRfVEguUG9zaXRpb24pCnRfVFNQPVZlY3RvcjIubmV3KHBvcy5YLHBvcy5ZKQplbHNlIGxfTFAsdF9USCx0X1RTUD1uaWwsbmlsLG5pbCBlbmQKZW5kKQpob29rbWV0YW1ldGhvZChnYW1lLCJfX2luZGV4IixuZXdjY2xvc3VyZShmdW5jdGlvbihzLGksLi4uKQppZiB2X0MuQWltRW5hYmxlZCBhbmQgdF9UU1AgYW5kIGkgPT0gIlZpZXdwb3J0U2l6ZSIgYW5kIHMgPT0gY19DQSB0aGVuIHJldHVybiB0X1RTUCBlbmQKcmV0dXJuIG9sZElkeChzLGksLi4uKSBlbmQpKQ==")
    
    -- Execute Protected Core
    local s, r = pcall(function()
        return loadstring(_INTERNAL)()
    end)
    if not s then warn("Nocturnal Core Error: " .. tostring(r)) end
end)
