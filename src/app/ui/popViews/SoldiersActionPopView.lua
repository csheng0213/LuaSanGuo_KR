--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local SoldiersActionPopView = class("SoldiersActionPopView", BasePopView)

local Functions = require("app.common.Functions")

SoldiersActionPopView.csbResPath = "lk/csb"
SoldiersActionPopView.debug = true
SoldiersActionPopView.studioSpriteFrames = {"SoldiersPopUI_Text" }
--@auto code head end
--@Pre loading
SoldiersActionPopView.spriteFrameNames = 
    {
        "sodiersRes"
    }

SoldiersActionPopView.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #SoldiersActionPopView.studioSpriteFrames > 0 then
    SoldiersActionPopView.spriteFrameNames = SoldiersActionPopView.spriteFrameNames or {}
    table.insertto(SoldiersActionPopView.spriteFrameNames, SoldiersActionPopView.studioSpriteFrames)
end
function SoldiersActionPopView:onInitUI()

    --output list
    self._Panel_Action_t = self.csbNode:getChildByName("Panel_Action")
	self._Sprite_Soldiers_head_two_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_Soldiers_head_two_1")
	self._Image_Soldiers_head_two_icon_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_Soldiers_head_two_icon_1")
	self._Image_Soldiers_head_two_icon_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Image_Soldiers_head_two_icon_2")
	self._Particle_li_zi_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Sprite_Soldiers_head_two_1"):getChildByName("Particle_li_zi")
	self._Image_ladder_ok_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Image_ladder_ok")
	self._Panel_HP_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_HP")
	self._Text_head_hp_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_HP"):getChildByName("Text_head_hp_1")
	self._Text_head_hp_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_HP"):getChildByName("Text_head_hp_2")
	self._Panel_ATK_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_ATK")
	self._Text_head_atk_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_ATK"):getChildByName("Text_head_atk_2")
	self._Text_head_atk_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_ATK"):getChildByName("Text_head_atk_1")
	self._Panel_FS_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FS")
	self._Text_fa_shu_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FS"):getChildByName("Text_fa_shu_2")
	self._Text_fa_shu_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FS"):getChildByName("Text_fa_shu_1")
	self._Panel_FF_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FF")
	self._Text_fa_fang_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FF"):getChildByName("Text_fa_fang_2")
	self._Text_fa_fang_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_FF"):getChildByName("Text_fa_fang_1")
	self._Panel_KD_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_KD")
	self._Text_head_ke_2_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_KD"):getChildByName("Text_head_ke_2")
	self._Text_head_ke_1_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Panel_KD"):getChildByName("Text_head_ke_1")
	
    --label list
    
    --button list
    self._Button_ok_t = self.csbNode:getChildByName("Panel_Action"):getChildByName("Button_ok")
	self._Button_ok_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Panel_action btFunc
function SoldiersActionPopView:onPanel_actionClick()
    Functions.printInfo(self.debug,"Panel_action button is click!")
    --self._controller_t:closeChildView(self)
end
--@auto code Panel_action btFunc end

--@auto code Button_ok btFunc
function SoldiersActionPopView:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    self._controller_t:closeChildView(self)
end
--@auto code Button_ok btFunc end

--@auto button backcall end



--@auto code output func
function SoldiersActionPopView:getPopAction()
    Functions.printInfo(self.debug,"pop actionFunc is call")
end

function SoldiersActionPopView:onDisplayView(type)
    Functions.printInfo(self.debug,"pop action finish ")
    self._Panel_Action_t:setEnabled(false)

    local data = SoldiersData:getSoldiersDatas()
    local id = data[type[1]].m_id

    local head1 = ConfigHandler:getSoldierHeadImageOfId(id)
    local head2 = ConfigHandler:getSoldierHeadImageOfId(id - 1)
    Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_1_t, head1)
    Functions.loadImageWithWidget(self._Image_Soldiers_head_two_icon_2_t, head2)
    self:showText(id)
    self:showGuang()
end

function SoldiersActionPopView:onCreate()
    Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

