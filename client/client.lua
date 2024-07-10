QBCore = exports[Config.CoreName]:GetCoreObject()
function SendReactMessage(action, data)
  SendNUIMessage({
    action = action,
    data = data
  })
end

local checkState = false
local var = ""
local var2 = ""
local RandomUrl = true
local started = false


-- local function TurnOnLoop()
--   if RandomUrl then
--     RandomUrl = false
--   else
--     -- TriggerServerEvent('NuiBlocker:KickPlayer3')
--   end
--   Wait(Config.WaitTime)
--   SetTimeout(50, TurnOnLoop())
-- end
local function IsUrlBlockCheck()
  started = true
  SendReactMessage('IsUrlBlockCheck', true)
  Wait(Config.WaitTime)
  SetTimeout(50, IsUrlBlockCheck())
end

AddEventHandler('onResourceStart', function(resource)
  if resource == GetCurrentResourceName() then
    -- TurnOnLoop()
    IsUrlBlockCheck()
  end
end)
AddEventHandler("playerSpawned", function()
  if not checkState then
    if NetworkIsSessionStarted() then
      -- CheckNuiDevTool()
      -- RegisterNUICallbacks()
      IsUrlBlockCheck()
      -- TurnOnLoop()
    end
    checkState = true
  end
end)

-- function CheckNuiDevTool()
--   var = QBCore.Shared.RandomStr(10) .. math.random(11111, 99999)
--   var2 = QBCore.Shared.RandomStr(10) .. math.random(11111, 99999)
--   SetTimeout(200, function()
--     SendReactMessage('CheckRequest', {
--       varone = var,
--       vartwo = var2,
--     })
--   end)
-- end

-- RegisterCommand('checkNuiDevTool', function()
--   CheckNuiDevTool()
-- end)

-- NUI Callbacks But With A Delay
-- function RegisterNUICallbacks()
--   SetTimeout(300, function()
--     RegisterNUICallback(var, function(data, cb)
--       TriggerServerEvent('NuiBlocker:KickPlayer')
--       cb("ok")
--     end)
--     RegisterNUICallback(var2, function(data, cb)
--       TriggerServerEvent('NuiBlocker:KickPlayer2')
--       cb("ok")
--     end)
--   end)
-- end

RegisterNUICallback("CheckWorking", function(data, cb)
  RandomUrl = data.data
  if data.isUrlBlocked then
    TriggerServerEvent('NuiBlocker:KickPlayer')
  end
  cb("ok")
end)
-- RegisterNuiCallback('', function(data, cb)
--   TriggerServerEvent('NuiBlocker:KickPlayer2')
--   cb("ok")
-- end)
CreateThread(function()
  while true do
    Wait(Config.WaitTime2)
    -- print(RandomUrl, "RandomUrl")
    if started then
      if RandomUrl then
        RandomUrl = false
      else
        print("Kick")
        TriggerServerEvent('NuiBlocker:KickPlayer3')
      end
    end
  end
end)
