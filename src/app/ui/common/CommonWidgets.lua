local CommonWidgets = {}

CommonWidgets.csbFilePath = "commonUI/csb/widgets.csb"

function CommonWidgets:init()
    self.csbNode = cc.CSLoader:createNode(self.csbFilePath)
    self.csbNode:retain()
end

function CommonWidgets:getBlackColorLayer()
    
    if not self.blackColorLayer then
        self.blackColorLayer = self.csbNode:getChildByName("blackColorLayer"):retain()
    end
    
    return self.blackColorLayer:clone():setParent(nil)
end

function CommonWidgets:getTipInfoPanel()
	
	if not self.tipInfoPanel then
        self.tipInfoPaenl = self.csbNode:getChildByName("TipPanel"):retain()
	end
	
    return self.tipInfoPaenl:clone():setParent(nil)
end
function CommonWidgets:getInfPanel()
    
    if not self.infPanel then
        self.infPanel = self.csbNode:getChildByName("infPanel"):retain()
    end
    
    return self.infPanel:clone():setParent(nil)
end

function CommonWidgets:getSpeakerPanel()

    if not self.tipInfoPanel then
        self.tipInfoPaenl = self.csbNode:getChildByName("speakerPanel"):retain()
    end
    return self.tipInfoPaenl:clone():setParent(nil)
end

function CommonWidgets:getLoadingPanel()
    if not self.loadingPanel then
        self.loadingPanel = self.csbNode:getChildByName("loadingPanel"):retain()
    end
    return self.loadingPanel:clone():setParent(nil)
end

function CommonWidgets:getDialoguePanel()
    if not self.dialoguePanel then
        self.dialoguePanel = self.csbNode:getChildByName("dialoguePanel"):retain()
    end
    return self.dialoguePanel:clone():setParent(nil)
end

function CommonWidgets:getNewGuidePanel()
    if not self.newGuidePanel then
        self.newGuidePanel = self.csbNode:getChildByName("newGuidePanel"):retain()
    end
    return self.newGuidePanel:clone():setParent(nil)
end

return CommonWidgets