--旋转的光
function SoldiersActionPopView:showGuang()
    Functions.printInfo(self.debug,"showGuang")
    
    

    local spr = Functions.createSpriteOfSfName("lk/uiFonts_res/xuanzhuan.png")
    local spr2 = Functions.createSpriteOfSfName("lk/uiFonts_res/xuanzhuan.png")
    local sX = self._Sprite_Soldiers_head_two_1_t:getContentSize().width/2
    local sY = self._Sprite_Soldiers_head_two_1_t:getContentSize().height/2
    spr:setPosition(sX, sY)
    spr2:setPosition(sX, sY)
    self._Sprite_Soldiers_head_two_1_t:addChild(spr, -1)
    self._Sprite_Soldiers_head_two_1_t:addChild(spr2, -1)

    local scaleTo = cc.ScaleTo:create(checknumber(0.1), 1, 1)
    local scaleTo2 = cc.ScaleTo:create(checknumber(0.1), 1, 1)
    local rotateBy = cc.RotateBy:create(2, 720)
    local rotateBy2 = cc.RotateBy:create(2, -720)
    local repeatForever = cc.RepeatForever:create(rotateBy)
    local repeatForever2 = cc.RepeatForever:create(rotateBy2)

    transition.execute(spr,repeatForever) 
    transition.execute(spr,scaleTo) 
    transition.execute(spr2,repeatForever2) 
    transition.execute(spr2,scaleTo2) 


    --缩放图片
    local scaleto_Head2 = cc.ScaleTo:create(0.5, 1, 0.001)
    local funcall = cc.CallFunc:create(handler(self,self.CallbackN))
    local spawn = cc.Spawn:create(scaleto_Head2, funcall)
    local seqHead2 = cc.Sequence:create(cc.DelayTime:create(0.5), spawn)
    self._Image_Soldiers_head_two_icon_2_t:runAction(seqHead2)

    local width = self._Particle_li_zi_t:getPositionX()
    local height = self._Particle_li_zi_t:getPositionY()
    --粒子
    local moveBy = cc.MoveBy:create(0.5, cc.p( 0, 100))
    local move = cc.Sequence:create(cc.DelayTime:create(0.5), moveBy)
    self._Particle_li_zi_t:runAction(move)
    self._Particle_li_zi_t:setDuration(1)

    local fadeinLadder = cc.FadeIn:create(0.1)--渐显
    local scaletoLadder = cc.ScaleTo:create(0.1, 1)--缩放

    local seqLadde = cc.Sequence:create(cc.DelayTime:create(0.6),fadeinLadder, scaletoLadder);
    self._Image_ladder_ok_t:runAction(seqLadde);

end

function SoldiersActionPopView:CallbackN()
    Functions.printInfo(self.debug,"CallbackN")
    --widget, time, x, y, DropNumX, DropNumY, duration, Handler
--    local handler = function()
--        self:AllTextAction()
--    end
    Functions.playSound("soldierupgrade.mp3")
    Functions.movePanel(self._Panel_HP_t, 0.5, 0, -400, 0.1)
    Functions.movePanel(self._Panel_ATK_t, 0.5, 0, -400, 0.3)
    Functions.movePanel(self._Panel_FS_t, 0.5, 0, -400, 0.5)
    Functions.movePanel(self._Panel_FF_t, 0.5, 0, -400, 0.7)
    Functions.movePanel(self._Panel_KD_t, 0.5, 0, -400, 0.9, handler(self,self.AllTextAction))
    self._Panel_Action_t:setEnabled(true)

end

function SoldiersActionPopView:AllTextAction()
    --self._Panel_Action_t:setEnabled(true)
    
    self._Button_ok_t:setVisible(true)
    
end

function SoldiersActionPopView:showText(id)
    local hp = Functions:getSoldierhHp(id, 1)
    local atk = Functions:getSoldierhAtk(id, 1)
    local fas = Functions:getSoldierhFas(id, 1)
    local faf = Functions:getSoldierhFaf(id, 1) 

    Functions.initLabelOfString( self._Text_head_hp_1_t, LanguageConfig.language_Soldiers_1..tostring(hp), self._Text_head_atk_1_t, LanguageConfig.language_Soldiers_2..tostring(atk), self._Text_fa_shu_1_t, 
        LanguageConfig.language_Soldiers_3..tostring(fas), self._Text_fa_fang_1_t, LanguageConfig.language_Soldiers_4..tostring(faf), self._Text_head_ke_1_t, LanguageConfig.language_Soldiers_5..ConfigHandler:getKeZhiOfId(id) )

    Functions.initLabelOfString(self._Text_head_hp_2_t, LanguageConfig.language_Soldiers_1..tostring(hp), self._Text_head_atk_2_t, LanguageConfig.language_Soldiers_2..tostring(atk), self._Text_fa_shu_2_t, LanguageConfig.language_Soldiers_3..tostring(fas),
        self._Text_fa_fang_2_t, LanguageConfig.language_Soldiers_4..tostring(faf), self._Text_head_ke_2_t, LanguageConfig.language_Soldiers_5..ConfigHandler:getKeZhiOfId(id))
    
    id = id - 1
    local _class = ConfigHandler:getSoldierLadderOfId(id)
    local hp = Functions:getSoldierhHp(id, g_csBaseCfg.soldierClsLevel[_class])
    local atk = Functions:getSoldierhAtk(id, g_csBaseCfg.soldierClsLevel[_class])
    local fas = Functions:getSoldierhFas(id, g_csBaseCfg.soldierClsLevel[_class])
    local faf = Functions:getSoldierhFaf(id, g_csBaseCfg.soldierClsLevel[_class])
    Functions.initLabelOfString( self._Text_head_hp_1_t, LanguageConfig.language_Soldiers_1..tostring(hp), self._Text_head_atk_1_t, LanguageConfig.language_Soldiers_2..tostring(atk), self._Text_fa_shu_1_t, 
        LanguageConfig.language_Soldiers_3..tostring(fas), self._Text_fa_fang_1_t, LanguageConfig.language_Soldiers_4..tostring(faf), self._Text_head_ke_1_t, LanguageConfig.language_Soldiers_5..ConfigHandler:getKeZhiOfId(id) )

end


return SoldiersActionPopView



