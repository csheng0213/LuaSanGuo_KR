--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local EditTipsPopView = class("EditTipsPopView", BasePopView)

local Functions = require("app.common.Functions")

EditTipsPopView.csbResPath = "tyj/csb"
EditTipsPopView.debug = true
EditTipsPopView.studioSpriteFrames = {"CBO_taxKuang","CBO_union_dialogue_ban" }
--@auto code head end


--@auto code uiInit
--add spriteFrames
if #EditTipsPopView.studioSpriteFrames > 0 then
    EditTipsPopView.spriteFrameNames = EditTipsPopView.spriteFrameNames or {}
    table.insertto(EditTipsPopView.spriteFrameNames, EditTipsPopView.studioSpriteFrames)
end
function EditTipsPopView:onInitUI()

    --output list
    self._Panel_2_t = self.csbNode:getChildByName("Panel_2")
	self._TextField_t = self.csbNode:getChildByName("Panel_2"):getChildByName("TextField")
	
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_2"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._affirmBt_t = self.csbNode:getChildByName("Panel_2"):getChildByName("affirmBt")
	self._affirmBt_t:onTouch(Functions.createClickListener(handler(self, self.onAffirmbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function EditTipsPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto code Affirmbt btFunc
function EditTipsPopView:onAffirmbtClick()
    Functions.printInfo(self.debug,"Affirmbt button is click!")
    self.handler(self._TextField_t:getString())
    self:close()
end
--@auto code Affirmbt btFunc end

--@auto button backcall end


--@auto code output func
function EditTipsPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function EditTipsPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
	self._TextField_t:setPlaceHolder(LanguageConfig.ui_language_Chat_2)
	if self.text ~= nil then
        self._TextField_t:setPlaceHolder(self.text)
    end
end

function EditTipsPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end
function EditTipsPopView:setPlaceHolder(text)
    self.text = text
end
function EditTipsPopView:setHandler( handler )
	self.handler = handler
end
return EditTipsPopView