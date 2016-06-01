--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local TianTiViewController = class("TianTiViewController", BaseViewController)

local Functions = require("app.common.Functions")

TianTiViewController.debug = true
TianTiViewController.modulePath = ...
TianTiViewController.studioSpriteFrames = {"TianTiUI_Text","CBO_ban","TianTiUI","CB_blackbg" }
--@auto code head end
local scheduler = require("app.common.scheduler")  
--@Pre loading
TianTiViewController.spriteFrameNames = 
    {
    	"playerHeadRes","tianTiRes"
    }

TianTiViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #TianTiViewController.studioSpriteFrames > 0 then
    TianTiViewController.spriteFrameNames = TianTiViewController.spriteFrameNames or {}
    table.insertto(TianTiViewController.spriteFrameNames, TianTiViewController.studioSpriteFrames)
end
function TianTiViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topNode")
	self._level_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("level")
	self._name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("name")
	self._Hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("Hero")
	self._head_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("Hero"):getChildByName("head")
	self._jb_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("Image_93"):getChildByName("jb")
	self._time_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("time")
	self._zhanli_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("zhanli")
	self._jiFen_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("jiFen")
	self._paiMing_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("paiMing")
	self._addFen_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("addFen")
	self._time1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_84"):getChildByName("time1")
	self._zhenXing_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_84"):getChildByName("zhenXing")
	self._count_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_84_0"):getChildByName("count")
	self._count_0_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_84_0"):getChildByName("count_0")
	self._ListView1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView1")
	self._hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView1"):getChildByName("model"):getChildByName("hero")
	self._ListView2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView2")
	self._hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView2"):getChildByName("model"):getChildByName("hero")
	self._ListView3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView3")
	self._hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView3"):getChildByName("model"):getChildByName("hero")
	self._table_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("table")
	
    --label list
    
    --button list
    self._helpBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_3"):getChildByName("helpBt")
	self._helpBt_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbtClick), ""))

	self._backBt_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_3"):getChildByName("backBt_8")
	self._backBt_8_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_8Click), ""))

	self._defentBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_4"):getChildByName("defentBt")
	self._defentBt_t:onTouch(Functions.createClickListener(handler(self, self.onDefentbtClick), ""))

	self._taskBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("ban"):getChildByName("taskBt")
	self._taskBt_t:onTouch(Functions.createClickListener(handler(self, self.onTaskbtClick), ""))

	self._addBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_84_0"):getChildByName("addBt")
	self._addBt_t:onTouch(Functions.createClickListener(handler(self, self.onAddbtClick), ""))

	self._tiaoZhanBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView1"):getChildByName("model"):getChildByName("tiaoZhanBt")
	self._tiaoZhanBt_t:onTouch(Functions.createClickListener(handler(self, self.onTiaozhanbtClick), ""))

	self._chaKanBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("bg_tianti"):getChildByName("ListView2"):getChildByName("model"):getChildByName("chaKanBt")
	self._chaKanBt_t:onTouch(Functions.createClickListener(handler(self, self.onChakanbtClick), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_8 btFunc
function TianTiViewController:onBackbt_8Click()
    Functions.printInfo(self.debug,"Backbt_8 button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt_8 btFunc end

--@auto code Defentbt btFunc
function TianTiViewController:onDefentbtClick()
    Functions.printInfo(self.debug,"Defentbt button is click!")
    GameCtlManager:push("app.ui.embattleSystem.EmbattleViewController",{data = {jumpType = 6,jumpData = {embattleType = 2}}})
end
--@auto code Defentbt btFunc end

--@auto code Taskbt btFunc
function TianTiViewController:onTaskbtClick()
    Functions.printInfo(self.debug,"Taskbt button is click!")
    GameCtlManager:push("app.ui.integralShopSystem.IntegralShopViewController")
end
--@auto code Taskbt btFunc end

--@auto code Tiaozhanbt btFunc
function TianTiViewController:onTiaozhanbtClick()
    Functions.printInfo(self.debug,"Tiaozhanbt button is click!")
end
--@auto code Tiaozhanbt btFunc end

--@auto code Tiaozhanbt_36 btFunc
function TianTiViewController:onTiaozhanbt_36Click()
    Functions.printInfo(self.debug,"Tiaozhanbt_36 button is click!")
end
--@auto code Tiaozhanbt_36 btFunc end

--@auto code Tiaozhanbt_38 btFunc
function TianTiViewController:onTiaozhanbt_38Click()
    Functions.printInfo(self.debug,"Tiaozhanbt_38 button is click!")
end
--@auto code Tiaozhanbt_38 btFunc end

--@auto code Closebt btFunc
function TianTiViewController:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
end
--@auto code Closebt btFunc end

--@auto code Addbt btFunc
function TianTiViewController:onAddbtClick()
    Functions.printInfo(self.debug,"Addbt button is click!")
    if TianTiData.eventAttr.m_tianTiCount >=10 then
        PromptManager:openTipPrompt(LanguageConfig.language_tianTi_1)
    elseif TianTiData.myPlayerData.m_tianTiBuyCount < #g_csBaseCfg.tiantiPrice and TianTiData.myPlayerData.m_tianTiBuyCount < g_VipCgf.ResettiantiCount[VipData.eventAttr.m_vipLevel]then
         local handler = function()
          TianTiData:RequestBuyCountInf(function()
              if TianTiData.myPlayerData.m_tianTiBuyCount <= 11 then 
                  Functions.setAdbrixTag("retention","pvp_more_buy_" .. tostring(TianTiData.myPlayerData.m_tianTiBuyCount),tostring(PlayerData.eventAttr.m_level))
              end
              PromptManager:openTipPrompt(LanguageConfig.language_tianTi_2)
          end)
        end
        NoticeManager:openTips(self, {type = NoticeManager.TIANTI_BUY_COUNT_TIPS,handler = handler})

    else
       PromptManager:openTipPrompt(LanguageConfig.language_tianTi_3)
    end
end
--@auto code Addbt btFunc end

--@auto code Chakanbt btFunc
function TianTiViewController:onChakanbtClick()
    Functions.printInfo(self.debug,"Chakanbt button is click!")
end
--@auto code Chakanbt btFunc end

--@auto code Helpbt btFunc
function TianTiViewController:onHelpbtClick()
    Functions.printInfo(self.debug,"Helpbt button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.TIANTI_INFO})
end
--@auto code Helpbt btFunc end

--@auto button backcall end


--@auto code view display func
function TianTiViewController:onCreate()
    Functions.printInfo(self.debug_b," TianTiViewController controller create!")

end
function TianTiViewController:onChangeView()
end
function TianTiViewController:openBgMusic()
    Audio.playMusic("sound/combat.mp3",true)
end
function TianTiViewController:onDisplayView()
    Functions.printInfo(self.debug_b," TianTiViewController view enter display!")
    Functions.setAdbrixTag("retension","pvp_inter")
    Functions.setPopupKey("ladder")
    EmbattleData:loadEmbattleData(EmbattleData.EmbattleTypeEnum.attack,handler(self,self.initUiDisplay))
end
--@auto code view display func end
function TianTiViewController:initUiDisplay()
    self:showView()
  
  
	--钱币显示
	-- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    --今日buff阵型
    local buffName = Functions.getTianTiBuffZX()
    self._zhenXing_t:setString(buffName)
	 --角色等级及名字
	 self._level_t:setString("LV." .. tostring(PlayerData.eventAttr.m_level)) 
    self._name_t:setString(PlayerData.eventAttr.m_name)
	 --角色头像
    local headImg = Functions.getDisHeadFImagePathOfId(PlayerData.eventAttr.m_imgID)
    Functions.loadImageWithWidget(self._head_t,headImg)
    --角色级别
    self._jb_t:setString(Functions.getPlayerRank(TianTiData.eventAttr.m_tianTiRank)) 
    
    EmbattleData:loadEmbattleData(EmbattleData.EmbattleTypeEnum.attack,function( )
        EmbattleData:initHeroMark(EmbattleData.EmbattleTypeEnum.attack)
        EmbattleData:updateAtrrInf(EmbattleData.EmbattleTypeEnum.attack)
        --角色战力
        self._zhanli_t:setString(tostring(EmbattleData.eventAttr.zhanLi))
    end)
    --角色排名
    self._paiMing_t:setString(tostring(TianTiData.eventAttr.m_tianTiRank))
    Functions.bindUiWithModelAttr(self._paiMing_t, TianTiData, "m_tianTiRank")
    --角色积分
    self._jiFen_t:setString(tostring(TianTiData.eventAttr.m_tianTiScore))
    Functions.bindUiWithModelAttr(self._jiFen_t, TianTiData, "m_tianTiScore")
    --加积分倒计时
    local integralTime = TimerManager:getCurrentSecond() - TianTiData.myPlayerData.m_tianTiTime 
    integralTime = 1800 - Functions.subIntOfNum(integralTime) % 1800
    TianTiData.eventAttr.m_tianTiTime = integralTime
    self._time_t:setString(TimerManager:formatTime("%M:%S", TianTiData.eventAttr.m_tianTiTime))
    Functions.bindUiWithModelAttr(self._time_t, TianTiData, "m_tianTiTime", function(event)
        local temp =Functions.subIntOfNum(event.data/1800)
        TianTiData.eventAttr.m_tianTiScore = TianTiData.eventAttr.m_tianTiScore +  temp*TianTiData:getAddIntegral()
        self._time_t:setString(TimerManager:formatTime("%M:%S", event.data))
    end)
    --加积分
    self._addFen_t:setString("+" .. tostring(TianTiData:getAddIntegral()))
    Functions.bindUiWithModelAttr(self._addFen_t, TianTiData, "m_tianTiRank", function(event)
          self._addFen_t:setString("+" .. tostring(TianTiData:getAddIntegral()))
    end)
    -- --加挑战次数倒计时
    -- local tiaoZhanTime = TimerManager:getCurrentSecond() - TianTiData.myPlayerData.m_tianTiCountTime 
    -- tiaoZhanTime = 3600 - Functions.subIntOfNum(tiaoZhanTime) % 3600
    -- TianTiData.eventAttr.m_tianTiCountTime = tiaoZhanTime
    -- self._time1_t:setString(TimerManager:formatTime("%M:%S", TianTiData.eventAttr.m_tianTiCountTime))
    -- Functions.bindUiWithModelAttr(self._time1_t, TianTiData, "m_tianTiCountTime", function(event)
    --     local temp =Functions.subIntOfNum(event.data/3600)
    --     TianTiData.eventAttr.m_tianTiCount = TianTiData.eventAttr.m_tianTiCount + temp
    --     self._time1_t:setString(TimerManager:formatTime("%M:%S", event.data))
    -- end)
    --剩余挑战次数
    self._count_t:setString(tostring(TianTiData.eventAttr.m_tianTiCount))
    Functions.bindUiWithModelAttr(self._count_t, TianTiData, "m_tianTiCount")
    --添加标签页监听
--    self:RequestRankingPlayerInf()
    local tableListener = function(target)
        if target == "tb1" then
            self:RequestRankingPlayerInf()
        elseif target == "tb2" then
            self:RequestZhanBaoPlayerInf()
        elseif target == "tb3" then
--            self:RequestStarPlayerInf()
            self:RequestStarPlayerInf(handler(self,self.showStarList))
        end
    end
    Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener,firstName = "tb1"})
    Functions.bindEventListener(self.view_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, function ( )
       TianTiData.eventAttr.m_tianTiTime = TianTiData.eventAttr.m_tianTiTime - 1
       if TianTiData.eventAttr.m_tianTiTime < 0 then
          TianTiData.eventAttr.m_tianTiTime = 1800  
       end
       -- TianTiData.eventAttr.m_tianTiCountTime = TianTiData.eventAttr.m_tianTiCountTime - 1
       -- if TianTiData.eventAttr.m_tianTiCountTime < 0 then
       --    TianTiData.eventAttr.m_tianTiCountTime = 3600  
       -- end
    end)
end

--显示排名列表
function TianTiViewController:showRankingList()
	self._ListView1_t:setVisible(false)
	self._ListView2_t:setVisible(false)
	self._ListView3_t:setVisible(false)
	local rankData = {}
    for k,v in pairs(self.rankingPlayerData) do
		if not table.empty(v) then
		  rankData[#rankData + 1] = v
		end
	end
    if #rankData >1 then 
       table.sort(rankData,function(a,b) 
	   return a.ttrank < b.ttrank end)
	end
  
	local handler = function ( index,target,data,model)
		    --角色名字
        Functions.initTextColor(model:getChildByName("name"),target:getChildByName("name"))
        target:getChildByName("name"):setString(tostring(data.name))
        --角色头像
        local headImg = Functions.getDisHeadFImagePathOfId(data.imgid)
        Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("head"), headImg)
       --排名
       target:getChildByName("paiMing"):setString(tostring(data.ttrank))
       --奖励积分
       Functions.initTextColor(model:getChildByName("jiangLi"),target:getChildByName("jiangLi"))
       target:getChildByName("jiangLi"):setString(tostring(data.score))
       --战力
       Functions.initTextColor(model:getChildByName("zhanLi"),target:getChildByName("zhanLi"))
       target:getChildByName("zhanLi"):setString(tostring(data.fight))
       if data.id == PlayerData.eventAttr.m_uid then
            target:getChildByName("tiaoZhanBt"):setVisible(false)
       end
        local tiaoZhanHander = function()
          if TianTiData.eventAttr.m_tianTiCount > 0 then
            Functions.setAdbrixTag("retension","pvp_try")
            local tiaoZhanHandler = function ()
                GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_PVPPlayerData,
                    playerData = data } })
            end  
            TianTiData:RequestTiaoZhan(index,data.id,tiaoZhanHandler)  
          else
              PromptManager:openTipPrompt(LanguageConfig.language_5_7)  
          end  
        end
        if index == 1 then 
            self._tiaozhanBt1_t = target:getChildByName("tiaoZhanBt")
        end
        target:getChildByName("tiaoZhanBt"):onTouch(Functions.createClickListener(tiaoZhanHander, "")) 
	end
    Functions.bindListWithData(self._ListView1_t,rankData,handler)
  if #rankData > 0 then 
    self._ListView1_t:setVisible(true)
  end
