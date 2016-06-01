--@auto code head
local BasePopView = require("app.baseMVC.BasePopView")
local UnionIconPopView = class("UnionIconPopView", BasePopView)

local Functions = require("app.common.Functions")

UnionIconPopView.csbResPath = "lk/csb"
UnionIconPopView.debug = true
UnionIconPopView.studioSpriteFrames = {"UnionUI_Text","CB_unionTankuang","UnionUI" }
--@auto code head end

--@Pre loading
UnionIconPopView.spriteFrameNames = 
    {
        "playerHeadRes"
    }

UnionIconPopView.animaNames = 
    {
    }
--@auto code uiInit
--add spriteFrames
if #UnionIconPopView.studioSpriteFrames > 0 then
    UnionIconPopView.spriteFrameNames = UnionIconPopView.spriteFrameNames or {}
    table.insertto(UnionIconPopView.spriteFrameNames, UnionIconPopView.studioSpriteFrames)
end
function UnionIconPopView:onInitUI()

    --output list
    self._ListView_icon_t = self.csbNode:getChildByName("Panel_icon_bai"):getChildByName("ListView_icon")
	
    --label list
    
    --button list
    
end
--@auto code uiInit end


--@auto code output func
function UnionIconPopView:getPopAction()
	Functions.printInfo(self.debug,"pop actionFunc is call")
end

function UnionIconPopView:onDisplayView()
	Functions.printInfo(self.debug,"pop action finish ")
    local listHandler = function(index, widget, model, data)
        local head = widget:getChildByName("Image_hend_icon"):getChildByName("Image_hero_hend")

        Functions.loadImageWithWidget(head, Functions:getGongHuiImageOfId(data) )

        local onShopBut = function(event)
            print("button click")
            --数据更新监听
            GameEventCenter:dispatchEvent({ name = UnionData.ADD_UNION_ICON_EVENT, data = data })
            self._controller_t:closeChildView(self)
        end
        widget:getChildByName("Image_hend_icon"):onTouch(Functions.createClickListener(onShopBut, "zoom"))

    end
    --绑定响应事件函数
    Functions.bindArryListWithData(self._ListView_icon_t,{ firstData = g_headicon }, listHandler,{direction = true,col = 5,firstSegment = 10,segment = 20})
end

function UnionIconPopView:onCreate()
	Functions.printInfo(self.debug,"child class create call ")
end
--@auto code output func end

return UnionIconPopView