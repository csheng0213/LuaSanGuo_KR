--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local RankingViewController = class("RankingViewController", BaseViewController)

local Functions = require("app.common.Functions")

RankingViewController.debug = true
RankingViewController.modulePath = ...
RankingViewController.studioSpriteFrames = {"CB_bgup","XUEZHANUI","RankingUI","CB_blackbg" }
--@auto code head end

--@Pre loading
RankingViewController.spriteFrameNames = 
    {
        "xueZhanRes"
    }

RankingViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #RankingViewController.studioSpriteFrames > 0 then
    RankingViewController.spriteFrameNames = RankingViewController.spriteFrameNames or {}
    table.insertto(RankingViewController.spriteFrameNames, RankingViewController.studioSpriteFrames)
end
function RankingViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3"):getChildByName("topbarBg_10"):getChildByName("topNode")
	self._table_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_23"):getChildByName("table")
	self._ListView1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_23"):getChildByName("ListView1")
	self._hero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_23"):getChildByName("ListView1"):getChildByName("model"):getChildByName("hero")
	self._name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board_23"):getChildByName("ListView1"):getChildByName("model"):getChildByName("name")
	
    --label list
    
    --button list
    self._backBt_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel_3"):getChildByName("topbarBg_10"):getChildByName("Panel_3"):getChildByName("backBt_2")
	self._backBt_2_t:onTouch(Functions.createClickListener(handler(self, self.onBackbt_2Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt_2 btFunc
function RankingViewController:onBackbt_2Click()
    Functions.printInfo(self.debug,"Backbt_2 button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt_2 btFunc end

--@auto code Rankingbt btFunc
function RankingViewController:onRankingbtClick()
    Functions.printInfo(self.debug,"Rankingbt button is click!")
end
--@auto code Rankingbt btFunc end

--@auto button backcall end


--@auto code view display func
function RankingViewController:onCreate()
    Functions.printInfo(self.debug_b," RankingViewController controller create!")
end
function RankingViewController:onChangeView()
end
function RankingViewController:onDisplayView()
	Functions.printInfo(self.debug_b," RankingViewController view enter display!")
    --钱币显示
    -- Functions.bindMGSDisplay({moneyObj = self._coinText_t,goldObj = self._goldText_t,soulObj = self._soulText_t})
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    self:sendServerMsg(4)
	--添加标签页监听
	local tableListener = function(target)
		print(target)
		if target == "tb1" then
			self:sendServerMsg(4)
		elseif target == "tb2" then
			self:sendServerMsg(3)
		elseif target == "tb3" then
			self:sendServerMsg(2)
		elseif target == "tb4" then
			self:sendServerMsg(1)
		end
	end
    Functions.initTabComWithSimple({widget = self._table_t ,listener = tableListener, firstName = "tb1"})
    self:sendServerMsg(1)
end
--@auto code view display func end
function RankingViewController:initUiDisplay()

    self._ListView1_t:setVisible(true)
    --按排行排序
	table.sort(self.RankingData ,function(a,b)return a.rank < b.rank end)
	local handler = function(index,target,data,model)
    	if data.rank == 1 then
           Functions.loadImageWithWidget(target:getChildByName("atrr"),"xuezhan_no1.png")  
        elseif data.rank == 2 then
           Functions.loadImageWithWidget(target:getChildByName("atrr"),"xuezhan_no2.png")
        elseif data.rank == 3 then
           Functions.loadImageWithWidget(target:getChildByName("atrr"),"xuezhan_no3.png")
        else
            local x = target:getChildByName("atrr"):getPositionX()
            local y = target:getChildByName("atrr"):getPositionY()
            target:removeChildByName("atrr")
            local  rankLabel = cc.Label:createWithBMFont("fonts/baoji.fnt",tostring(data.rank))
            rankLabel:setPosition(x, y)
            target:addChild(rankLabel)          
    	end
    	 --角色等级
        target:getChildByName("jb"):setString(tostring(data.level))
        Functions.initTextColor(model:getChildByName("jb"),target:getChildByName("jb"))       
        --角色名字
        target:getChildByName("name"):setString(tostring(data.name))
        Functions.initTextColor(model:getChildByName("name"),target:getChildByName("name"))  
        -- --角色头像
        local headImg = Functions.getDisHeadFImagePathOfId(data.img)
        Functions.loadImageWithWidget(target:getChildByName("hero"):getChildByName("head"),headImg)
    
        --战绩
        target:getChildByName("zhanJi"):setString(tostring(data.best))
        Functions.initTextColor(model:getChildByName("zhanJi"),target:getChildByName("zhanJi")) 
        --奖励
        target:getChildByName("reward"):setString(tostring(data.gold))
        Functions.initTextColor(model:getChildByName("reward"),target:getChildByName("reward")) 
        
--        for i = 1, 4 do
--            Functions.initTextColor(model:getChildByTag(i),target:getChildByTag(i))     
--        end
        --查看阵容
        local checkInfHander = function()
--            local hero1 = {id = data.hero1.id,level = data.hero1.level, class =  data.hero1.class,fight = data.hero1.fight}
--            local hero2 = {id = data.hero2.id,level = data.hero2.level, class =  data.hero2.class,fight = data.hero2.fight}
--            local hero3 = {id = data.hero3.id,level = data.hero3.level, class =  data.hero3.class,fight = data.hero3.fight}
            GameCtlManager:push("app.ui.zhenRongSystem.ZhenRongViewController",{data = {jumpType = 1,jumpData = {data.hero1, data.hero2, data.hero3}}})
        end
        target:getChildByName("rankingBt"):onTouch(Functions.createClickListener(checkInfHander, ""))
        self.RankingData = {}
	end
    Functions.bindListWithData(self._ListView1_t,self.RankingData,handler)
    self:showView()
end
--发送消息
function RankingViewController:sendServerMsg(index)
    --监听的服务器数据
    self.RankingData = {}
    --添加服务器监听
    local onServerRequest = function (event)
        Functions.printInfo(self.debug,"Refrashbt button is click!") 
        local data = event.data
        for k,v in pairs(data) do
            self.RankingData[#self.RankingData + 1] = v 
        end
        self:initUiDisplay()
        return true
    end
    self.netHandler = NetWork:addNetWorkListener({16, 5}, onServerRequest)
    local msg = {idx = {16,5},star = index}
    NetWork:sendToServer(msg)
end

return RankingViewController