end
--显示战报列表
function TianTiViewController:showZhanBaoList()
	self._ListView1_t:setVisible(false)
	self._ListView2_t:setVisible(false)
	self._ListView3_t:setVisible(false)
   table.sort(self.zhanBaoPlayerData,function(a,b)
        -- if  a.orank == b.orank then
        --     if a.win == b.win then
        --         return a.win < b.win
        --     else
        --         return a.win > b.win 
        --     end
        -- else
        --     return a.orank > b.orank
        -- end
        return a.time > b.time
   end)
  if #self.zhanBaoPlayerData > 0 then 
    self._ListView2_t:setVisible(true)
  end
	local handler = function ( index,target,data,model)
		  --角色名字
        Functions.initTextColor(model:getChildByName("name"),target:getChildByName("name"))
        target:getChildByName("name"):setString(tostring(data.name))
        --角色头像
        local headImg = Functions.getDisHeadFImagePathOfId(data.pic)

        Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("head"),headImg)
       --排名
       target:getChildByName("paiMing"):setString(tostring(data.orank))
       
       --上升或下降名称
       target:getChildByName("isUp"):setString(tostring(data.nrank))
       --战力
       Functions.initTextColor(model:getChildByName("zhanLi"),target:getChildByName("zhanLi"))
       target:getChildByName("zhanLi"):setString(tostring(data.power))
       --攻防状态
       if data.passive == 0 then
            Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("gf"), "tyj/uiFonts_res/gongf.png")
       elseif data.passive == 1 then 
            Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("gf"), "tyj/uiFonts_res/shouf.png")
       end
       --是否胜利
       if data.win == 0 then
          target:getChildByName("isok"):getChildByTag(1):setVisible(false)
          target:getChildByName("isok"):getChildByTag(2):setVisible(true)
       		Functions.loadImageWithWidget(target:getChildByName("arrow"),"tyj/ui_res/TianTiUI/tianti_arrow_down.png")
          target:getChildByName("isUp"):setColor(cc.c3b(58,169,0))
       elseif data.win == 1 then
       		target:getChildByName("isok"):getChildByTag(1):setVisible(true)
          target:getChildByName("isok"):getChildByTag(2):setVisible(false)
          Functions.loadImageWithWidget(target:getChildByName("arrow"),"tyj/ui_res/TianTiUI/tianti_arrow_up.png")
          target:getChildByName("isUp"):setColor(cc.c3b(202,58,0))
       end
       --时间
       Functions.initTextColor(model:getChildByName("time"),target:getChildByName("time"))
       target:getChildByName("time"):setString(TimerManager:formatTime("%H:%M", data.time))
       --查看战报
        local zhanBaoHander = function()
            GameCtlManager:push("app.ui.combatSystem.CombatViewController", { data = { combatType = CombatCenter.CombatType.RB_PVPHistoryData,
                playerData = data } })
        end
        local zhanBaoButton = target:getChildByName("chaKanBt")
        
        zhanBaoButton:onTouch(Functions.createClickListener(zhanBaoHander, ""))
	end
  Functions.bindListWithData(self._ListView2_t,self.zhanBaoPlayerData,handler)
  if #self.zhanBaoPlayerData > 0 then 
    self._ListView2_t:setVisible(true)
  end
