--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local EquipmentViewController = class("EquipmentViewController", BaseViewController)

local Functions = require("app.common.Functions")

EquipmentViewController.debug = true
EquipmentViewController.modulePath = ...
EquipmentViewController.studioSpriteFrames = {"EquipmentUI","EquipmentUI_Text","CB_blackbg" }
--@auto code head end

--@Pre loading
EquipmentViewController.spriteFrameNames = 
    {
        "headPilistRes","equipmentRes"
    }

EquipmentViewController.animaNames = 
    {
        "An_enhance"
    }

EquipmentViewController.posType =
{
    main = 1,
    vice1 = 2,
    vice2 = 3
}
--@auto code uiInit
--add spriteFrames
if #EquipmentViewController.studioSpriteFrames > 0 then
    EquipmentViewController.spriteFrameNames = EquipmentViewController.spriteFrameNames or {}
    table.insertto(EquipmentViewController.spriteFrameNames, EquipmentViewController.studioSpriteFrames)
end
function EquipmentViewController:onDidLoadView()

    --output list
    self._topNode_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("topNode")
	self._embattleTable_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("embattleTable")
	self._mainHero_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("mainHero")
	self._vicehero1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("vicehero1")
	self._vicehero2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("vicehero2")
	self._selectTable_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("selectTable")
	self._heroView_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("heroView")
	self._equipPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("equipPanel")
	self._attrPanel_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("attrPanel")
	self._name_t = self.view_t.csbNode:getChildByName("main"):getChildByName("board"):getChildByName("Image_2213"):getChildByName("name")
	
    --label list
    
    --button list
    self._backBt_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("backBt")
	self._backBt_t:onTouch(Functions.createClickListener(handler(self, self.onBackbtClick), ""))

	self._helpBt_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("topBarPanel"):getChildByName("topbarBg"):getChildByName("Panel_3"):getChildByName("helpBt_4")
	self._helpBt_4_t:onTouch(Functions.createClickListener(handler(self, self.onHelpbt_4Click), ""))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Backbt btFunc
function EquipmentViewController:onBackbtClick()
    Functions.printInfo(self.debug,"Backbt button is click!")
    GameCtlManager:pop(self)
end
--@auto code Backbt btFunc end

--@auto code Helpbt_4 btFunc
function EquipmentViewController:onHelpbt_4Click()
    Functions.printInfo(self.debug,"Helpbt_4 button is click!")
    NoticeManager:openNotice(self, {type = NoticeManager.EQUIPMENT})
end
--@auto code Helpbt_4 btFunc end

--@auto button backcall end


--@auto code view display func
function EquipmentViewController:onCreate()
    Functions.printInfo(self.debug_b," EquipmentViewController controller create!")
end

function EquipmentViewController:onChangeView( )
    -- body
end
function EquipmentViewController:openBgMusic()
    Audio.playMusic("sound/main2.mp3",true)
end
function EquipmentViewController:onDisplayView()
    Functions.printInfo(self.debug_b," EquipmentViewController view enter display!")
    Functions.setPopupKey("equipment")
    --新手引导相关
    self._equip1Bt_t = self._equipPanel_t:getChildByName("equip_1"):getChildByName("equipmentPanel")
    --end
    Functions.initResNodeUI(self._topNode_t,{"jinbi","yuanbao","soul"})
    if PlayerData.eventAttr.m_level < g_csOpen.TianTiOpen.level then
         self._embattleTable_t:getChildByName("tb2"):setVisible(false)
         self._embattleTable_t:getChildByName("tb1"):setTouchEnabled(false)
    end 
    self.embattleType = EmbattleData.EmbattleTypeEnum.attack
    -- self:updateEmbattle()
    --阵型切换标签绑定
    local embattleTableListener = function(target)
        if target == "tb1" then
            self.embattleType = EmbattleData.EmbattleTypeEnum.attack
            self:updateEmbattle()
        elseif target == "tb2" then
            self.embattleType = EmbattleData.EmbattleTypeEnum.defense
            self:updateEmbattle()
        end
    end
    Functions.initTabComWithSimple({widget = self._embattleTable_t ,listener = embattleTableListener, firstName = "tb1"})
