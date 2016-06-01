--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GvgOverPopView = class("GvgOverPopView", BasePopView)

local Functions = require("app.common.Functions")

GvgOverPopView.csbResPath = "cs/csb"
GvgOverPopView.debug = true
GvgOverPopView.studioSpriteFrames = {"CombatOverPopUI","CombatOverUI","CBO_gvgOverBg" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #GvgOverPopView.studioSpriteFrames > 0 then
    GvgOverPopView.spriteFrameNames = GvgOverPopView.spriteFrameNames or {}
    table.insertto(GvgOverPopView.spriteFrameNames, GvgOverPopView.studioSpriteFrames)
end
function GvgOverPopView:onInitUI()

    --output list
    self._fightFailPanel_t = self.csbNode:getChildByName("fightFailPanel")
	self._fail_npc_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("fail_npc")
	self._fightWinPanel_t = self.csbNode:getChildByName("fightWinPanel")
	self._result_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result")
	self._success_npc_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("success_npc")
	self._shilian_panel_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel")
	self._zhangong_bg_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel"):getChildByName("zhangong_bg")
	self._zgText_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("shilian_panel"):getChildByName("zhangong_bg"):getChildByName("zgText")
	
    --label list
    
    --button list
    self._faileSureBt_t = self.csbNode:getChildByName("fightFailPanel"):getChildByName("faileSureBt")
	self._faileSureBt_t:onTouch(Functions.createClickListener(handler(self, self.onFailesurebtClick), ""))

	self._winSureBt_t = self.csbNode:getChildByName("fightWinPanel"):getChildByName("result"):getChildByName("winSureBt")
	self._winSureBt_t:onTouch(Functions.createClickListener(handler(self, self.onWinsurebtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Failesurebt btFunc
function GvgOverPopView:onFailesurebtClick()
    Functions.printInfo(self.debug,"Failesurebt button is click!")

    self:quitCombat()
end
--@auto code Failesurebt btFunc end

--@auto code Winsurebt btFunc
function GvgOverPopView:onWinsurebtClick()
    Functions.printInfo(self.debug,"Winsurebt button is click!")

    self:quitCombat()
end
--@auto code Winsurebt btFunc end

--@auto button backcall end


--@auto code output func
function GvgOverPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GvgOverPopView:onDisplayView(data)
	Functions.printInfo(self.debug,"pop action finish ")

    self._fightFailPanel_t:setVisible(false)
    self._fightWinPanel_t:setVisible(false)

    local scheduler = require("app.common.scheduler")
	if data.result == CombatCenter.FightResult.WIN then
        Functions.loadImageWithSprite(self._success_npc_t, "npc/gvg_suc.png")
        scheduler.performWithDelayGlobal(function()
            Audio.playSound("sound/game_win.mp3")
        end, 0.4)
    else
        Functions.loadImageWithSprite(self._fail_npc_t, "npc/gvg_fail.png")
        scheduler.performWithDelayGlobal(function()
            Audio.playSound("sound/game_lose.mp3")
        end, 0.4)
    end

    --给服务器发送消息
    self.currentType  = data.combatType
    self.combatResult = data.result
    self.combatInfo = data.combatInfo
    
    local elist   = CombatCenter:getAiEventList()
    local clist   = CombatCenter:getAiCreatureList()
    local baseMsg = { idx = { 1, 2 }, data = { res = data.result, elist = elist, clist = clist } }

    baseMsg.btype = 11
    local hps = CombatCenter:getHeroHpList()
    for i=1, 6 do
        baseMsg.data["hero" .. tostring(i)] = hps[i]
    end

    baseMsg.data.big = self.combatInfo.big
    baseMsg.data.small = self.combatInfo.small
    
    NetWork:addNetWorkListener({ 1, 2}, handler(self, self.onServerResponse))
    NetWork:sendToServer(baseMsg)

end

function GvgOverPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end


function GvgOverPopView:onServerResponse()
    if self.combatResult == CombatCenter.FightResult.WIN then
        self._fightFailPanel_t:setVisible(false)
        self._fightWinPanel_t:setVisible(true)
    else
        self._fightFailPanel_t:setVisible(true)
        self._fightWinPanel_t:setVisible(false)
    end
    return true
end

function GvgOverPopView:quitCombat()
	local controller = self._controller_t
    self:close()
    controller:quitCombat()
end

return GvgOverPopView