end
--显示名人榜列表
function TianTiViewController:showStarList(starData)
	self._ListView1_t:setVisible(false)
	self._ListView2_t:setVisible(false)
	self._ListView3_t:setVisible(false)
	local starPlayerData = {}
	for k,v in pairs(starData) do 
	   starPlayerData[#starPlayerData+1] = v
	end
    table.sort(starPlayerData,function(a,b) return a.ttrank < b.ttrank  end)
  
	local handler = function ( index,target,data,model)
		--角色名字
        Functions.initTextColor(model:getChildByName("name"),target:getChildByName("name"))
        target:getChildByName("name"):setString(tostring(data.name))
        --角色头像
        local headImg = Functions.getDisHeadFImagePathOfId(data.imgid)
        Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("head"),headImg)
        --战力
        Functions.initTextColor(model:getChildByName("zhanLi"),target:getChildByName("zhanLi"))
        target:getChildByName("zhanLi"):setString(tostring(data.fight))
        --称号
        Functions.initTextColor(model:getChildByName("chenHao"),target:getChildByName("chenHao"))
        if data.ttrank == 1 then
       	  target:getChildByName("chenHaoView"):setVisible(true)
       	  target:getChildByName("chenHao"):setVisible(true)	
       	  target:getChildByName("chenHao"):setString(LanguageConfig.language_tianTi_4)
          Functions.loadImageWithWidget(target:getChildByName("isok"),"tiant_1.png")
       elseif data.ttrank == 2 then
       	  target:getChildByName("chenHaoView"):setVisible(true)
       	  target:getChildByName("chenHao"):setVisible(true)	
       	  target:getChildByName("chenHao"):setString(LanguageConfig.language_tianTi_5)
          Functions.loadImageWithWidget(target:getChildByName("isok"),"tiant_2.png")
       elseif data.ttrank == 3 then
       	  target:getChildByName("chenHaoView"):setVisible(true)
       	  target:getChildByName("chenHao"):setVisible(true)	
       	  target:getChildByName("chenHao"):setString(LanguageConfig.language_tianTi_6)
          Functions.loadImageWithWidget(target:getChildByName("isok"),"tiant_3.png")
       else
          local x = target:getChildByName("isok"):getPositionX()
          local y = target:getChildByName("isok"):getPositionY()
          target:removeChildByName("isok")
          local  rankLabel = cc.Label:createWithBMFont("fonts/baoji.fnt",tostring(data.ttrank))
          rankLabel:setPosition(x, y)
          target:addChild(rankLabel)        
       end
       local checkInfHander = function()
            GameCtlManager:push("app.ui.zhenRongSystem.ZhenRongViewController",{data = {jumpType = 2,jumpData = {data.m_mainHero, data.m_viceHero1, data.m_viceHero2}}})
       end
       target:getChildByName("chaKanBt"):onTouch(Functions.createClickListener(checkInfHander, ""))
	end
    Functions.bindListWithData(self._ListView3_t,starPlayerData,handler)
  if #starPlayerData > 0 then 
     self._ListView3_t:setVisible(true)
  end
