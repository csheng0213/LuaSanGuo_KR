--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local ChengJiuViewController = class("ChengJiuViewController", BaseViewController)

local Functions = require("app.common.Functions")

ChengJiuViewController.debug = true
ChengJiuViewController.modulePath = ...
ChengJiuViewController.studioSpriteFrames = {"CB_bgup","CBO_taskFrame","CB_blackbg" }
--@auto code head end

--@Pre loading
ChengJiuViewController.spriteFrameNames = 
    {
        "achievementRes"
    }

ChengJiuViewController.animaNames = 
    {
        "An_chengJiu"
    }


--@auto code uiInit
--add spriteFrames
if #ChengJiuViewController.studioSpriteFrames > 0 then
    ChengJiuViewController.spriteFrameNames = ChengJiuViewController.spriteFrameNames or {}
    table.insertto(ChengJiuViewController.spriteFrameNames, ChengJiuViewController.studioSpriteFrames)
end
function ChengJiuViewController:onDidLoadView()

    --output list
    self._chengJiuListView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("chengJiuListPanel"):getChildByName("chengJiuListBox"):getChildByName("childChengJiuListBox"):getChildByName("chengJiuListView")
	self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	
    --label list
    
    --button list
    self._chengJiuBox_t = self.view_t.csbNode:getChildByName("main"):getChildByName("chengJiuListPanel"):getChildByName("chengJiuListBox"):getChildByName("childChengJiuListBox"):getChildByName("chengJiuListView"):getChildByName("model"):getChildByName("chengJiuBox")
	self._chengJiuBox_t:onTouch(Functions.createClickListener(handler(self, self.onChengjiuboxClick), "zoom"))

	self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin


--@auto code Backbt btFunc
function ChengJiuViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Chengjiubox btFunc
function ChengJiuViewController:onChengjiuboxClick()
    Functions.printInfo(self.debug,"Chengjiubox button is click!")
end
--@auto code Chengjiubox btFunc end

--@auto button backcall end


--@auto code view display func
function ChengJiuViewController:onCreate()
    Functions.printInfo(self.debug_b," ChengJiuViewController controller create!")
end
function ChengJiuViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function ChengJiuViewController:onDisplayView()
    Functions.printInfo(self.debug_b," ChengJiuViewController view enter display!")
    Functions.setPopupKey("achievement")
    self:initUiDisplay_()