end
--@auto code view display func end
function EquipmentViewController:initDisplay( )
    self:showView()
    ------------------------------------------------------------------------------------------------------------------
    --初始化阵型英雄mark
    EmbattleData:initHeroMark(self.embattleType)

    --初始化上阵英雄头像
    self:initAllHeroHead()
    ------------------------------------------------------------------------------------------------------------------
    --初始化上阵英雄头像
    if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id >0 then
        self:showEquipment(self.posType.main)
    else
        local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(5))
        Functions.cleanEquipNode(equip,false)
        local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(6))
        Functions.cleanEquipNode(equip,false)
    end
    --英雄切换标签绑定
    local tabs = {}
    tabs[#tabs+1] =self._selectTable_t:getChildByName("tb1")
    tabs[#tabs+1] =self._selectTable_t:getChildByName("tb2")
    tabs[#tabs+1] =self._selectTable_t:getChildByName("tb3")
    local selectTableListener = function(target)
        local handler = function ()
            GameCtlManager:push("app.ui.embattleSystem.EmbattleViewController",{data = {jumpType = JumpType.equipToEmbattle,jumpData = {embattleType = self.embattleType}}}) 
        end
        if target == "tb1" then
            if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id >0 then
                self:showEquipment(self.posType.main)
            else
                NoticeManager:openTips(self, {title = LanguageConfig.language_equip_1,handler = handler})
            end
        elseif target == "tb2" then
            if EmbattleData.EmbattleInf.ViceHeros[1] ~= nil and EmbattleData.EmbattleInf.ViceHeros[1].id >0 then
                self:showEquipment(self.posType.vice1)
            else
                Functions.openTabs( tabs ,tabs[1])
                if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id >0 then
                    self:showEquipment(self.posType.main)
                end
                NoticeManager:openTips(self, {title = LanguageConfig.language_equip_1,handler = handler})               
            end
        elseif target == "tb3" then
            if EmbattleData.EmbattleInf.ViceHeros[2] ~= nil and EmbattleData.EmbattleInf.ViceHeros[2].id >0 then 
                self:showEquipment(self.posType.vice2)
            else
                Functions.openTabs( tabs ,tabs[1])
                if EmbattleData.EmbattleInf.MainHero[1] ~= nil and EmbattleData.EmbattleInf.MainHero[1].id >0 then
                    self:showEquipment(self.posType.main)
                end
                NoticeManager:openTips(self, {title = LanguageConfig.language_equip_1,handler = handler})                
            end
        end
    end
    Functions.initTabComWithSimple({widget = self._selectTable_t ,listener = selectTableListener, firstName = "tb1"})
end
--显示装备信息
function EquipmentViewController:showEquipment(pos)
    self:setBottomBan(pos)
    self:displayAllEquipment(pos)
    self:displayEquipmentAtrr(self._attrPanel_t,self.embattleType,pos)
    if pos == self.posType.main then
        self:setHeroView(self._heroView_t,EmbattleData.EmbattleInf.MainHero[1])
        self:setHeroName(self._name_t,EmbattleData.MainHeroMark)
    elseif pos == self.posType.vice1 then
        self:setHeroView(self._heroView_t,EmbattleData.EmbattleInf.ViceHeros[1])
        self:setHeroName(self._name_t,EmbattleData.ViceHero1Mark)
    elseif pos == self.posType.vice2 then
        self:setHeroView(self._heroView_t,EmbattleData.EmbattleInf.ViceHeros[2])
        self:setHeroName(self._name_t,EmbattleData.ViceHero2Mark)
    end
end
--更新阵型信息
function EquipmentViewController:updateEmbattle()
    EmbattleData:cleanAllEmbattleData()
    EmbattleData:loadEmbattleData(self.embattleType,handler(self,self.initDisplay))
end
--初始化上阵英雄头像
function EquipmentViewController:initAllHeroHead()
    EmbattleData:initHeroMark(self.embattleType)
    self:setHeroHead(self._mainHero_t,EmbattleData.EmbattleInf.MainHero[1],EmbattleData.MainHeroMark)
    self:setHeroHead(self._vicehero1_t,EmbattleData.EmbattleInf.ViceHeros[1],EmbattleData.ViceHero1Mark)
    self:setHeroHead(self._vicehero2_t,EmbattleData.EmbattleInf.ViceHeros[2],EmbattleData.ViceHero2Mark)
end
--设置单个上阵英雄显示
function EquipmentViewController:setHeroHead(target,heroInf,mark)
    local head = target:getChildByName("head")
    Functions.cleanHeroHead(head)
    if heroInf ~= nil and heroInf.id ~= 0 then
        Functions.getHeroHead(head,{mark = mark})
    end
end
--设置英雄图片
function EquipmentViewController:setHeroView(target,heroInf)
    if heroInf ~= nil and heroInf.id ~= 0 then
        --图片
        target:setVisible(true)

        local bigClass, smallClass = Functions.formatHeroClass(heroInf.class)
        local star = ConfigHandler:getHeroStarOfId(heroInf.id) 
        local heroImg = ConfigHandler:getHeroCardImageOfId(heroInf.id)
        if star > 5 then
           local heroImg = ConfigHandler:getHeroCardImageOfId(heroInf.id,bigClass)
           local heroImgTemp = string.split(heroImg,".png")
           Functions.loadImageWithSprite(target,heroImgTemp[1] .. "_N.png",0.8)
        else           
           local heroImg = ConfigHandler:getHeroCardImageOfId(heroInf.id)    
           Functions.loadImageWithSprite(target,heroImg,0.7)
        end
    else
        target:setVisible(false)
    end
end
--设置英雄名字
function EquipmentViewController:setHeroName(target,heromark)
    if heromark > 0 then
       --名字
        local heroInf= HeroCardData:searchHeroOfMark(heromark)
        -- if heroInf.m_class >= 1 then
        -- target:setString("LV." .. heroInf.m_level .. ConfigHandler:getHeroNameOfId(heroInf.m_id) .. "+" .. heroInf.m_class)        
        -- else
        --     target:setString("LV." .. heroInf.m_level .. ConfigHandler:getHeroNameOfId(heroInf.m_id))
        -- end
        local bigClass = Functions.formatHeroClass(heroInf.m_class)
        target:setString("LV." .. heroInf.m_level .. ConfigHandler:getHeroNameOfId(heroInf.m_id,bigClass))
        target:setVisible(true) 
    else
        target:setVisible(false)
    end
end
--设置选择底板效果
function EquipmentViewController:setBottomBan(type)
    if type == self.posType.main then
        self._mainHero_t:getChildByName("choose"):setVisible(true)
        self._vicehero1_t:getChildByName("choose"):setVisible(false)
        self._vicehero2_t:getChildByName("choose"):setVisible(false)
    elseif type == self.posType.vice1 then
        self._mainHero_t:getChildByName("choose"):setVisible(false)
        self._vicehero1_t:getChildByName("choose"):setVisible(true)
        self._vicehero2_t:getChildByName("choose"):setVisible(false)
    elseif type == self.posType.vice2 then
        self._mainHero_t:getChildByName("choose"):setVisible(false)
        self._vicehero1_t:getChildByName("choose"):setVisible(false)
        self._vicehero2_t:getChildByName("choose"):setVisible(true)
    end
end
--显示所有装备
function EquipmentViewController:displayAllEquipment(pos)
    self:cleanAllEquipDisplay()
    for i = 1,6 do 
        if i < 5 then
            local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
            self:showSigleEquip(equip,self.embattleType,pos,i)
            local clickHandler = function()
                
                local mark =  EquipmentData:getEquipApparelMark(self.embattleType,pos,i)
                if mark < 1 then
                    -- local equipmentView = require("app.ui.popViews.EquipmentPopView"):new()--cs
                    self:openChildView("app.ui.popViews.EquipmentPopView",{isRemove = false,name = "equipPopView",data = {tag = i,embattleType = self.embattleType,pos = pos,mark = mark}})
                else
                    -- local equipInfView = require("app.ui.popViews.EquipmentInfPopView"):new()
                    self:openChildView("app.ui.popViews.EquipmentInfPopView",{isRemove = false,name = "equipInfViewTemp",
                            data={selectedEquipMark = mark,
                            embattleType = self.embattleType,
                            pos = pos,
                            tag = i,
                            jumpType = 2,handler = function( )
                                    self:showSigleEquip(equip,self.embattleType,pos,i)
                                    self:displayEquipmentAtrr(self._attrPanel_t,self.embattleType,pos)
                            end}})
                end
            end
            equip:getChildByName("equipmentPanel"):onTouch(Functions.createClickListener(clickHandler, ""))
        else
            local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
            Functions.cleanEquipNode(equip,false)
        end
    end
end
--清空所有装备显示
function EquipmentViewController:cleanAllEquipDisplay()
    for i = 1,4 do 
        local equip = self._equipPanel_t:getChildByName("equip_" .. tostring(i))
        Functions.cleanEquipNode(equip)
    end
end
--显示单个装备
function EquipmentViewController:showSigleEquip(target,embattleType,pos,index)
    local equipMark = EquipmentData:getEquipApparelMark(embattleType,pos,index)
    Functions.getEquipNode(target,{mark=equipMark})
    if equipMark ~= nil and  equipMark < 1 then
        self:setEquipSlot(target,index)    
    end
end
--设置装备属性
function EquipmentViewController:displayEquipmentAtrr(target,embattleType,pos)
--    local attack,rdAttack = 0 , 0
--    local hp, rdHp = 0, 0
--    local fas, rdFas = 0, 0
--    local faf, rdFaf = 0, 0
    local heroMark = EmbattleData:getHeroMarkOfPos(embattleType,pos)
    local equipMarks = EquipmentData:getEquipMarks(embattleType,pos)

    local tatal ,attack,hp,fas,faf = Functions.getHeroFightAttrs({heroMark = heroMark,partHeroMarks = EmbattleData.PartHeroMark,equipMarks = equipMarks})
    -- for i = 1, 4 do
    --    local mark = EquipmentData:getEquipApparelMark(embattleType,pos,i)
    --    if mark > 0 then
    --         local equip = EquipmentData:getEquipInf(mark)
    --         local attrType = ConfigHandler:getEquipAttrTypeOfId(equip.m_id)
    --         if attrType == 1 then
    --             attack = attack + ConfigHandler:getEquipAttrValueOfId(equip.m_id)
    --         elseif attrType == 2 then
    --             faf = faf + ConfigHandler:getEquipAttrValueOfId(equip.m_id)
    --         elseif attrType == 3 then
    --             hp = hp + ConfigHandler:getEquipAttrValueOfId(equip.m_id)
    --         elseif attrType == 4 then
    --             fas = fas + ConfigHandler:getEquipAttrValueOfId(equip.m_id)
    --         end 

    --         if equip.rdAttrType == 1 then
    --             rdAttack = rdAttack + equip.rdAttrPercent
    --         elseif attrType == 2 then
    --             rdFaf = rdFaf + equip.rdAttrPercent
    --         elseif attrType == 3 then
    --             rdHp = rdHp + equip.rdAttrPercent
    --         elseif attrType == 4 then
    --             rdFas = rdFas + equip.rdAttrPercent
    --         end 
    --    end
    -- end 
    local attackObj = target:getChildByName("attack")
    local fafObj = target:getChildByName("faf")
    local hpObj = target:getChildByName("hp")
    local fasObj = target:getChildByName("fas")
    attackObj:setString(tostring(attack))
    fafObj:setString(tostring(faf))
    hpObj:setString(tostring(hp))
    fasObj:setString(tostring(fas))
--    if rdAttack > 0 then
--    attackObj:setString("+" .. tostring(attack) .. "  +" .. tostring(rdAttack) .. "%(随机)")
--    else
--        attackObj:setString("+" .. tostring(attack))
--    end
--    if rdFaf > 0 then
--        fafObj:setString("+" .. tostring(faf) .. "  +" .. tostring(rdFaf) .. "%(随机)")
--    else
--        fafObj:setString("+" .. tostring(faf))
--    end
--    if rdHp > 0 then
--        hpObj:setString("+" .. tostring(hp) .. "  +" .. tostring(rdHp) .. "%(随机)")
--    else
--        hpObj:setString("+" .. tostring(hp))
--    end
--    if rdFas > 0 then
--        fasObj:setString("+" .. tostring(fas) .. "  +" .. tostring(rdFas) .. "%(随机)")
--    else
--        fasObj:setString("+" .. tostring(fas))
--    end
end
--
--设置装备栏阴影
function EquipmentViewController:setEquipSlot(target,type)
    local equip=target:getChildByName("equipmentPanel"):getChildByName("equipment")
    equip:setScale(0.8)
    Functions.loadImageWithWidget(equip,"yy" .. tostring(type) .. ".png")
    equip:setVisible(true)
end
--
function EquipmentViewController:onReceivePopData(jump) 
    self:updateEmbattle()
end
return EquipmentViewController