end
---------------------------------------------------------------------------
--接收名将榜玩家数据
function TianTiViewController:RequestStarPlayerInf(handler)
     --监听服务器数据
    local starPlayerData = {}
    local requestFlag = false
    local onServerRequest = function (event)
        requestFlag = true
        local data = event.data
        for k, v in pairs(data) do 
            starPlayerData[k] = v
        end
        if handler ~= nil then 
            handler(starPlayerData) 
        end
        return true
    end
    NetWork:addNetWorkListener({11,15}, onServerRequest)
    local msg = {idx = {11,15}}
    NetWork:sendToServer(msg)
    scheduler.performWithDelayGlobal(function ( )
        if not requestFlag then 
            NetWork:finishSend(true)
            PromptManager:openTipPrompt(LanguageConfig.language_1_25)
            GameCtlManager:pop(self)
        end 
    end, 6)
end
--接收排名玩家数据
function TianTiViewController:RequestRankingPlayerInf(  )
	 --监听服务器数据
	  self.rankingPlayerData = {}
    local requestFlag = false
    local onServerRequest = function (event)
        requestFlag = true
        local data = event.data
        for k, v in pairs(data) do 
            self.rankingPlayerData[k] = v
        end
        self:showRankingList()
        return true
    end
    NetWork:addNetWorkListener({1, 1}, onServerRequest)
    self:sendGetRankingPlayerInfMsg()
    scheduler.performWithDelayGlobal(function ( )
        if not requestFlag then 
            NetWork:finishSend(true)            
            GameCtlManager:pop(self)
            PromptManager:openTipPrompt(LanguageConfig.language_1_25)
        end 
    end, 6)
