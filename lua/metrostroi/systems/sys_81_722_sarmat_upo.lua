--------------------------------------------------------------------------------
-- 81-722 NPP Sarmat "BMCIK-01" announcer system
--------------------------------------------------------------------------------
-- Copyright (C) 2013-2021 Metrostroi Team & FoxWorks Aerospace s.r.o.
-- Contains proprietary code. See license.txt for additional information.
--------------------------------------------------------------------------------
Metrostroi.DefineSystem("81_722_BMCIK_01")
TRAIN_SYSTEM.DontAccelerateSimulation = true

function TRAIN_SYSTEM:Initialize()
    self.TriggerNames = {
        "SarmatUp",
        "SarmatDown",
        "SarmatEnter",
        "SarmatEsc",
        "SarmatF1",
        "SarmatF2",
        "SarmatF3",
        "SarmatF4",
        "SarmatPath",
        "SarmatLine",
        "SarmatZero",
        "SarmatStart",
    }
    self.Triggers = {}
    for k,v in pairs(self.TriggerNames) do
        self.Train:LoadSystem(v,"Relay","Switch")
		self.Triggers[v] = false
	end
    
    self.State = 0
    self.WagonNum = 0
    self.Brightness = 1
    
    self.AnnState = 0
    self.AnnLine = 0
    self.AnnPath = false
    self.AnnLimitStation = 0
    self.AnnOnStation = false
    self.AnnRoute = 0
    self.AnnMode = 3
    self.AnnTrainTrain = false
    self.BITTime = false
    self.Selected = 0
    self.UPOActive = 1
    self.LineOut = 0
    
    self.CamPage = 0
    
    self.CamFullscreen = 0
    self.CamWagon = 1
end

function TRAIN_SYSTEM:Outputs()
    return {"UPOActive","LineOut"}
end

function TRAIN_SYSTEM:Inputs()
    return {}
end

if TURBOSTROI then return end
TRAIN_SYSTEM.SettingsList = {
    "Ввод номера маршрута",
    "Режимы работы информатора",
    "Режимы работы блока СБУЦИК",
    "Настройка громкости",
    "Информация",
    "Диагностика",
    "Язык",
    "Время на БИТ"
}
TRAIN_SYSTEM.AnnModeList = {
    "Режим 'Информатор'",
    "Режим 'УПО+Информатор'",
    "Режим 'УПО+Информатор+Пуск'",
    "Режим 'УПО'"
}
TRAIN_SYSTEM.AnnVolumeList = {
    "Громкость инф. в кабине",
    "Громкость инф. в салоне",
    "Громкость УПО в кабине",
    "Громкость УПО в салоне",
    "Громкость ЭКСТР./МЕЖКАБ.",
    "Увеличение при V>5 на"
}
TRAIN_SYSTEM.InfoList = {
    {"MIES firmware version 20170622",nil},
    {"NIIP DOORS_closed= ","BMCIS:Doors"},
    {"NIIP RUCHKA= ",nil},
    {"NIIP SPEED= ","BMCIS:Speed"},
    {"NIIP UPO_STATE= ","BMCIS:UPOState"},
    {"NIIP Evacuation= ",nil},
    {"NIIP Vzlom_kabiny= ",nil},
    {"Video sended= ","BMCIS:VideoSended"}
}
TRAIN_SYSTEM.DiagList = {
    "Advanced LAN diagnostics",
    "Advanced CAN diagnostics",
    "BMCIK 0/0",
    "MIES 0/0",
    "MDU 0/0",
    "MAR 0/0",
    "BES LAN 0/0",
    "BES CAN 0/0",
    "BNT(BUM) 0/0",
    "BIT 0/0",
    "BVK 0/0",
    "BMTS 0/0",
}
TRAIN_SYSTEM.LangList = {
    "Russian",
    -- "English",
    -- "Hungarian",
}
TRAIN_SYSTEM.BITTimeList = {
    "Время выключено",
    "Время включено",
}

--[[
TODO:
    1) Логика информатора
    2) Настройка громкости
    3) Сигнал ПГК
    4) Настройка времени на БИТ
DONE:
    1) Обработка кнопок
    2) Система видеонаблюдения
]]

