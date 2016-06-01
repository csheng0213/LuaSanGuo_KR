--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local GuildBattleMapViewController = class("GuildBattleMapViewController", BaseViewController)

local Functions = require("app.common.Functions")

GuildBattleMapViewController.debug = true
GuildBattleMapViewController.modulePath = ...
GuildBattleMapViewController.studioSpriteFrames = {"GvgUI_Text","GuildBattleMapUI","UnionUI" }
--@auto code head end

--@Pre loading
GuildBattleMapViewController.spriteFrameNames = 
    {
    }

GuildBattleMapViewController.animaNames = 
    {
        "combatAni"
    }


--@auto code uiInit
--add spriteFrames
if #GuildBattleMapViewController.studioSpriteFrames > 0 then
    GuildBattleMapViewController.spriteFrameNames = GuildBattleMapViewController.spriteFrameNames or {}
    table.insertto(GuildBattleMapViewController.spriteFrameNames, GuildBattleMapViewController.studioSpriteFrames)
end
function GuildBattleMapViewController:onDidLoadView()

    --output list
    self._Image_guild_map_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map")
	self._Panel_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1")
	self._Sprite_donghua_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Sprite_donghua_1")
	self._Text_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Sprite_name_bg"):getChildByName("Text_name_1")
	self._Sprite_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Sprite_name_1")
	self._Panel_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Sprite_name_1"):getChildByName("Panel_name_1")
	self._Text_occupy_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Sprite_name_1"):getChildByName("Panel_name_1"):getChildByName("Text_occupy_name_1")
	self._Panel_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2")
	self._Sprite_donghua_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Sprite_donghua_2")
	self._Text_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Sprite_name_bg_2"):getChildByName("Text_name_2")
	self._Sprite_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Sprite_name_2")
	self._Panel_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Sprite_name_2"):getChildByName("Panel_name_2")
	self._Text_occupy_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Sprite_name_2"):getChildByName("Panel_name_2"):getChildByName("Text_occupy_name_2")
	self._Panel_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3")
	self._Sprite_donghua_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Sprite_donghua_3")
	self._Text_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Sprite_name_bg_3"):getChildByName("Text_name_3")
	self._Sprite_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Sprite_name_3")
	self._Panel_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Sprite_name_3"):getChildByName("Panel_name_3")
	self._Text_occupy_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Sprite_name_3"):getChildByName("Panel_name_3"):getChildByName("Text_occupy_name_3")
	self._Panel_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4")
	self._Sprite_donghua_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Sprite_donghua_4")
	self._Text_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Sprite_name_bg_4"):getChildByName("Text_name_4")
	self._Sprite_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Sprite_name_4")
	self._Panel_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Sprite_name_4"):getChildByName("Panel_name_4")
	self._Text_occupy_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Sprite_name_4"):getChildByName("Panel_name_4"):getChildByName("Text_occupy_name_4")
	self._Panel_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5")
	self._Sprite_donghua_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Sprite_donghua_5")
	self._Text_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Sprite_name_bg_5"):getChildByName("Text_name_5")
	self._Sprite_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Sprite_name_5")
	self._Panel_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Sprite_name_5"):getChildByName("Panel_name_5")
	self._Text_occupy_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Sprite_name_5"):getChildByName("Panel_name_5"):getChildByName("Text_occupy_name_5")
	self._Panel_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6")
	self._Sprite_donghua_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Sprite_donghua_6")
	self._Text_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Sprite_name_bg_6"):getChildByName("Text_name_6")
	self._Sprite_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Sprite_name_6")
	self._Panel_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Sprite_name_6"):getChildByName("Panel_name_6")
	self._Text_occupy_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Sprite_name_6"):getChildByName("Panel_name_6"):getChildByName("Text_occupy_name_6")
	self._Panel_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7")
	self._Sprite_donghua_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Sprite_donghua_7")
	self._Text_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Sprite_name_bg_7"):getChildByName("Text_name_7")
	self._Sprite_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Sprite_name_7")
	self._Panel_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Sprite_name_7"):getChildByName("Panel_name_7")
	self._Text_occupy_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Sprite_name_7"):getChildByName("Panel_name_7"):getChildByName("Text_occupy_name_7")
	self._Panel_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8")
	self._Sprite_donghua_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Sprite_donghua_8")
	self._Text_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Sprite_name_bg_8"):getChildByName("Text_name_8")
	self._Sprite_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Sprite_name_8")
	self._Panel_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Sprite_name_8"):getChildByName("Panel_name_8")
	self._Text_occupy_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Sprite_name_8"):getChildByName("Panel_name_8"):getChildByName("Text_occupy_name_8")
	self._Panel_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9")
	self._Sprite_donghua_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Sprite_donghua_9")
	self._Text_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Sprite_name_bg_9"):getChildByName("Text_name_9")
	self._Sprite_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Sprite_name_9")
	self._Panel_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Sprite_name_9"):getChildByName("Panel_name_9")
	self._Text_occupy_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Sprite_name_9"):getChildByName("Panel_name_9"):getChildByName("Text_occupy_name_9")
	self._Panel_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10")
	self._Sprite_donghua_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Sprite_donghua_10")
	self._Text_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Sprite_name_bg_10"):getChildByName("Text_name_10")
	self._Sprite_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Sprite_name_10")
	self._Panel_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Sprite_name_10"):getChildByName("Panel_name_10")
	self._Text_occupy_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Sprite_name_10"):getChildByName("Panel_name_10"):getChildByName("Text_occupy_name_10")
	self._Panel_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11")
	self._Sprite_donghua_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Sprite_donghua_11")
	self._Text_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Sprite_name_bg_11"):getChildByName("Text_name_11")
	self._Sprite_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Sprite_name_11")
	self._Panel_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Sprite_name_11"):getChildByName("Panel_name_11")
	self._Text_occupy_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Sprite_name_11"):getChildByName("Panel_name_11"):getChildByName("Text_occupy_name_11")
	self._Panel_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12")
	self._Sprite_donghua_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Sprite_donghua_12")
	self._Text_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Sprite_name_bg_12"):getChildByName("Text_name_12")
	self._Sprite_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Sprite_name_12")
	self._Panel_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Sprite_name_12"):getChildByName("Panel_name_12")
	self._Text_occupy_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Sprite_name_12"):getChildByName("Panel_name_12"):getChildByName("Text_occupy_name_12")
	self._Panel_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13")
	self._Sprite_donghua_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Sprite_donghua_13")
	self._Text_name_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Sprite_name_bg_13"):getChildByName("Text_name_13")
	self._Sprite_name_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Sprite_name_13")
	self._Panel_name_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Sprite_name_13"):getChildByName("Panel_name_13")
	self._Text_occupy_name_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Sprite_name_13"):getChildByName("Panel_name_13"):getChildByName("Text_occupy_name_13")
	self._Panel_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14")
	self._Sprite_donghua_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Sprite_donghua_14")
	self._Text_name_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Sprite_name_bg_14"):getChildByName("Text_name_14")
	self._Sprite_name_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Sprite_name_14")
	self._Panel_name_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Sprite_name_14"):getChildByName("Panel_name_14")
	self._Text_occupy_name_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Sprite_name_14"):getChildByName("Panel_name_14"):getChildByName("Text_occupy_name_14")
	self._Panel_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15")
	self._Sprite_donghua_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Sprite_donghua_15")
	self._Text_name_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Sprite_name_bg_15"):getChildByName("Text_name_15")
	self._Sprite_name_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Sprite_name_15")
	self._Panel_name_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Sprite_name_15"):getChildByName("Panel_name_15")
	self._Text_occupy_name_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Sprite_name_15"):getChildByName("Panel_name_15"):getChildByName("Text_occupy_name_15")
	self._LoadingBar_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_HP"):getChildByName("Panel_lv_1"):getChildByName("LoadingBar_1")
	self._Text_guard_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_HP"):getChildByName("Panel_lv_1"):getChildByName("Text_guard_1")
	self._LoadingBar_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_HP"):getChildByName("Panel_hong_2"):getChildByName("LoadingBar_2")
	self._Text_attack_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_HP"):getChildByName("Panel_hong_2"):getChildByName("Text_attack_2")
	self._BitmapFontLabel_time_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_HP"):getChildByName("Image_HP_frame"):getChildByName("BitmapFontLabel_time")
	self._Panel_fuhuo_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_fuhuo")
	self._Text_daojishi_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_fuhuo"):getChildByName("Text_daojishi_1")
	
    --label list
    
    --button list
    self._Image_city_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_1"):getChildByName("Image_city_1")
	self._Image_city_1_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_1Click), "zoom"))

	self._Image_city_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_2"):getChildByName("Image_city_2")
	self._Image_city_2_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_2Click), "zoom"))

	self._Image_city_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_3"):getChildByName("Image_city_3")
	self._Image_city_3_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_3Click), "zoom"))

	self._Image_city_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_4"):getChildByName("Image_city_4")
	self._Image_city_4_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_4Click), "zoom"))

	self._Image_city_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_5"):getChildByName("Image_city_5")
	self._Image_city_5_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_5Click), "zoom"))

	self._Image_city_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_6"):getChildByName("Image_city_6")
	self._Image_city_6_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_6Click), "zoom"))

	self._Image_city_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_7"):getChildByName("Image_city_7")
	self._Image_city_7_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_7Click), "zoom"))

	self._Image_city_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_8"):getChildByName("Image_city_8")
	self._Image_city_8_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_8Click), "zoom"))

	self._Image_city_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_9"):getChildByName("Image_city_9")
	self._Image_city_9_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_9Click), "zoom"))

	self._Image_city_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_10"):getChildByName("Image_city_10")
	self._Image_city_10_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_10Click), "zoom"))

	self._Image_city_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_11"):getChildByName("Image_city_11")
	self._Image_city_11_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_11Click), "zoom"))

	self._Image_city_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_12"):getChildByName("Image_city_12")
	self._Image_city_12_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_12Click), "zoom"))

	self._Image_city_13_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_13"):getChildByName("Image_city_13")
	self._Image_city_13_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_13Click), "zoom"))

	self._Image_city_14_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_14"):getChildByName("Image_city_14")
	self._Image_city_14_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_14Click), "zoom"))

	self._Image_city_15_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_15"):getChildByName("Image_city_15")
	self._Image_city_15_t:onTouch(Functions.createClickListener(handler(self, self.onImage_city_15Click), "zoom"))

	self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

	self._Button_fuhuo_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Panel_fuhuo"):getChildByName("Button_fuhuo")
	self._Button_fuhuo_t:onTouch(Functions.createClickListener(handler(self, self.onButton_fuhuoClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Image_city_1 btFunc
function GuildBattleMapViewController:onImage_city_1Click()
    Functions.printInfo(self.debug,"Image_city_1 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 1)
end
--@auto code Image_city_1 btFunc end

--@auto code Image_city_2 btFunc
function GuildBattleMapViewController:onImage_city_2Click()
    Functions.printInfo(self.debug,"Image_city_2 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 2)
end
--@auto code Image_city_2 btFunc end

--@auto code Image_city_3 btFunc
function GuildBattleMapViewController:onImage_city_3Click()
    Functions.printInfo(self.debug,"Image_city_3 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 3)
end
--@auto code Image_city_3 btFunc end

--@auto code Image_city_4 btFunc
function GuildBattleMapViewController:onImage_city_4Click()
    Functions.printInfo(self.debug,"Image_city_4 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 4)
end
--@auto code Image_city_4 btFunc end

--@auto code Image_city_5 btFunc
function GuildBattleMapViewController:onImage_city_5Click()
    Functions.printInfo(self.debug,"Image_city_5 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 5)
end
--@auto code Image_city_5 btFunc end

--@auto code Image_city_6 btFunc
function GuildBattleMapViewController:onImage_city_6Click()
    Functions.printInfo(self.debug,"Image_city_6 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 6)
end
--@auto code Image_city_6 btFunc end

--@auto code Image_city_7 btFunc
function GuildBattleMapViewController:onImage_city_7Click()
    Functions.printInfo(self.debug,"Image_city_7 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 7)
end
--@auto code Image_city_7 btFunc end

--@auto code Image_city_8 btFunc
function GuildBattleMapViewController:onImage_city_8Click()
    Functions.printInfo(self.debug,"Image_city_8 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 8)
end
--@auto code Image_city_8 btFunc end

--@auto code Image_city_9 btFunc
function GuildBattleMapViewController:onImage_city_9Click()
    Functions.printInfo(self.debug,"Image_city_9 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 9)
end
--@auto code Image_city_9 btFunc end

--@auto code Image_city_10 btFunc
function GuildBattleMapViewController:onImage_city_10Click()
    Functions.printInfo(self.debug,"Image_city_10 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 10)
end
--@auto code Image_city_10 btFunc end

--@auto code Image_city_11 btFunc
function GuildBattleMapViewController:onImage_city_11Click()
    Functions.printInfo(self.debug,"Image_city_11 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 11)
end
--@auto code Image_city_11 btFunc end

--@auto code Image_city_12 btFunc
function GuildBattleMapViewController:onImage_city_12Click()
    Functions.printInfo(self.debug,"Image_city_12 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 12)
end
--@auto code Image_city_12 btFunc end

--@auto code Image_city_13 btFunc
function GuildBattleMapViewController:onImage_city_13Click()
    Functions.printInfo(self.debug,"Image_city_13 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 13)
end
--@auto code Image_city_13 btFunc end

--@auto code Image_city_14 btFunc
function GuildBattleMapViewController:onImage_city_14Click()
    Functions.printInfo(self.debug,"Image_city_14 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 14)
end
--@auto code Image_city_14 btFunc end

--@auto code Image_city_15 btFunc
function GuildBattleMapViewController:onImage_city_15Click()
    Functions.printInfo(self.debug,"Image_city_15 button is click!")
    GuildBattleData:sendAttackRequest(self.ID, 15)
end
--@auto code Image_city_15 btFunc end

--@auto code Button_back btFunc
function GuildBattleMapViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GuildBattleData:sendLeaveBuilding(self.ID, handler( self, self.LeaveBuilding ))
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_fuhuo btFunc
function GuildBattleMapViewController:onButton_fuhuoClick()
    Functions.printInfo(self.debug,"Button_fuhuo button is click!")
    GuildBattleData:sendFuHuoInfo(self.ID, handler(self, self.showKuang))
end
--@auto code Button_fuhuo btFunc end

--@auto button backcall end


--@auto code view display func
function GuildBattleMapViewController:onCreate()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController controller create!")
end

function GuildBattleMapViewController:onDisplayView(data)
    self.ID = GuildBattleData:getBidInfo().id
	Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    Functions.loadImageWithWidget(self._Image_guild_map_t,"res/map/battle_map.png")
    self.switch = true
    self.titleInit_X = self._Text_occupy_name_1_t:getPositionX()
    
    if PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild then
        self._LoadingBar_1_t:loadTexture("lk/ui_res/GuildBattleMapUI/hp.png", ccui.TextureResType.plistType)
        self._LoadingBar_2_t:loadTexture("lk/ui_res/GuildBattleMapUI/hp_red.png", ccui.TextureResType.plistType)
    end
    if PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild then
        self._LoadingBar_1_t:loadTexture("lk/ui_res/GuildBattleMapUI/hp_red.png", ccui.TextureResType.plistType)
        self._LoadingBar_2_t:loadTexture("lk/ui_res/GuildBattleMapUI/hp.png", ccui.TextureResType.plistType)
    end
    
    self.ActionList = {}
    self:showInfo()
    
    self:showCountdown()
    
    --复活倒计时
    local onCountdown = function(event)
        self:showCountdown()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.COUNTDOWN, onCountdown)
    
    --小城改变信息
    local onBuilding = function(event)
        self:showInfo()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.BUILDING_INFO, onBuilding)
    
    --小城改变信息
    local onResource = function(event)
        self:showBar()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.RESOURCE_INFO, onResource)
    
    --公会战结果
    local onBattleResult = function(event)
        self:openChildView("app.ui.popViews.GuildResultPopView")
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.BID_BATTLE_RESULT, onBattleResult)
    
--    local sTime = TimerManager:formatOverTime("%02d", math.floor(GuildBattleData.eventAttr.DownTime))
--    self._Text_daojishi_1_t:setString(sTime)
--    Functions.bindUiWithModelAttr(self._Text_daojishi_1_t, GuildBattleData, "DownTime",function(event)
--        if math.floor(event.data) == 0 then
--            self._Panel_fuhuo_t:setVisible(false)
--        else
--            self._Panel_fuhuo_t:setVisible(true)
--        end
--        local sTime = TimerManager:formatOverTime("%02d", math.floor(event.data))
--        self._Text_daojishi_1_t:setString(sTime)
--    end)
end
--@auto code view display func end

function GuildBattleMapViewController:LeaveBuilding()
    
end

function GuildBattleMapViewController:sendFuhuo()
    GuildBattleData:sendFuHuo(self.ID, handler(self, self.showCountdown))
end

function GuildBattleMapViewController:showKuang()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")

    --弹出框
    local str = string.format(LanguageConfig.language_GuildBattle_8, GuildBattleData:getfuHuoInfo().count, GuildBattleData:getfuHuoInfo().gold )
    NoticeManager:openTips(self, { handler = handler(self,self.sendFuhuo), title = str})
end

function GuildBattleMapViewController:showInfo()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    local data = GuildBattleData:getGuildBuildingInfo()
    self:showTime()

    self:showBar()
    
    for k, v in pairs(data) do
        if self.switch then
            self.ActionList[#self.ActionList + 1] = 0
        end
        
        self:showBuilding( k, v.cast)
        if #data == k then
            self.switch = false
        end
    end
end

function GuildBattleMapViewController:showBar()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    local data = GuildBattleData:getGuildBuildingInfo()
    local attNum = GuildBattleData:getAttdata()
    local defNum = GuildBattleData:getDefdata()
    local Bar_1 = math.floor((defNum.plusCrystal / GuildBattleData:getMaxcrystal()) * 100)
    local Bar_2 = math.floor((attNum.plusCrystal / GuildBattleData:getMaxcrystal()) * 100)
    self._LoadingBar_1_t:setPercent(Bar_1)
    self._LoadingBar_2_t:setPercent(Bar_2)
    Functions.initLabelOfString( self._Text_guard_1_t, defNum.plusCrystal, self._Text_attack_2_t, attNum.plusCrystal)
end

function GuildBattleMapViewController:showTime()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    --公会争夺倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = GuildBattleData:getEndFightTime()
        m_newtime = CountdownTime - m_newtime 
        if m_newtime < 0 then
            m_newtime = 0
        end

        local time = TimerManager:formatOverTime("%02d:%02d", m_newtime)
        --local str = LanguageConfig.language_Shop_3..time
        Functions.initLabelOfString( self._BitmapFontLabel_time_t, time)
    end
    Functions.bindEventListener(self._BitmapFontLabel_time_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime)
    onTime()
end

function GuildBattleMapViewController:showCountdown()
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    
    local time1 = TimerManager:getCurrentSecond()
    local Countdown = GuildBattleData:getCountdownTime()
    if Countdown == nil then
        Countdown = 0
    end
    local time = Countdown - time1
    if time > 0 then
        self._Panel_fuhuo_t:setVisible(true)
    else
        self._Panel_fuhuo_t:setVisible(false)
        return
    end
    
    --复活倒记时
    local onTime = function(event)
        local m_newtime = TimerManager:getCurrentSecond()
        local CountdownTime = GuildBattleData:getCountdownTime()
        m_newtime = CountdownTime - m_newtime
        if m_newtime < 0 then
            m_newtime = 0
            self._Panel_fuhuo_t:setVisible(false)
        end

        local time = TimerManager:formatOverTime("%02d", math.floor(m_newtime))
        local str = time..LanguageConfig.language_2_5
        Functions.initLabelOfString( self._Text_daojishi_1_t, str )
    end
    Functions.bindEventListener( self._Text_daojishi_1_t, GameEventCenter, TimerManager.SECOND_CHANGE_EVENT, onTime )
    onTime()
end

function GuildBattleMapViewController:showBuilding( id, cast)
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter display!")
    
    local data = GuildBattleData:getGuildBuildingInfo()
    local Image = string.format("_Image_city_%d_t", id)
    local widget = self[Image]
    local Panel = string.format("_Panel_%d_t", id)
    local Sprite = string.format("Sprite_state_%d", id)
    local bar = string.format("Sprite_bar_bg_%d", id)
    --盾牌
    local PanelSprite = self[Panel]:getChildByName(Sprite)
    --bar底框
    local PanelBar = self[Panel]:getChildByName(bar)
    --bar进度条
    local LoadingBar = string.format("LoadingBar_%d", id)
    PanelBar:getChildByName(LoadingBar):setPercent(data[id].progress)
    local name = string.format("_Text_occupy_name_%d_t", id)
    
    --据点名字
    local Text_name = string.format("_Text_name_%d_t", id)
    self[Text_name]:setString(data[id].smallname)
    
    
    if self[name]:getString() ~= data[id].playerData.name then
--        local str = false
--        if string.len(self[name]:getString()) > 10 then
--            str = true
--        end

        self[name]:setString(data[id].playerData.name)

        local Panel_name = string.format("_Panel_name_%d_t", id)
        local PanelSize = self[Panel_name]:getContentSize()
        local PanelWidth = PanelSize.width

        local nameSize = self[name]:getContentSize()
        local nameWidth = nameSize.width

        local sizeX = self[name]:getPositionX()
        local sizeY = self[name]:getPositionY()

        local callfunSize = function ()
            self[name]:setPosition(self.titleInit_X, sizeY)
        end

        if string.len(data[id].playerData.name) > 10 then
            local moveBy = cc.MoveBy:create(5,cc.p(-(PanelWidth + nameWidth), 0))
            --if self.ActionList[id] == 0 then

            self.ActionList[id] = moveBy
            self[name]:setPosition(self.titleInit_X, sizeY)
            self[name]:stopAllActions()

            Functions.playSequenceAction(self[name], {{actionName = moveBy, repeatNum = 1}}, 0, 0, false, callfunSize)

            --        else
            --            self[name]:setPosition(self.titleInit_X, sizeY)
            --            self[name]:stopAllActions()
            --            --self[name]:runAction(self.ActionList[id])
            --            
            --            Functions.playSequenceAction(self[name], {{actionName = moveBy, repeatNum = 1}}, 0, 0, false, callfunSize)
            --        end
        else
            if self.ActionList[id] ~= 0 then
                self[name]:stopAllActions()
                self.ActionList[id] = 0
            end
            local ooooo = self.titleInit_X
            self[name]:setPosition(self.titleInit_X-PanelSize.width*0.5 - nameWidth*0.5, sizeY)
        end
    end
    
    local Sprite_name_bg = string.format("_Sprite_name_%d_t", id)
    
    if (PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) or
        (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2) or
        (GuildBattleData:getDefdata().guild == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
        or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2))) then
        Functions.loadImageWithSprite(PanelSprite, "lk/ui_res/GuildBattleMapUI/dun_green.png")
        Functions.loadImageWithSprite(self[Sprite_name_bg], "lk/ui_res/GuildBattleMapUI/gonghui_bg2.png")
        
        PanelBar:getChildByName(LoadingBar):loadTexture("lk/ui_res/GuildBattleMapUI/green.png", ccui.TextureResType.plistType)
        PanelSprite:setVisible(true)
        PanelBar:setVisible(true)
    else
        Functions.loadImageWithSprite(PanelSprite, "lk/ui_res/GuildBattleMapUI/dun_red.png")
        Functions.loadImageWithSprite(self[Sprite_name_bg], "lk/ui_res/GuildBattleMapUI/gonghui_bg1.png")
        PanelBar:getChildByName(LoadingBar):loadTexture("lk/ui_res/GuildBattleMapUI/red.png", ccui.TextureResType.plistType)
        PanelSprite:setVisible(true)
        PanelBar:setVisible(true)
    end
    
    local donghua = string.format("_Sprite_donghua_%d_t", id)
    local callBack = function()
        --target:removeFromParent()
    end
    if data[id].state == 1 then
        self[donghua]:setVisible(true)
        self[donghua]:stopAllActions()
        Functions.playSequenceAction(self[donghua], { { actionName = "combatAni",repeatNum = 1} }, 0, 0, false, callBack )
    else
        self[donghua]:stopAllActions()
        self[donghua]:setVisible(false)
    end
    
    self:showBuildingHP( id, cast, widget )
end

function GuildBattleMapViewController:showBuildingHP( id, cast, widget )
    Functions.printInfo(self.debug_b," GuildBattleMapViewController view enter showBuildingHP!")
    if id == 1 or id == 9 or id == 15 then
        if cast == 0 and GuildBattleData:getGuildBuildingInfo().id == 0 then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/1_red.png")
        elseif ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild) and (cast == 1)) 
            or ((PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild) and (cast == 2)) or
            (GuildBattleData:getGuildBuildingInfo()[id].id == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
            or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2))) then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/1_green.png")
        else
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/1_red.png")
        end
        return
    end
    if id == 2 or id == 10 or id == 14 then
        if cast == 0 and GuildBattleData:getGuildBuildingInfo().id == 0 then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_red.png")
        elseif (PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) or 
            (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2) or 
            (GuildBattleData:getGuildBuildingInfo()[id].id == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
            or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2)))  then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_green.png")
        else
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_red.png")
        end
        return
    end
    if id == 3 or id == 5 or id == 13 then
        if cast == 0 and GuildBattleData:getGuildBuildingInfo().id == 0 then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_red.png")
        elseif (PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) or 
            (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2) or 
            (GuildBattleData:getGuildBuildingInfo()[id].id == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
            or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2))) then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_green.png")
        else
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/5_red.png")
        end
        return
    end
    if id == 4 or id == 8 or id == 11 then
        if cast == 0 and GuildBattleData:getGuildBuildingInfo().id == 0 then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/3_red.png")
        elseif (PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) or 
            (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2) or 
            (GuildBattleData:getGuildBuildingInfo()[id].id == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
            or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2))) then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/3_green.png")
        else
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/3_red.png")
        end
        return
    end
    if id == 6 or id == 7 or id == 12 then
        if cast == 0 and GuildBattleData:getGuildBuildingInfo().id == 0 then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/3_red.png")
        elseif (PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) or 
            (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2) or 
            (GuildBattleData:getGuildBuildingInfo()[id].id == 0 and ((PlayerData.eventAttr.m_tongID == GuildBattleData:getAttdata().guild and cast == 1) 
            or (PlayerData.eventAttr.m_tongID == GuildBattleData:getDefdata().guild and cast == 2))) then
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/2_green.png")
        else
            Functions.loadImageWithWidget( widget,"lk/ui_res/GuildBattleMapUI/2_red.png")
        end
        return
    end
end

return GuildBattleMapViewController