end
--发送获取排名玩家信息
function TianTiViewController:sendGetRankingPlayerInfMsg()
    local msg = {idx = {1,1},btype = CombatType.RB_PVPPlayerList,data = {}}
    NetWork:sendToServer(msg)
end

--接收战报玩家数据
function TianTiViewController:RequestZhanBaoPlayerInf(  )
	 --监听服务器数据
	self.zhanBaoPlayerData = {}
  local requestFlag = false
    local onServerRequest = function (event)
        requestFlag = true
        local data = event.history
        
        for k, v in pairs(data) do 
            self.zhanBaoPlayerData[k] = v
            self.zhanBaoPlayerData[k]["index"] = k
        end
        
        self:showZhanBaoList()
        return true
    end
    NetWork:addNetWorkListener({1, 1}, onServerRequest)
    self:sendGetZhanBaoPlayerInfMsg()
    scheduler.performWithDelayGlobal(function ( )
        if not requestFlag then 
            NetWork:finishSend(true)
            PromptManager:openTipPrompt(LanguageConfig.language_1_25)
            GameCtlManager:pop(self)
        end 
    end, 6)
end
--发送获取战报玩家信息
function TianTiViewController:sendGetZhanBaoPlayerInfMsg()
    local msg = {idx = {1,1},btype = CombatType.RB_PVPHistory,data = {}}
    NetWork:sendToServer(msg)
end

-----------
--接受pop数据
function TianTiViewController:onReceivePopData(data)
    if data ~= nil then
        if data.combatType == CombatCenter.CombatType.RB_PVPPlayerData then
            self:RequestRankingPlayerInf()
        elseif data.combatType == CombatCenter.CombatType.RB_PVPHistory then
            self:RequestZhanBaoPlayerInf()
        end
    end
end
return TianTiViewController