end
--@auto code view display func end
--custom code start
function ChengJiuViewController:initUiDisplay_()

    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    local dataList = clone(TaskData.TaskInf.m_major)
    for i=1, 4 do
        table.remove(dataList, #dataList)
    end
    for i=1,#dataList do
        dataList[i].pos = i 
    end
     table.sort(dataList,function(a,b)
         return (a.m_get + 1 - a.m_flag) < (b.m_get + 1 - b.m_flag)    
     end)
    local listHandler = function(index,widget,data,model) 
        
        local chengJiuBox = widget:getChildByName("chengJiuBox")
        local infLabel = chengJiuBox:getChildByName("chengJiuInfText")
        Functions.initTextColor(model:getChildByName("chengJiuBox"):getChildByName("chengJiuInfText"),infLabel)
        local rewardLabel = chengJiuBox:getChildByName("chengJiuRewardText")
        Functions.initTextColor(model:getChildByName("chengJiuBox"):getChildByName("chengJiuRewardText"),rewardLabel)
        local prizeView = chengJiuBox:getChildByName("chengJiuIcon"):getChildByName("prizeView")
        local statues1 = chengJiuBox:getChildByName("statues_1")
        statues1:ignoreContentAdaptWithSize(true)
        Functions.loadImageWithWidget(statues1, "tyj/uiFonts_res/weiwanc.png")
        --local chengJiuBt = chengJiuBox:getChildByName("chengJiuBt")
        local prizeView  = chengJiuBox:getChildByName("chengJiuIcon"):getChildByName("prizeView")
        
        if g_csMainMsn[data.pos][2][1] == -2 then
            Functions.loadImageWithWidget(prizeView, "tyj/dynamicUI_res/achievement_wing.png")
        elseif g_csMainMsn[data.pos][2][1] == -3 then
            Functions.loadImageWithWidget(prizeView, "tyj/dynamicUI_res/achievement_copper.png")    
        end 

        infLabel:setString(self:getChengjiuInfStr(data.pos,data))
        rewardLabel:setString(self:getChengjiuRewardStr(data.pos,data))
        Functions.loadImageWithWidget(prizeView, self:getChengjiuRewardImg(data.pos))
        if data["m_get"]+1 <= data["m_flag"] then
            Functions.loadImageWithWidget(statues1, "tyj/uiFonts_res/ljl.png")
            
        else 
            Functions.loadImageWithWidget(statues1, "tyj/uiFonts_res/weiwanc.png")
        end
        if data["m_get"]+1 > #g_csMainMsn[data.pos][1] then 
            Functions.loadImageWithWidget(statues1, "tyj/uiFonts_res/ywanc.png")
        end  

        local onChengJiuBtClick = function(event)
            if data["m_get"]+1 <= data["m_flag"] then                
                Functions.playSound("getrewards.mp3")
                local handler = function(id,num)                                     
                    local img = self:getChengjiuRewardImgofId(id)
                    local handler1 = function ()  
                        PromptManager:openShieldLayer()                        
                        Functions.playAnimationWithRemove(chengJiuBox,"An_chengJiu",0,0,function()
                            self:initUiDisplay_()
                        end)
                    end
                    NoticeManager:openRewardTips(self, {type = NoticeManager.REWARD_PROP_TIPS,data = {{img = img ,num = num}},handler = handler1})                       
                end
                TaskData:RequestChengJiu(data.pos,handler)
            end
        end
        chengJiuBox:onTouch(Functions.createClickListener(onChengJiuBtClick, "zoom"))

        if index == 1 then
            self._chengJiuBox1_t = chengJiuBox
        end
        if index == #dataList then 
            PromptManager:closeShieldLayer()
        end
    end
   
    Functions.bindListWithData(self._chengJiuListView_t, dataList, listHandler)
end

--tool code start
function ChengJiuViewController:getChengjiuInfStr(index,data)
    local str = ""
    if index == 1 then       
        if (data["m_get"] + 1) <= #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_0,self:getHeroLevelOfRewardStag( data["m_get"]+1 ))
        else
            str = string.format(LanguageConfig.language_cjrenwu_0,99)
        end
    elseif index == 2 then
        -- local temp_x = Functions.subIntOfNum((data["m_get"] + 1) / 6)
        local temp_x = data["m_get"] + 1
        -- local temp_y = Functions.subIntOfNum((data["m_get"] + 1) % 6)
        -- if temp_y == 0 then
        --     temp_y = 1
        -- end
        if temp_x == 0 then
            str = LanguageConfig.language_cjrenwu_30
        elseif temp_x == 1 then
            str = LanguageConfig.language_cjrenwu_31
        elseif temp_x == 2 then
            str = LanguageConfig.language_cjrenwu_32
        elseif temp_x == 3 then
            str = LanguageConfig.language_cjrenwu_33
        elseif temp_x == 4 then
            str = LanguageConfig.language_cjrenwu_34
        elseif temp_x == 5 then
            str = LanguageConfig.language_cjrenwu_35
        elseif temp_x == 6 then
            str = LanguageConfig.language_cjrenwu_36
        else
            str = LanguageConfig.language_cjrenwu_36
        end
        str = string.format(LanguageConfig.language_cjrenwu_1,str)
    elseif index == 3 then
        if data["m_get"] + 1 <=  #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_2,g_MakeMMSoldier[data["m_get"] + 1][1],g_MakeMMSoldier[data["m_get"] + 1][2])
        else
            str = string.format(LanguageConfig.language_cjrenwu_2,g_MakeMMSoldier[data["m_get"]][1],g_MakeMMSoldier[data["m_get"]][2])
        end
    elseif index == 4 then
        if (data["m_get"] + 1) <= #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_3,g_MakeMMPass[data["m_get"] + 1][1],g_MakeMMPass[data["m_get"] + 1][2])  
        else
            str = string.format(LanguageConfig.language_cjrenwu_3,g_MakeMMPass[data["m_get"]][1],g_MakeMMPass[data["m_get"]][2]) 
        end 
    elseif index == 5 then
        if (data["m_get"] + 1) <= #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_4,self:getPlayerLevelOfRewardStag( data["m_get"]+1 ))
        else
            str = string.format(LanguageConfig.language_cjrenwu_4,g_playerMaxLevel)
        end
    elseif index == 6 then
        local temp_x = Functions.subIntOfNum((data["m_get"] + 1) * 10)
        if (data["m_get"] + 1) <= #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_5,g_csMainMsn[index][3][data["m_get"] + 1])  
        else
            str = string.format(LanguageConfig.language_cjrenwu_5,g_csMainMsn[index][3][data["m_get"]])  
        end
    elseif index == 7 then
        if (data["m_get"] + 1) <= #g_csMainMsn[index][1] then
            str = string.format(LanguageConfig.language_cjrenwu_6,g_MakeMMElitePass[data["m_get"] + 1][1],g_MakeMMElitePass[data["m_get"] + 1][2])   
        else
            str = string.format(LanguageConfig.language_cjrenwu_6,g_MakeMMElitePass[data["m_get"]][1],g_MakeMMElitePass[data["m_get"]][2])
        end
    end  
    return str
end

function ChengJiuViewController:getHeroLevelOfRewardStag( stag )
    for k,v in pairs(g_cardToMiss) do
        if v == stag then
            return k 
        end
    end
    return 1
end

function ChengJiuViewController:getPlayerLevelOfRewardStag( stag )
    for k,v in pairs(g_roleToMiss) do
        if v == stag then
            return k 
        end
    end
    return 1
end
function ChengJiuViewController:getChengjiuRewardStr(index,data)
    local tempStr = ""
    if g_csMainMsn[index][2][1] == -2 then
        tempStr = LanguageConfig.language_cjrenwu_52
    elseif g_csMainMsn[index][2][1] == -3 then
        tempStr = LanguageConfig.language_cjrenwu_51
    elseif g_csMainMsn[index][2][1] == -5 then
        tempStr = LanguageConfig.language_cjrenwu_53
    end

    --if data["m_get"]+1 <=  data["m_flag"] then
    local num = 0 
    if nil ~=  g_csMainMsn[index][1][data["m_get"]+1] then 
        num = g_csMainMsn[index][1][data["m_get"]+1]
    else
        num = g_csMainMsn[index][1][#g_csMainMsn[index][1]]
    end
    local str =  string.format(tempStr,num)
    return str
end

function ChengJiuViewController:getChengjiuRewardImg(index)
    local imageStr = ""
    if g_csMainMsn[index][2][1] == -2  then
        imageStr = "achievement_wing.png"
    elseif g_csMainMsn[index][2][1] == -3  then
        imageStr = "achievement_copper.png"
    elseif g_csMainMsn[index][2][1] == -5  then
        imageStr = "achievement_hun.png"
    end
    return imageStrcheng
end

function ChengJiuViewController:getChengjiuRewardImgofId(id)
    local imageStr = ""
    if  id == -2 then
        imageStr = "property_gold.png"
    elseif  id == -3 then
        imageStr = "property_money.png"
    elseif id == -5 then
        imageStr = "property_soul.png"
    end
    return imageStr
end
--tool code end
return ChengJiuViewController