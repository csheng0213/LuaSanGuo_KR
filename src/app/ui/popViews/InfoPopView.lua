--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local InfoPopView = class("InfoPopView", BasePopView)

local Functions = require("app.common.Functions")

InfoPopView.csbResPath = "cs/csb"
InfoPopView.debug = true
InfoPopView.studioSpriteFrames = {"InfoPopUI","CBO_announcementBg" }
--@auto code head end

--@Pre loading
InfoPopView.spriteFrameNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #InfoPopView.studioSpriteFrames > 0 then
    InfoPopView.spriteFrameNames = InfoPopView.spriteFrameNames or {}
    table.insertto(InfoPopView.spriteFrameNames, InfoPopView.studioSpriteFrames)
end
function InfoPopView:onInitUI()

    --output list
    self._info_t = self.csbNode:getChildByName("main"):getChildByName("ScrollView_1"):getChildByName("info")
	
    --label list
    
    --button list
    self._close_bt_t = self.csbNode:getChildByName("main"):getChildByName("close_bt")
	self._close_bt_t:onTouch(Functions.createClickListener(handler(self, self.onClose_btClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Close_bt btFunc
function InfoPopView:onClose_btClick()
    Functions.printInfo(self.debug,"Close_bt button is click!")
    
    self:close()
end
--@auto code Close_bt btFunc end

--@auto button backcall end


--@auto code output func
function InfoPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function InfoPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")

    self:showView()
end

function InfoPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
	
    local scrollView = self.csbNode:getChildByName("main"):getChildByName("ScrollView_1")  
    if self._currentInfo then

        self._info_t:ignoreContentAdaptWithSize(false)
        self._info_t:setTextAreaSize(cc.size(594,0))

        self._info_t:setString(self._currentInfo)
        self._info_t:setString(self._currentInfo)
        local renderSize = self._info_t:getVirtualRendererSize()
        self._info_t:setTextAreaSize(renderSize)
        scrollView:setInnerContainerSize(renderSize)  

        local height = nil
        if renderSize.height > scrollView:getSize().height then
            height = renderSize.height
        else
            height = scrollView:getSize().height
        end
        self._info_t:setPositionY(height)
        
    end

end
--@auto code output func end

--@publice func 
function InfoPopView:setInfo(info)
    self._currentInfo = info
end

function InfoPopView:setTitle(title)
    -- if not title then
    -- end
end

function InfoPopView:hideClose()
    self._close_bt_t:setVisible(false)
end


return InfoPopView