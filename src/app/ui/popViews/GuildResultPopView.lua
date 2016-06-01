--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local GuildResultPopView = class("GuildResultPopView", BasePopView)

local Functions = require("app.common.Functions")

GuildResultPopView.csbResPath = "lk/csb"
GuildResultPopView.debug = true
GuildResultPopView.studioSpriteFrames = {"GvgUI_Text" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #GuildResultPopView.studioSpriteFrames > 0 then
    GuildResultPopView.spriteFrameNames = GuildResultPopView.spriteFrameNames or {}
    table.insertto(GuildResultPopView.spriteFrameNames, GuildResultPopView.studioSpriteFrames)
end
function GuildResultPopView:onInitUI()

    --output list
    self._Sprite_text_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_text")
	self._Sprite_meizi_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Sprite_meizi")
	
    --label list
    
    --button list
    self._Button_OK_t = self.csbNode:getChildByName("Panel_1"):getChildByName("Button_OK")
	self._Button_OK_t:onTouch(Functions.createClickListener(handler(self, self.onButton_okClick), "zoom"))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_ok btFunc
function GuildResultPopView:onButton_okClick()
    Functions.printInfo(self.debug,"Button_ok button is click!")
    self.close(self)
    GameCtlManager:pop(GameCtlManager:getCurrentController())
end
--@auto code Button_ok btFunc end

--@auto button backcall end


--@auto code output func
function GuildResultPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function GuildResultPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    local data = GuildBattleData:getBattleResult()
    if data.win == PlayerData.eventAttr.m_tongID then
        Functions.loadImageWithSprite(self._Sprite_text_t, "commonUI/res/lk/GvgUI/shengli_h.png")
        Functions.loadImageWithSprite(self._Sprite_meizi_t, "npc/gvg_suc.png")
    elseif data.lose == PlayerData.eventAttr.m_tongID  then
        Functions.loadImageWithSprite(self._Sprite_text_t, "commonUI/res/lk/GvgUI/shibai_h.png")
        Functions.loadImageWithSprite(self._Sprite_meizi_t, "npc/gvg_fail.png")
    else
        Functions.loadImageWithSprite(self._Sprite_text_t, "commonUI/res/lk/GvgUI/guankan_h.png")
        Functions.loadImageWithSprite(self._Sprite_meizi_t, "npc/gvg_suc.png")
    end
    
end

function GuildResultPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return GuildResultPopView