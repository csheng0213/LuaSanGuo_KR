--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local HelpPopView = class("HelpPopView", BasePopView)

local Functions = require("app.common.Functions")

HelpPopView.csbResPath = "tyj/csb"
HelpPopView.debug = true
HelpPopView.studioSpriteFrames = {"HelpPopUI" }
--@auto code head end
HelpPopView.spriteFrameNames = 
    {
    }

--@auto code uiInit
--add spriteFrames
if #HelpPopView.studioSpriteFrames > 0 then
    HelpPopView.spriteFrameNames = HelpPopView.spriteFrameNames or {}
    table.insertto(HelpPopView.spriteFrameNames, HelpPopView.studioSpriteFrames)
end
function HelpPopView:onInitUI()

    --output list
    
    --label list
    
    --button list
    self._closeBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("closeBt")
	self._closeBt_t:onTouch(Functions.createClickListener(handler(self, self.onClosebtClick), ""))

	self._faqBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("faqBt")
	self._faqBt_t:onTouch(Functions.createClickListener(handler(self, self.onFaqbtClick), ""))

	self._gonglvBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("gonglvBt")
	self._gonglvBt_t:onTouch(Functions.createClickListener(handler(self, self.onGonglvbtClick), ""))

	self._forumBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("forumBt")
	self._forumBt_t:onTouch(Functions.createClickListener(handler(self, self.onForumbtClick), ""))

	self._quitionBt_t = self.csbNode:getChildByName("Panel_140"):getChildByName("quitionBt")
	self._quitionBt_t:onTouch(Functions.createClickListener(handler(self, self.onQuitionbtClick), ""))
end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Closebt btFunc
function HelpPopView:onClosebtClick()
    Functions.printInfo(self.debug,"Closebt button is click!")
    self:close()
end
--@auto code Closebt btFunc end

--@auto code Faqbt btFunc
function HelpPopView:onFaqbtClick()
    Functions.printInfo(self.debug,"Faqbt button is click!")
    Functions.callJavaFuc(function ( )
    	NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.faqUrl,isAddParameter = false})
    end)
end
--@auto code Faqbt btFunc end

--@auto code Gonglvbt btFunc
function HelpPopView:onGonglvbtClick()
    Functions.printInfo(self.debug,"Gonglvbt button is click!")
    Functions.callJavaFuc(function ( )
    	NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.strategyUrl,isAddParameter = false})
    end)
end
--@auto code Gonglvbt btFunc end

--@auto code Forumbt btFunc
function HelpPopView:onForumbtClick()
    Functions.printInfo(self.debug,"Forumbt button is click!")
    Functions.callJavaFuc(function ( )
    	NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.forumUrl,isAddParameter = false})
        -- NativeUtil:javaCallHanler({command = "openCafeHome"})
    end)
end
--@auto code Forumbt btFunc end

--@auto code Quitionbt btFunc
function HelpPopView:onQuitionbtClick()
    Functions.printInfo(self.debug,"Quitionbt button is click!")
    Functions.callJavaFuc(function ( )
        local p_title = ""
        local p_email = ""
        local App_Market = SDKConfig.AppMarket[G_SDKType]
        -- local App_Version = tostring(CurrentBigVersion) .. "." .. tostring(CurrentMidVersion) .. "." .. tostring(CurrentMinVersion)
        local App_Version = Functions.getCurVersion()
        local Platform_of_Using_logging = GameState:getLoginType() .. ":" .. GameState.storeAttr.NaverUserName_s
        local Character_Name = PlayerData.eventAttr.m_name
        local userId = PlayerData.eventAttr.m_uid 
    	NativeUtil:javaCallHanler({command = "nanoo",url = SDKConfig.oneToOneUrl .. "?p_title=" .. p_title
            .. "&p_email=" .. p_email .. "&App_Market=" ..  App_Market .. "&App_Version=" .. App_Version
            .. "&Platform_of_Using_logging=" .. Platform_of_Using_logging .. "&Character_Name=" .. Character_Name .."&User_ID=" .. userId ,isAddParameter = true})
    end)
end
--@auto code Quitionbt btFunc end

--@auto button backcall end


--@auto code output func
function HelpPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function HelpPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
end

function HelpPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return HelpPopView