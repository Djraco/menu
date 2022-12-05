-----Globals-----
local Teleporter
local Closed
local Open
local CloseTitle
local Main
local Close
local TpPlayer
local PlayerList
local List
local PLAYERNAME
local Search

-----Defaults-----
local MAIN_OPEN = true
local PLAYERLIST_OPEN = false
local PLAYERLIST_POS = UDim2.new(0.169, 0, 0.415, 0)

local function setDraggable(p)
	local s = Instance.new('LocalScript', p)
	s.Parent.Selectable = true
	s.Parent.Draggable = true
	s.Parent.Active = true
end

function lua()
	local Players = game:GetService("Players")
	local me = game.Players.LocalPlayer
	local plrs = game.Players:GetChildren()
	
-----Instances-----
	Teleporter = Instance.new("ScreenGui", game.Players.LocalPlayer.PlayerGui)

	Closed = Instance.new("Frame", Teleporter)
	Open = Instance.new("TextButton", Closed)
	CloseTitle = Instance.new("TextLabel", Closed)

	Main = Instance.new("Frame", Teleporter)
	Close = Instance.new("TextButton", Main)
	TpPlayer = Instance.new("TextButton", Main)

	PlayerList = Instance.new("Frame", Teleporter)
	List = Instance.new("ScrollingFrame", PlayerList)
	PLAYERNAME = Instance.new("TextButton", List)
	Search = Instance.new("TextBox", PlayerList)

-----Properties-----
	Teleporter.Name = "Teleporter"

	Closed.Name = "Closed"
	Closed.Position = UDim2.new(0.027, 0, 0.926, 0)
	Closed.Size = UDim2.new(0, 184, 0, 13)
	Closed.Visible = false
	Closed.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	Closed.BackgroundTransparency = 0.7
	Closed.Visible = not MAIN_OPEN

	Open.Name = "Open"
	Open.Position = UDim2.new(0.929, 0, 0, 0)
	Open.Size = UDim2.new(0, 13, 0, 13)
	Open.Text = "^"
	Open.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	Open.MouseButton1Click:Connect(function()
		Main.Visible = true
		Closed.Visible = false
	end)

	CloseTitle.Name = "CloseTitle"
	CloseTitle.Position = UDim2.new(0, 0, 0, 0)
	CloseTitle.Size = UDim2.new(0, 170, 0, 13)
	CloseTitle.Text = "Teleporter"
	CloseTitle.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	CloseTitle.BackgroundTransparency = 0.7

	Main.Name = "Main"
	Main.Position = UDim2.new(0.027, 0, 0.388, 0)
	Main.Size = UDim2.new(0, 184, 0, 350)
	Main.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	Main.BackgroundTransparency = 0.7
	Main.BorderColor3 = Color3.new(0, 0, 0)
	Main.BorderSizePixel = 3
	Main.Visible = MAIN_OPEN

	Close.Name = "Close"
	Close.Position = UDim2.new(0.929, 0, 0, 0)
	Close.Size = UDim2.new(0, 13, 0, 13)
	Close.Text = "v"
	Close.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	Close.MouseButton1Click:Connect(function()
		Main.Visible = false
		Closed.Visible = true
		Closed.Position = UDim2.new(Main.Position.X, Main.Position.Height+Main.Position.Height) --0.509
	end)

	TpPlayer.Name = "TpPlayer"
	TpPlayer.Position = UDim2.new(0.094, 0, 0.046, 0)
	TpPlayer.Size = UDim2.new(0, 149, 0, 33)
	TpPlayer.Text = "Player"
	TpPlayer.MouseButton1Click:Connect(function()
		if PlayerList.Visible == false then
			PlayerList.Visible = true
		else 
			PlayerList.Visible = false
		end
	end)

	PlayerList.Name = "PlayerList"
	PlayerList.Position = PLAYERLIST_POS
	PlayerList.Size = UDim2.new(0, 156, 0, 333)
	PlayerList.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	PlayerList.BackgroundTransparency = 0.7
	PlayerList.BorderColor3 = Color3.new(0, 0, 0)
	PlayerList.BorderSizePixel = 3
	PlayerList.Visible = PLAYERLIST_OPEN

	List.Name = "List"
	List.Position = UDim2.new(0, 0, 0.119, 0)
	List.Size = UDim2.new(0, 156, 0, 293)
	List.BackgroundColor3 = Color3.new(0.737255, 0.737255, 0.737255)
	List.BackgroundTransparency = 0.7
	List.BorderColor3 = Color3.new(0, 0, 0)

	PLAYERNAME.Name = "PLAYERNAME"
	PLAYERNAME.Position = UDim2.new(0, 0, 0, 0)
	PLAYERNAME.Size = UDim2.new(0, 145, 0, 25)
	PLAYERNAME.Visible = false

	Search.Name = "Search"
	Search.Position = UDim2.new(0.058, 0, 0.019, 0)
	Search.Size = UDim2.new(0, 136, 0, 25)
	Search.Text = "Search"
	
-----Add players to PlayerList-----
	for i,v in pairs(plrs) do
		local name = tostring(v)
		if name ~= me.Name then --doesn't add your username
			local label = PLAYERNAME:Clone()
			label.Parent = List
			label.Name = name
			label.Text = Players:FindFirstChild(name).DisplayName
			label.Visible = true
			PLAYERNAME.Position = UDim2.new(0, 0, 0, PLAYERNAME.Position.Y.Offset + 25)

			label.MouseButton1Click:Connect(function() me.Character:MoveTo(game.Workspace:FindFirstChild(name).HumanoidRootPart.Position)end)
		end
	end
	
-----Makes GUIs draggable-----
	for i, v in pairs(Teleporter:GetChildren()) do
		if (v.Name ~= "penis") and (v.Name ~= "Closed") then
			coroutine.wrap(setDraggable)(Teleporter:FindFirstChild(v.Name))
		end
	end

end

-----Refresh every 10 seconds-----
while true do
	lua()
	wait(10)
	MAIN_OPEN = Main.Visible
	PLAYERLIST_OPEN = PlayerList.Visible
	PLAYERLIST_POS = PlayerList.Position
	Teleporter:Destroy()
	
	print("refreshed")
end

--Teleporter.Parent = game.CoreGui