if SERVER then
    local function InRange(px,py,x,y,w,h)
        return (px >= x and px <= (x+w) and py >= y and py <= (y+h))
    end
    function TRAIN_SYSTEM:Touch(value,x,y)
        x,y = x*1.25,y*1.25
        local btnID = 0
        local newPage = false
        local lastFullscr = self.CamFullscreen
        ---- Cameras ------------------
        if self.CamPage == 0 then
            if InRange(x,y,95,183,140,60,"Левые") then
                btnID = 1
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 1
                    newPage = true
                end
            elseif InRange(x,y,241,183,140,60,"Передние") then
                btnID = 2
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 2
                    newPage = true
                end
            elseif InRange(x,y,387,183,140,60,"Вокруг") then
                btnID = 3
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 3
                    newPage = true
                end
            elseif InRange(x,y,533,183,140,60,"Задние") then
                btnID = 4
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 4
                    newPage = true
                end
            elseif InRange(x,y,679,183,140,60,"Правые") then
                btnID = 5
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 5
                    newPage = true
                end
            elseif InRange(x,y,215,463,140,60,"Вагон 1") then
                btnID = 21
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 8
                    newPage = true
                end
            elseif InRange(x,y,559,463,140,60,"Вагон 8") then
                btnID = 22
                if not value then
                    self.CamWagon = self.WagonNum
                    self.CamPage = 8
                    newPage = true
                end
            elseif InRange(x,y,215,603,140,60,"Вагон 1") then
                btnID = 31
                if not value then
                    self.CamWagon = 1
                    self.CamPage = 9
                    newPage = true
                end
            elseif InRange(x,y,559,603,140,60,"Вагон 8") then
                btnID = 32
                if not value then
                    self.CamWagon = self.WagonNum
                    self.CamPage = 9
                    newPage = true
                end
            else
                local WagNum = self.WagonNum
                for i=1,WagNum do
                    if WagNum > 6 then
                        if InRange(x,y,350+(i-WagNum/2)*110,323,104,60) then
                            btnID = 10+i
                            if not value then
                                self.CamWagon = i
                                self.CamPage = #self.CameraTbl[i] > 2 and 6 or 1
                                newPage = true
                            end
                        end
                    else
                        if InRange(x,y,313+(i-WagNum/2)*147,323,141,60) then
                            btnID = 10+i
                            if not value then
                                self.CamWagon = i
                                self.CamPage = #self.CameraTbl[i] > 2 and 6 or 1
                                newPage = true
                            end
                        end
                    end
                end
            end
        elseif self.CamPage > 0 then
            if not value and self.CamFullscreen == 0 then
                local camCountPage = #self.CameraTbl[self.CamWagon][self.CamPage] or 0
                if camCountPage == 4 then
                    if InRange(x,y,24,57,431,329) then
                        self.CamFullscreen = 1
                    elseif InRange(x,y,24,391,431,329) then
                        self.CamFullscreen = 2
                    elseif InRange(x,y,460,57,431,329) then
                        self.CamFullscreen = 3
                    elseif InRange(x,y,460,391,431,329) then
                        self.CamFullscreen = 4
                    end
                elseif camCountPage == 2 then
                    if InRange(x,y,24,57,431,663) then
                        self.CamFullscreen = 1
                    elseif InRange(x,y,460,57,431,663) then
                        self.CamFullscreen = 2
                    end
                end
            end
        end
        
        ---- Other --------------------
        if InRange(x,y,10,742,218,48,"Esc") then
            btnID = 41
            if value and self.CamPage > 0 then
                if self.CamFullscreen > 0 then
                    self.CamFullscreen = 0
                else
                    self.CamPage = 0
                    self.CamWagon = 1
                    for i=1,4 do
                        self["Cam"..i] = nil
                        self["Cam"..i.."E"] = NULL
                    end
                end
            end
        elseif InRange(x,y,234,742,217,48,"<-") then
            btnID = 42
            if value then
                -- if self.CamPage == 0 then self.CamPage = 1 self.CamWagon = 1 end
                self.CamPage = self.CamPage-1
                if self.CamPage < 1 then
                    self.CamWagon = self.CamWagon-1
                    if self.CamWagon < 1 then self.CamWagon = self.WagonNum end
                    self.CamPage = self.CameraTbl[self.CamWagon].countPages
                end
                self.CamFullscreen = 0
                newPage = true
            end
        elseif InRange(x,y,457,742,218,48,"->") then
            btnID = 43
            if value then
                self.CamPage = self.CamPage + 1
                if self.CamPage > self.CameraTbl[self.CamWagon].countPages then
                    self.CamWagon = self.CamWagon + 1
                    self.CamPage = 1
                    if self.CamWagon > self.WagonNum then self.CamWagon = 1 end
                end
                self.CamFullscreen = 0
                newPage = true
            end
        elseif InRange(x,y,911,9,119,32,"☼") then
            btnID = 44
            if value then
                self.Brightness = self.Brightness - 0.2
                if self.Brightness < 0.2 then self.Brightness = 1 end
                self.Train:SetNW2Float("BMCIK:Brightness",self.Brightness)
            end
        end
        
        if lastFullscr ~= self.CamFullscreen then
            self.Train:SetNW2Int("BMCIK:CamFullscreen",self.CamFullscreen)
        end
        if newPage then
            for i=1,4 do
                    self["Cam"..i] = CurTime()+math.Rand(0.2,1)
                    self["Cam"..i.."E"] = self.CameraTbl[self.CamWagon][self.CamPage][i]
                if i > #self.CameraTbl[self.CamWagon][self.CamPage] then
                    self["Cam"..i] = nil
                    self["Cam"..i.."E"] = NULL
                end
            end
            self.Train:SetNW2Vector("BMCIK:CamInfo",Vector(self.CameraTbl[self.CamWagon].wagNum,self.CameraTbl[self.CamWagon].wagType,self.CameraTbl[self.CamWagon].countPages))
        end
        self.Train:SetNW2Int("BMCIK:IDTouched",value and btnID or 0)
    end
    function TRAIN_SYSTEM:Trigger(name,value)
        local Train = self.Train
        name = name:gsub("Sarmat","")
        if self.AnnState == 0 then
            if not Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer",1)] then return end
            if value and name == "Zero" then
                if self.ZeroBtnTimer and self.ZeroBtnTimer > CurTime() then
                    self.AnnState = 15
                    self.Selected = 1
                    self.ZeroBtnTimer = nil
                end
                if not self.ZeroBtnTimer then self.ZeroBtnTimer = CurTime()+0.25 end
            end
        elseif self.AnnState == 1 then
            if value then
                local sTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer",1)][self.AnnLine]
                if name == "Up" then
                    self:Prev()
                end
                if name == "Down" then
                    self:Next()
                end
                if name == "Esc" then
                    if self.EscBtnTimer and self.EscBtnTimer > CurTime() then
                        self.AnnState = 14
                        self.Selected = 1
                        self.EscBtnTimer = nil
                    end
                    if not self.EscBtnTimer then self.EscBtnTimer = CurTime()+0.25 end
                end
                if name == "Start" then
                    -- пуск записи работает только когда открыта вкладка со станциями
                    if self.AnnMode < 4 then self:Play() end
                end
                if name == "F1" then self.AnnState = 11 self.Selected = 1 self.LastSelected = self.Selected self.LastListOffset = self.ListOffset end
                if name == "F2" then self.AnnState = 12 self.Selected = 1 self.LastSelected = self.Selected self.LastListOffset = self.ListOffset end
                if name == "F3" then self.AnnState = 13 self.Selected = 1 self.LastSelected = self.Selected self.LastListOffset = self.ListOffset end
                if name == "F4" then self.AnnState = 2  self.Selected = 1 self.LastSelected = self.Selected self.LastListOffset = self.ListOffset end
                if name == "Zero" then
                    if self.ZeroBtnTimer and self.ZeroBtnTimer > CurTime() then
                        self.AnnState = 15
                        self.Selected = 1
                        self.ZeroBtnTimer = nil
                    end
                    if not self.ZeroBtnTimer then self.ZeroBtnTimer = CurTime()+0.25 end
                end
            end
        elseif self.AnnState == 14 then
            if name == "Esc" then self.AnnState = 1 self.Selected = self.LastSelected self.ListOffset = self.LastListOffset end
        elseif self.AnnState == 15 then
            if value then
                local lTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer",1)]
                if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                if name == "Down" then self.Selected = math.min(#lTbl,self.Selected+1) end
                if name =="Enter" then self.AnnLine=self.Selected self.Selected=1 self.AnnState=1 end
            end
        elseif self.AnnState == 2 then
            if value then
                if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                if name == "Down" then self.Selected = math.min(#self.SettingsList,self.Selected+1) end
                if name =="Enter" then self.AnnState = 20+self.Selected self.Selected = 1 end
            end
        elseif self.AnnState > 20 then
            if self.AnnState == 21 then
                if value and name == "Esc" then self.AnnState = 2 end
            elseif self.AnnState == 22 then
                if value then
                    if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    if name == "Down" then self.Selected = math.min(#self.AnnModeList,self.Selected+1) end
                    if name =="Enter" then self.AnnMode = self.Selected end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 2 end
                end
            elseif self.AnnState == 23 then
                if value then
                    if name == "Enter" and not self.AnnTrainTrain then self.AnnTrainTrain = true end
                    if name == "Esc" and not self.AnnTrainTrain then self.AnnState = 2 self.Selected = 3 end
                    if (name == "Esc" or name == "Zero") and self.AnnTrainTrain then self.AnnTrainTrain = false end
                end
                Train:SetNW2Bool("BMCIK:TrainTrain",self.AnnTrainTrain)
            elseif self.AnnState == 24 then
                if value then
                    if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    if name == "Down" then self.Selected = math.min(#self.AnnVolumeList,self.Selected+1) end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 4 end
                end
            elseif self.AnnState == 25 then
                if value then
                    if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    if name == "Down" then self.Selected = math.min(#self.InfoList,self.Selected+1) end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 5 end
                end
            elseif self.AnnState == 26 then
                if value then
                    if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    if name == "Down" then self.Selected = math.min(#self.DiagList,self.Selected+1) end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 6 end
                end
            elseif self.AnnState == 27 then
                if value then
                    -- if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    -- if name == "Down" then self.Selected = math.min(#self.LangList,self.Selected+1) end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 7 end
                end
            elseif self.AnnState == 28 then
                if value then
                    if name ==  "Up"  then self.Selected = math.max(1,self.Selected-1) end
                    if name == "Down" then self.Selected = math.min(#self.BITTimeList,self.Selected+1) end
                    if name =="Enter" then self.BITTime = self.Selected == 2 end
                    if name == "Esc"  then self.AnnState = 2 self.Selected = 8 end
                end
            end
        end
        
        -- Debug reset
        if value and name == "Line" then self:MemReset(true) end
    end
    
    function TRAIN_SYSTEM:Next()
        -- TODO: Сделать логику для листания станций
        print("self:Next()")
    end
    
    function TRAIN_SYSTEM:Prev()
        print("self:Prev()")
    end
    
    function TRAIN_SYSTEM:Play()
        print("self:Play()")
    end
    function TRAIN_SYSTEM:MemReset(annReset)
        self.State = 0
        self.AnnState = 0
        self.Selected = 0
        self.CamPage = 0
        self.CameraTbl = nil
        for i=1,4 do
            self["Cam"..i] = nil
            self["Cam"..i.."E"] = NULL
        end
        self.UPOActive = 0
        self.LineOut = 0
        for k,v in pairs(self.TriggerNames) do
            self:Trigger(v,false)
            self.Triggers[v] = false
        end
        self.Train:SetNW2Int("BMCIK:IDTouched",0)
        self.Train:SetNW2Int("BMCIK:CamFullscreen",0)
        self.ZeroBtnTimer = nil
        self.CamFullscreen = 0
        self.CamWagon = 1
        self.AnnTrainTrain = false
        if annReset then
            self.AnnLine = 0
            self.AnnPath = false
            self.AnnStation = 0
            self.AnnOnStation = false
            self.AnnRoute = 0
            self.AnnMode = 3
            self.BITTime = false
        end
    end
    function TRAIN_SYSTEM:Think(dT)
        local Train = self.Train
        local Power = Train.Electric.Power > 0 and (Train.SF16.Value + Train.SF17.Value) > 0
        if Power then
            if self.State == 0 then
                self.State = -2
                self.LoadingTimer = CurTime()+math.Rand(5,7)
            end
            
            if self.State < 0 and CurTime() > self.LoadingTimer then
                if self.State == -6 then
                    self.State = -5
                    self.LoadingTimer = CurTime()+math.Rand(0.9,1.5)
                elseif self.State == -5 then
                    self.State = -4
                    self.LoadingTimer = CurTime()+2
                elseif self.State == -4 then
                    self.State = -3
                    self.LoadingTimer = CurTime()+math.Rand(9,12)
                elseif self.State == -3 then
                    self.State = -2
                    self.LoadingTimer = CurTime()+math.Rand(1,3)
                elseif self.State == -2 then
                    self.State = -1
                    self.LoadingTimer = CurTime()+math.Rand(2,3)
                elseif self.State == -1 then
                    self.State = 1
                    self.CAN_SU = CurTime()
                    self.WagonNum = #Train.WagonList
                    self.CameraTbl = {}
                    -- Generating cameras table
                    for k,v in pairs(Train.WagonList) do
                        local wagType = math.floor(v:GetWagonNumber() / 1000)
                        if wagType == 22 then
                            local lastWag = Train.WagonList[k==1 and self.WagonNum or 1]
                            self.CameraTbl[k] = {
                                wagNum = v:GetWagonNumber(),
                                wagType = 1,
                                countPages = 9,
                                {v,lastWag},-- [1]Левые
                                {v,v},      -- [2]Передние
                                {v,lastWag,v,lastWag}, -- [3]Вокруг
                                {lastWag,lastWag}, -- [4]Задние
                                {v,lastWag},-- [5]Правые
                                {v,v,v,v},  -- [6]Салон (БИТ)
                                {v,v},      -- [7]Салон (БЭС)
                                {v},        -- [8]Кабина
                                {v}         -- [9]Путевая
                            }
                        elseif wagType > 22 then
                            self.CameraTbl[k] = {
                                wagNum = v:GetWagonNumber(),
                                wagType = 2,
                                countPages = 2,
                                {v,v,v,v},
                                {v,v},
                            }
                        end
                    end
                    self.LoadingTimer = nil
                    Train:SetNW2Int("BMCIK:WagNum",self.WagonNum)
                end
            end
            
            if self.State == 1 then
                ---- Cameras --------------------
                if self.CamPage > 0 then
                    local cam1,cam2,cam3,cam4 = false,false,false,false
                    for i=1,self.WagonNum do
                        local train = Train.WagonList[i]
                        if self.Cam1 and self.Cam1E == train then cam1 = true end
                        if self.Cam2 and self.Cam2E == train then cam2 = true end
                        if self.Cam3 and self.Cam3E == train then cam3 = true end
                        if self.Cam4 and self.Cam4E == train then cam4 = true end
                    end
                    if self.Cam1 == true and (not IsValid(self.Cam1E) or not cam1 or self.Cam1E.Electric.Power < 1) then self.Cam1 = false end
                    if self.Cam2 == true and (not IsValid(self.Cam2E) or not cam2 or self.Cam2E.Electric.Power < 1) then self.Cam2 = false end
                    if self.Cam3 == true and (not IsValid(self.Cam3E) or not cam3 or self.Cam3E.Electric.Power < 1) then self.Cam3 = false end
                    if self.Cam4 == true and (not IsValid(self.Cam4E) or not cam4 or self.Cam4E.Electric.Power < 1) then self.Cam4 = false end
                    if self.Cam1 == true then
                        Train:SetNW2Bool("BMCIK:Cam1C",true)
                        Train:SetNW2Entity("BMCIK:Cam1E",self.Cam1E)
                    else
                        if self.Cam1 and self.Cam1 ~= true and CurTime() > self.Cam1 then self.Cam1 = true end
                        Train:SetNW2Bool("BMCIK:Cam1C",false)
                    end
                    -- if IsValid(self.Cam1E) then Train:SetNW2Int("BMCIK:Cam1N",self.Cam1E:GetWagonNumber()) end
                    if self.Cam2 == true then
                        Train:SetNW2Bool("BMCIK:Cam2C",true)
                        Train:SetNW2Entity("BMCIK:Cam2E",self.Cam2E)
                    else
                    if self.Cam2 and self.Cam2 ~= true and CurTime() > self.Cam2 then self.Cam2 = true end
                        Train:SetNW2Bool("BMCIK:Cam2C",false)
                    end
                    -- if IsValid(self.Cam2E) then Train:SetNW2Int("SarmatCam2EN",self.Cam2E:GetWagonNumber()) end
                    if self.Cam3 == true then
                        Train:SetNW2Bool("BMCIK:Cam3C",true)
                        Train:SetNW2Entity("BMCIK:Cam3E",self.Cam3E)
                    else
                    if self.Cam3 and self.Cam3 ~= true and CurTime() > self.Cam3 then self.Cam3 = true end
                        Train:SetNW2Bool("BMCIK:Cam3C",false)
                    end
                    -- if IsValid(self.Cam3E) then Train:SetNW2Int("BMCIK:Cam3N",self.Cam3E:GetWagonNumber()) end
                    if self.Cam4 == true then
                        Train:SetNW2Bool("BMCIK:Cam4C",true)
                        Train:SetNW2Entity("BMCIK:Cam4E",self.Cam4E)
                    else
                        if self.Cam4 and self.Cam4 ~= true and CurTime() > self.Cam4 then self.Cam4 = true end
                        Train:SetNW2Bool("BMCIK:Cam4C",false)
                    end
                    -- if IsValid(self.Cam4E) then Train:SetNW2Int("BMCIK:Cam4N",self.Cam4E:GetWagonNumber()) end
                end
                
                -- Get data from Vityaz, simulate CAN delay
                if CurTime() > self.CAN_SU then
                    local BUKP = Train.BUKP
                    self.NIIPSpeed = BUKP.Speed
                    self.NIIPDoors = BUKP.LSD and 1 or 0
                    self.CAN_SU = CurTime()+0.1
                end
                
                ---- Announcer ------------------
                -- TODO: Обработка сигнала ПГК
                -- TODO: Включение камер при открытии дверей, выключение камер после 20*n(м), n - кол-во вагонов
                -- print(self.AnnState)
                if self.AnnState == 0 or self.AnnState == 1 then
                    if self.ZeroBtnTimer and CurTime() > self.ZeroBtnTimer then
                        if self.AnnLine > 0 then self.AnnState = 1 end
                        self.ZeroBtnTimer = nil
                    end
                elseif self.AnnState == 22 then
                    Train:SetNW2Int("BMCIK:AnnMode",self.AnnMode)
                elseif self.AnnState == 25 then
                    Train:SetNW2Int("BMCIS:Doors",self.NIIPDoors)
                    Train:SetNW2Int("BMCIS:Speed",self.NIIPSpeed)
                    Train:SetNW2Int("BMCIS:VideoSended",(self.Cam1==true or self.Cam2==true or self.Cam3==true or self.Cam4==true) and 1 or 0)
                end
                
                if self.AnnState > 0 then Train:SetNW2Int("BMCIK:Selected",self.Selected) end
                Train:SetNW2Int("BMCIK:CamPage",self.CamPage)
                Train:SetNW2Int("BMCIK:AnnState",self.AnnState)
                Train:SetNW2Int("BMCIK:AnnLine",self.AnnLine)
            elseif self.State == -4 then
                Train:SetNW2Int("BMCIK:GRUBTimeout",self.LoadingTimer - CurTime() + 1)
            end
            
            local valBtn = false
            for k,v in pairs(self.TriggerNames) do
                if Train[v] then
                    valBtn = Train[v].Value > 0.5
                    if valBtn ~= self.Triggers[v] then
                        self:Trigger(v,valBtn)
                        self.Triggers[v] = valBtn
                    end
                end
            end
        else
            if self.State ~= 0 then self:MemReset() end
        end
        
        Train:SetNW2Int("BMCIK:State",self.State)
    end
else
    local function createFont(name,font,size,weight)
        surface.CreateFont("Metrostroi_"..name, {
            font = font,
            size = size,
            weight = weight or 400,
            blursize = 0,
            antialias = true,
            underline = false,
            italic = false,
            strikeout = false,
            symbol = false,
            rotary = false,
            shadow = false,
            additive = false,
            outline = false,
            extended = true,
        })
    end
    createFont("Unifont16","unifont",16)
    createFont("ConsoleTTF","Terminus (TTF)",20)
    createFont("Dejavu20","Dejavu Sans",20)
    createFont("Dejavu21","Dejavu Sans",21)
    createFont("Dejavu22","Dejavu Sans",22)
    createFont("Dejavu26","Dejavu Sans",26)
    createFont("Dejavu28","Dejavu Sans",28)
    
    local camConfig = {
        {
            {"Левые зеркала",2,{Vector(425,65,40),Angle(10,178,0),
                               Vector(425,-65,40),Angle(10,-178,0)},
            },
            {"Передние зеркала",2,{Vector(425,65,40),Angle(10,178,0),
                                  Vector(425,-65,40),Angle(10,-178,0)},
            },
            {"Все левые/правые камеры",4,{Vector(425,65,40),Angle(10,178,0),
                                        Vector(425,-65,40),Angle(10,-178,0),
                                        Vector(425,-65,40),Angle(10,-178,0),
                                        Vector(425,65,40),Angle(10,178,0)},
                                        {true,true,false,false}
            },
            {"Задние зеркала",2,{Vector(425,-65,40),Angle(10,-178,0),
                                Vector(425,65,40),Angle(10,178,0)}
            },
            {"Правые зеркала",2,{Vector(425,-65,40),Angle(10,-178,0),
                                Vector(425,65,40),Angle(10,178,0)}
            },
            {"Салонные камеры",4,{Vector(-450,14,49),Angle(22,-5,0),
                                 Vector(375,-14,45),Angle(22,175,0),
                                 Vector(5,-14,45),Angle(20,5,0),
                                 Vector(-8,14,45),Angle(20,185,0)}
            },
            {"Салонные камеры",2,{Vector(150,-50,20),Angle(15,110,0),
                                Vector(-156,50,20),Angle(15,-70,0)}
            },
            {"Камера на посте машиниста",1,{Vector(410,35,36.5),Angle(33,-15,0)}},
            {"Путевая камера",1,{Vector(490,10,-8),Angle(5,0,0)}}
        },
        {
            {"Салонные камеры",4,{Vector(-450,14,49),Angle(22,-5,0),
                                 Vector(375,-14,45),Angle(22,175,0),
                                 Vector(5,-14,45),Angle(20,5,0),
                                 Vector(-8,14,45),Angle(20,185,0)}
            },
            {"Салонные камеры",2,{Vector(150,-50,20),Angle(15,110,0),
                                Vector(-156,50,20),Angle(15,-70,0)}
            },
        }
    }
    
    local headerNames = {
        [0] = "---",
        [1] = "---",
        [11] = "Предупредительные сообщения",
        [12] = "Ограничение маршрута",
        [13] = "Дополнительные сообщения",
        [14] = "Экстренные сообщения",
        [15] = "Выбор линии",
        [2] = "Меню настройка блока\nСБУЦИК",
        [21] = "Меню настройка блока\nСБУЦИК",
        [22] = "Режимы работы\nинформатора",
        [23] = "Режимы работы блока\nСБУЦИК",
        [24] = "Настройка громкости",
        [25] = "Additional information",
        [26] = "Диагностика (0%)",
        [27] = "Язык",
        [28] = "Отображение времени на\nБИТ"
    }
    
    local grubTest = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/grub")
    local sarmatTest = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/sarmat_test4")
    local logo = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/sarmat_logo")
    local trainTrainMsg = surface.GetTextureID("models/metrostroi_train/81-722/screens/sarmat_upo/traintrain_msg")
    local scx,scy = 1,1 -- Multipliers for fix RT draw on screen
    local SarPos = Vector(472,37.4,-9)

    function TRAIN_SYSTEM:ClientInitialize()
        self.Cam1 = self.Train:CreateRT("722SarmatC1",512,512,true)
        self.Cam2 = self.Train:CreateRT("722SarmatC2",512,512,true)
        self.Cam3 = self.Train:CreateRT("722SarmatC3",512,512,true)
        self.Cam4 = self.Train:CreateRT("722SarmatC4",512,512,true)
        
        self.HeaderCamInfoW = 0
    end
    function TRAIN_SYSTEM:ClientThink()
        if not self.Train:ShouldDrawPanel("Sarmat") then return end
        -- debugoverlay.Sphere(self.Train:LocalToWorld(Vector(472,37.4,-9)),1,1,Color( 255, 255, 255 ),false)
        -- SarPos = self.Train:WorldToLocal(LocalPlayer():GetPos())
        
        scx,scy = math.max(ScrW()/1024,1),math.max(ScrH()/1024,1)
        
        render.PushRenderTarget(self.Train.Sarmat,0,0,1024, 1024)
        render.Clear(0, 0, 0, 0)
        cam.Start2D()
            surface.SetDrawColor(0,0,0)
            surface.DrawRect(0,0,1024,640)
            self:BMCIK01(self.Train)
        cam.End2D()
        render.PopRenderTarget()
    end
    
    local screenColor = Color(16,16,23)
    function TRAIN_SYSTEM:BMCIK01(Train)
        local state = Train:GetNW2Int("BMCIK:State",0)
        if state == 0 then return end
        if state == -5 or state == -1 then
            surface.SetDrawColor(15,15,20)
            surface.DrawRect(0,0,1024,640)
        elseif state == -4 then
            surface.SetDrawColor(screenColor)
            surface.DrawRect(0,0,1024,640)
            local mat = Matrix()
            mat:SetScale(Vector(1.6,1.3333333333333))
            render.PushFilterMag( TEXFILTER.ANISOTROPIC )
            render.PushFilterMin( TEXFILTER.ANISOTROPIC )
            cam.PushModelMatrix(mat)
                surface.SetFont("Metrostroi_Unifont16")
                
                surface.SetDrawColor(255,254,254)
                surface.DrawRect(21,65,594,258)   
                surface.SetDrawColor(16,16,23)
                surface.DrawRect(23,67,590,254)
                surface.SetDrawColor(174,174,174)
                surface.DrawRect(26,74,584,16)
                
                surface.SetTextColor(174,174,174)
                surface.SetTextPos(158,26)
                surface.DrawText("GNU GRUB  version 2.02~beta2-9ubuntu1.4")
                surface.SetTextPos(58,346)
                surface.DrawText("Use the ↑ and ↓ keys to select which entry is highlighted.")
                surface.SetTextPos(58,362)
                surface.DrawText("Press enter to boot the selected OS, `e' to edit the commands")
                surface.SetTextPos(58,378)
                surface.DrawText("before booting or `c' for a command-line.")
                surface.SetTextPos(34,394)
                surface.DrawText(Format("The highlighted entry will be executed automatically in %ds.",Train:GetNW2Int("BMCIK:GRUBTimeout",0)))
                
                surface.SetTextColor(screenColor)
                surface.SetTextPos(26,74)
                surface.DrawText("*Ubuntu")
                
                surface.SetTextColor(254,254,254)
                surface.SetTextPos(34,90)
                surface.DrawText("Advanced options for Ubuntu")
                surface.SetTextPos(34,106)
                surface.DrawText("Ubuntu 16.04.3 LTS (16.04) (on /dev/sda5)")
                surface.SetTextPos(34,122)
                surface.DrawText("Advanced options for Ubuntu 16.04.3 LTS (16.04) (on /dev/sda5)")
                surface.SetTextPos(34,138)
                surface.DrawText("System setup")
            cam.PopModelMatrix()
            render.PopFilterMag()
            render.PopFilterMin()
            -- draw.SimpleText("GNU GRUB  version 2.02~beta2-9ubuntu1.4","Metrostroi_GRUB",300,40, Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            -- draw.SimpleText("GNU GRUB  version 2.02~beta2-9ubuntu1.4","Metrostroi_GRUB",314,34, Color(174,174,174),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            -- draw.SimpleText("Use the ↑ and ↓ keys to select which entry is highlighted.","Metrostroi_GRUB",200,520, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            -- draw.SimpleText("Press enter to boot the selected OS, `e' to edit the commands","Metrostroi_GRUB",200,540, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            -- draw.SimpleText("before booting or `c' for a command-line.","Metrostroi_GRUB",200,560, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            -- draw.SimpleText(Format("The highlighted entry will be executed automatically in %ds.",Train:GetNW2Int("BMCIK:GRUBTimeout",0)),"Metrostroi_GRUB",167,580, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        elseif state == -3 then
            surface.SetDrawColor(screenColor)
            surface.DrawRect(0,0,1024,640)
            draw.SimpleText(CurTime()%0.5 > 0.25 and "_" or "","Metrostroi_Dejavu28",2,16, Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        elseif state == -2 then
            surface.SetDrawColor(screenColor)
            surface.DrawRect(0,0,1024,640)
            surface.SetTexture(logo)
            surface.SetDrawColor(250,190,0)
            surface.DrawTexturedRectRotated(760,540,512,256,0)
        elseif state == 1 then
            surface.SetDrawColor(screenColor:Unpack())
            surface.DrawRect(0,0,1024,640)
            
            local mat = Matrix()
            mat:SetScale(Vector(0.8,0.8))
            -- mat:Translate(Vector(-250,0))
            render.PushFilterMag(TEXFILTER.ANISOTROPIC)
            render.PushFilterMin(TEXFILTER.ANISOTROPIC)
            cam.PushModelMatrix(mat)
                -- surface.SetTexture(sarmatTest) surface.SetDrawColor(255,255,0) surface.DrawTexturedRectRotated(1024,512,2048,1024,0)
                xpcall(self.BMCIK01GUI,function(err) Error("\nBMCIK-01 GUI error:\n", err) end,self,Train)
            cam.PopModelMatrix()
            render.PopFilterMag()
            render.PopFilterMin()
            
            surface.SetAlphaMultiplier(1-self.Train:GetNW2Float("BMCIK:Brightness",1)^1.2)
            surface.SetDrawColor(Color(8,8,8))
            surface.DrawRect(0,0,1024,640,0)
            surface.SetAlphaMultiplier(1)
        end
    end
    
    local function drawButton(x,y,w,h,text,touched)
        draw.RoundedBox(8,x,y,w,h,Color(255,255,255))
        draw.RoundedBox(6,x+2,y+2,w-4,h-4,touched and Color(120,120,120) or Color(46,46,46))
        draw.SimpleText(text,"Metrostroi_Dejavu28",x+w/2,y+h/2,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        -- draw.SimpleText(Format("x=%d y=%d",x*0.8,y*0.8),"Metrostroi_Dejavu22",x+w/2,y+h*0.3,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        -- draw.SimpleText(Format("w=%d h=%d",w*0.8,h*0.8),"Metrostroi_Dejavu22",x+w/2,y+h*0.7,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
    end
    
    function TRAIN_SYSTEM:BMCIK01GUI(Train)
        local WagNum = Train:GetNW2Int("BMCIK:WagNum",0)
        local camPage = Train:GetNW2Int("BMCIK:CamPage",0)
        local annState = Train:GetNW2Int("BMCIK:AnnState",0)
        local touchId = Train:GetNW2Int("BMCIK:IDTouched",0)
        
        drawButton(911,9,119,32,"☼",touchId == 44)
        -- drawButton("линия",1032,9,118,32)
        draw.RoundedBox(8,1032,9,118,32,Color(59,59,59))
        draw.RoundedBox(6,1034,11,114,28,screenColor)
        draw.SimpleText("линия","Metrostroi_Dejavu28",1091,25,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        draw.SimpleText("линия","Metrostroi_Dejavu28",1090,24,Color(59,59,59),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        
        ----  Cameras   ----------------------------------------------
        if camPage == 0 then
            draw.SimpleText("Система видеонаблюдения","Metrostroi_Dejavu28",457,32,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            
            draw.SimpleText("Наружные камеры","Metrostroi_Dejavu28",457,129,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText("1","Metrostroi_Dejavu28",81,199,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText(WagNum,"Metrostroi_Dejavu28",81,227,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText("Вагон 1","Metrostroi_Dejavu28",311,163,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText("Все вагоны","Metrostroi_Dejavu28",457,163,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText("Вагон "..WagNum,"Metrostroi_Dejavu28",603,163,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText("1","Metrostroi_Dejavu28",833,199,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            draw.SimpleText(WagNum,"Metrostroi_Dejavu28",833,227,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            drawButton(95,183,140,60,"Левые",touchId == 1)
            drawButton(241,183,140,60,"Передние",touchId == 2)
            drawButton(387,183,140,60,"Вокруг",touchId == 3)
            drawButton(533,183,140,60,"Задние",touchId == 4)
            drawButton(679,183,140,60,"Правые",touchId == 5)
            
            draw.SimpleText("Камеры в салонах","Metrostroi_Dejavu28",457,303,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            
            for i=1,WagNum do
                if WagNum > 6 then
                    drawButton(350+(i-WagNum/2)*110,323,104,60,"Вагон "..i,touchId == 10+i)
                else
                    drawButton(313+(i-WagNum/2)*147,323,141,60,"Вагон "..i,touchId == 10+i)
                end
            end
            
            draw.SimpleText("Камеры на постах машиниста","Metrostroi_Dejavu28",457,443,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            drawButton(215,463,140,60,"Вагон 1",touchId == 21)
            drawButton(559,463,140,60,"Вагон "..WagNum,touchId == 22)
            draw.SimpleText("Путевые камеры","Metrostroi_Dejavu28",457,583,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            drawButton(215,603,140,60,"Вагон 1",touchId == 31)
            drawButton(559,603,140,60,"Вагон "..WagNum,touchId == 32)
            -- surface.SetDrawColor(0,255,0)
            -- surface.DrawRect(0,0,18,800)
            -- surface.DrawRect(896,0,18,800)
            -- surface.DrawRect(454,0,6,800)
        else
            local camInfo = Train:GetNW2Vector("BMCIK:CamInfo",Vector(1,1,1))
            local camCurrConf = camConfig[camInfo.y][camPage] or camConfig[1][1]
            draw.RoundedBox(8,18,30,878,696,Color(255,255,255))
            draw.RoundedBox(8,19,31,876,694,screenColor)
            
            surface.DrawRect(458 - self.HeaderCamInfoW/2,24,self.HeaderCamInfoW,20)
            self.HeaderCamInfoW = draw.SimpleText(Format("Вагон [%d] - %s - страница %d/%d",camInfo.x,camCurrConf[1],camPage,camInfo.z),"Metrostroi_Dejavu26",457,33,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)+8
            
            local Cam1,Cam1E = Train:GetNW2Bool("BMCIK:Cam1C"),Train:GetNW2Entity("BMCIK:Cam1E")
            local Cam2,Cam2E = Train:GetNW2Bool("BMCIK:Cam2C"),Train:GetNW2Entity("BMCIK:Cam2E")
            local Cam3,Cam3E = Train:GetNW2Bool("BMCIK:Cam3C"),Train:GetNW2Entity("BMCIK:Cam3E")
            local Cam4,Cam4E = Train:GetNW2Bool("BMCIK:Cam4C"),Train:GetNW2Entity("BMCIK:Cam4E")
            
            if Cam1 then
                Metrostroi.RenderCamOnRT(Train,SarPos,"Cam1",math.Rand(0.1,0.25),self.Cam1,Cam1E,camCurrConf[3][1] or Vector(0,0,0),camCurrConf[3][2] or Angle(0,0,0),512,512,1.4,74,74)
                -- invert1 = (camCurrConf[4] and camCurrConf[4][1]) and 1 or 0
            end
            if Cam2 then
                Metrostroi.RenderCamOnRT(Train,SarPos,"Cam2",math.Rand(0.1,0.25),self.Cam2,Cam2E,camCurrConf[3][3] or Vector(0,0,0),camCurrConf[3][4] or Angle(0,0,0),512,512,1.4,74,74)
                -- invert2 = (camCurrConf[4] and camCurrConf[4][2]) and 1 or 0
            end
            if Cam3 then
                Metrostroi.RenderCamOnRT(Train,SarPos,"Cam3",math.Rand(0.1,0.25),self.Cam3,Cam3E,camCurrConf[3][5] or Vector(0,0,0),camCurrConf[3][6] or Angle(0,0,0),512,512,1.4,74,74)
                -- invert3 = (camCurrConf[4] and camCurrConf[4][3]) and 1 or 0
            end
            if Cam4 then
                Metrostroi.RenderCamOnRT(Train,SarPos,"Cam4",math.Rand(0.1,0.25),self.Cam4,Cam4E,camCurrConf[3][7] or Vector(0,0,0),camCurrConf[3][8] or Angle(0,0,0),512,512,1.4,74,74)
                -- invert4 = (camCurrConf[4] and camCurrConf[4][4]) and 1 or 0
            end
            
            local camFullScreen = Train:GetNW2Int("BMCIK:CamFullscreen")
            if camFullScreen > 0 then
                local tCam = Train:GetNW2Bool("BMCIK:Cam"..camFullScreen.."C")
                if tCam then render.DrawTextureToScreenRect(self["Cam"..camFullScreen],scx*19,scy*46,scx*693,scy*529) end
                Metrostroi.DrawRectOutline(24,57,867,663,Color(176,176,176))
                draw.SimpleText(tCam and "link" or "no link","Metrostroi_Dejavu20",888,716,tCam and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
            elseif camCurrConf[2] == 4 then
                -- Top left
                if Cam1 then render.DrawTextureToScreenRect(self.Cam1,scx*19,scy*46,scx*344,scy*262) end
                Metrostroi.DrawRectOutline(24,57,431,329,Color(176,176,176))
                draw.SimpleText(Cam1 and "link" or "no link","Metrostroi_Dejavu20",451,382,Cam1 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
                
                -- Bottom left
                if Cam2 then render.DrawTextureToScreenRect(self.Cam2,scx*19,scy*313,scx*344,scy*262) end
                draw.SimpleText(Cam2 and "link" or "no link","Metrostroi_Dejavu20",451,716,Cam2 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
                Metrostroi.DrawRectOutline(24,391,431,329,Color(176,176,176))
                
                -- Top right
                if Cam3 then render.DrawTextureToScreenRect(self.Cam3,scx*368,scy*46,scx*344,scy*262) end
                Metrostroi.DrawRectOutline(460,57,431,329,Color(176,176,176))
                draw.SimpleText(Cam3 and "link" or "no link","Metrostroi_Dejavu20",888,382,Cam3 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
                
                -- Bottom right
                if Cam4 then render.DrawTextureToScreenRect(self.Cam4,scx*368,scy*313,scx*344,scy*262) end
                Metrostroi.DrawRectOutline(460,391,431,329,Color(176,176,176))
                draw.SimpleText(Cam4 and "link" or "no link","Metrostroi_Dejavu20",888,716,Cam4 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
            elseif camCurrConf[2] == 2 then
                -- Left
                if Cam1 then render.DrawTextureToScreenRect(self.Cam1,scx*19,scy*46,scx*344,scy*529) end
                Metrostroi.DrawRectOutline(24,57,431,663,Color(176,176,176))
                -- draw.SimpleText("[1] Левый Борт, переднее зеркало","Metrostroi_Dejavu20",26,59,Color(250,200,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
                -- draw.SimpleText("192.168.5.61","Metrostroi_Dejavu20",26,80 ,Color(250,200,0),TEXT_ALIGN_LEFT,TEXT_ALIGN_TOP)
                draw.SimpleText(Cam1 and "link" or "no link","Metrostroi_Dejavu20",451,716,Cam1 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
                -- Right
                if Cam2 then render.DrawTextureToScreenRect(self.Cam2,scx*368,scy*46,scx*344,scy*529) end
                Metrostroi.DrawRectOutline(460,57,431,663,Color(176,176,176))
                draw.SimpleText(Cam2 and "link" or "no link","Metrostroi_Dejavu20",888,716,Cam2 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
            else
                if Cam1 then render.DrawTextureToScreenRect(self.Cam1,scx*19,scy*46,scx*693,scy*529) end
                Metrostroi.DrawRectOutline(24,57,867,663,Color(176,176,176))
                draw.SimpleText(Cam1 and "link" or "no link","Metrostroi_Dejavu20",888,716,Cam1 and Color(0,200,0) or Color(200,0,0),TEXT_ALIGN_RIGHT,TEXT_ALIGN_BOTTOM)
            end
        end
        
        
        ----  Announcer   ------------------------------------------
        local annLine = Train:GetNW2Int("BMCIK:AnnLine",0)
        local stNum = 1
        local endNum = 5
        local selected = Train:GetNW2Int("BMCIK:Selected",0)
        local infTbl = Metrostroi.SarmatUPOSetup[Train:GetNW2Int("Announcer",1)]
        local ltbl = infTbl and infTbl[annLine]
        
        draw.SimpleText(ltbl and "ПУТЬ "..(Train:GetNW2Bool("BMCIK:Path") and 2 or 1) or "---","Metrostroi_Dejavu28",1212,25,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        if annState < 2 then
            local lNameHeader = "---"
            if ltbl then
                if ltbl.Name then
                    lNameHeader = "Линия: "..ltbl.Name
                else
                    lNameHeader = Format("Линия: %s-%s",ltbl[stNum][2],ltbl[endNum][2]) -- "Линия: " = 92px
                end
                if surface.GetTextSize(lNameHeader) > 355 then
                    lNameHeader = lNameHeader:gsub("-","-\n",1)
                end
            end
            headerNames[0] = lNameHeader
            headerNames[1] = headerNames[0]
        end
        
        -- White frame
        if annState > 0 and annState ~= 21 then
            draw.RoundedBox(8,913,111,356,532,Color(255,255,255))
            draw.RoundedBox(8,914,112,354,529,screenColor)
            draw.RoundedBox(8,918,116+(selected-1)*24,346,24,Color(176,176,176))
        end
        -- Lists
        render.SetScissorRect(734,93,1011,510,true)
        if annState == 0 then
            draw.SimpleText("Блок неактивен","Metrostroi_Dejavu28",1091,125,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        elseif annState == 1 then
            
            for i=1,#ltbl do
                local yA,yD = 128+(i-1)*48,128+(i-1)*48+24
                local selA,selD = selected==(i*2-1),selected==(i*2)
                draw.SimpleText(ltbl[i][2],"Metrostroi_Dejavu21",selA and 924 or 920,yA,selA and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                draw.SimpleText(ltbl[i][2].." отп","Metrostroi_Dejavu21",selD and 924 or 920,yD,selD and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
        elseif annState == 14 then
            draw.SimpleText("Нет сообщений","Metrostroi_Dejavu21",selected==1 and 924 or 920,128+0*24,selected==1 and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        elseif annState == 15 then
            -- draw.RoundedBox(8,918,116+selected*24,346,24,Color(176,176,176))
            for i=1,#infTbl do
                draw.SimpleText(infTbl[i].Name,"Metrostroi_Dejavu21",selected==i and 924 or 920,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
        elseif annState == 2 then
            for i=1,#self.SettingsList do
                draw.SimpleText(self.SettingsList[i],"Metrostroi_Dejavu21",selected==i and 924 or 920,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
            end
        elseif annState > 20 then
            if annState == 21 then
                draw.SimpleText("Ввод номера маршрута","Metrostroi_Dejavu28",1091,125,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
            elseif annState == 22 then
                local mode = Train:GetNW2Int("BMCIK:AnnMode",0)
                for i=1,#self.AnnModeList do
                    draw.SimpleText((mode == i and "☑" or "☐")..self.AnnModeList[i],"Metrostroi_Dejavu21",selected==i and 924 or 920,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                end
            elseif annState == 23 then
                local mode = Train:GetNW2Bool("BMCIK:TrainTrain")
                draw.SimpleText((mode and "☑" or "☐").."Режим 'Состав-Состав'","Metrostroi_Dejavu21",selected==1 and 924 or 920,128+0*24,selected==1 and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                if mode then
                    render.SetScissorRect(0,0,0,0,false)
                    surface.SetDrawColor(255,255,255)
                    surface.DrawRect(900,400,378,250)
                    surface.SetTexture(trainTrainMsg)
                    surface.DrawTexturedRectRotated(1156,528,512,256,0)
                end
            elseif annState == 24 then
                for i=1,#self.AnnVolumeList do
                    draw.SimpleText(self.AnnVolumeList[i],"Metrostroi_Dejavu21",selected==i and 924 or 920,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                    draw.SimpleText("100","Metrostroi_Dejavu21",1230,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
                end
            elseif annState == 25 then
                for i=1,#self.InfoList do
                    draw.SimpleText(self.InfoList[i][1]..(self.InfoList[i][2] and Train:GetNW2Int(self.InfoList[i][2],0) or "0"),"Metrostroi_Dejavu21",selected==i and 924 or 920,128+(i-1)*24,selected==i and screenColor or Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
                end
            end
        end
        render.SetScissorRect(0,0,0,0,false)
        
        -- Header
        local textHeader = string.Explode("\n",headerNames[annState])
        for i=1,#textHeader do
            draw.SimpleText(textHeader[i],"Metrostroi_Dejavu28",1091,78-(#textHeader-1)*14+(i-1)*28,Color(255,255,255),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
        end
        
        draw.SimpleText("Состав:","Metrostroi_Dejavu22",924,658,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        for i=0,WagNum-1 do
            drawButton(1091+(i-WagNum/2)*41,673,40,48,i+1)
        end
        draw.SimpleText("Готов","Metrostroi_Dejavu28",913,770,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        
        drawButton(10,742,218,48,"Esc",touchId == 41)
        drawButton(234,742,217,48,"<-",touchId == 42)
        drawButton(457,742,218,48,"->",touchId == 43)
        draw.SimpleText(os.date("!%d.%m.%y %H:%M:%S",Metrostroi.GetSyncTime()),"Metrostroi_Dejavu28",681,756,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
        draw.SimpleText("Ver. 6","Metrostroi_Dejavu28",681,782,Color(255,255,255),TEXT_ALIGN_LEFT,TEXT_ALIGN_CENTER)
    end
end