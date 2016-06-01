--@auto code head
local BaseViewController = require("app.baseMVC.BaseViewController")
local GuildBattleViewController = class("GuildBattleViewController", BaseViewController)

local Functions = require("app.common.Functions")

GuildBattleViewController.debug = true
GuildBattleViewController.modulePath = ...
GuildBattleViewController.studioSpriteFrames = {"GvgUI_Text","GuildBattleUI" }
--@auto code head end

--@Pre loading
GuildBattleViewController.spriteFrameNames = 
    {
    }

GuildBattleViewController.animaNames = 
    {
    }


--@auto code uiInit
--add spriteFrames
if #GuildBattleViewController.studioSpriteFrames > 0 then
    GuildBattleViewController.spriteFrameNames = GuildBattleViewController.spriteFrameNames or {}
    table.insertto(GuildBattleViewController.spriteFrameNames, GuildBattleViewController.studioSpriteFrames)
end
function GuildBattleViewController:onDidLoadView()

    --output list
    self._Image_guild_map_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map")
	self._Sprite_kuang_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_kuang_1")
	self._Text_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_kuang_1"):getChildByName("Text_name_1")
	self._Sprite_fanbei_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_fanbei_1")
	self._Sprite_guild_bg_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_guild_bg_1")
	self._Panel_guild_name_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_guild_bg_1"):getChildByName("Panel_guild_name_1")
	self._Text_title_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_guild_bg_1"):getChildByName("Panel_guild_name_1"):getChildByName("Text_title_1")
	self._Sprite_prize_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Panel_prize_1"):getChildByName("Sprite_prize_1")
	self._Sprite_state_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Sprite_state_1")
	self._Sprite_kuang_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_kuang_2")
	self._Text_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_kuang_2"):getChildByName("Text_name_2")
	self._Sprite_fanbei_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_fanbei_2")
	self._Sprite_prize_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Panel_prize_2"):getChildByName("Sprite_prize_2")
	self._Sprite_guild_bg_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_guild_bg_2")
	self._Panel_guild_name_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_guild_bg_2"):getChildByName("Panel_guild_name_2")
	self._Text_title_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_guild_bg_2"):getChildByName("Panel_guild_name_2"):getChildByName("Text_title_2")
	self._Sprite_state_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Sprite_state_2")
	self._Sprite_kuang_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_kuang_3")
	self._Text_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_kuang_3"):getChildByName("Text_name_3")
	self._Sprite_fanbei_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_fanbei_3")
	self._Sprite_prize_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Panel_prize_3"):getChildByName("Sprite_prize_3")
	self._Sprite_guild_bg_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_guild_bg_3")
	self._Panel_guild_name_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_guild_bg_3"):getChildByName("Panel_guild_name_3")
	self._Text_title_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_guild_bg_3"):getChildByName("Panel_guild_name_3"):getChildByName("Text_title_3")
	self._Sprite_state_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Sprite_state_3")
	self._Sprite_kuang_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_kuang_4")
	self._Text_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_kuang_4"):getChildByName("Text_name_4")
	self._Sprite_fanbei_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_fanbei_4")
	self._Sprite_prize_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Panel_prize_4"):getChildByName("Sprite_prize_4")
	self._Sprite_guild_bg_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_guild_bg_4")
	self._Panel_guild_name_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_guild_bg_4"):getChildByName("Panel_guild_name_4")
	self._Text_title_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_guild_bg_4"):getChildByName("Panel_guild_name_4"):getChildByName("Text_title_4")
	self._Sprite_state_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Sprite_state_4")
	self._Sprite_kuang_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_kuang_5")
	self._Text_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_kuang_5"):getChildByName("Text_name_5")
	self._Sprite_fanbei_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_fanbei_5")
	self._Sprite_prize_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Panel_prize_5"):getChildByName("Sprite_prize_5")
	self._Sprite_guild_bg_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_guild_bg_5")
	self._Panel_guild_name_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_guild_bg_5"):getChildByName("Panel_guild_name_5")
	self._Text_title_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_guild_bg_5"):getChildByName("Panel_guild_name_5"):getChildByName("Text_title_5")
	self._Sprite_state_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Sprite_state_5")
	self._Sprite_kuang_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_kuang_6")
	self._Text_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_kuang_6"):getChildByName("Text_name_6")
	self._Sprite_fanbei_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_fanbei_6")
	self._Sprite_prize_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Panel_prize_6"):getChildByName("Sprite_prize_6")
	self._Sprite_guild_bg_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_guild_bg_6")
	self._Panel_guild_name_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_guild_bg_6"):getChildByName("Panel_guild_name_6")
	self._Text_title_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_guild_bg_6"):getChildByName("Panel_guild_name_6"):getChildByName("Text_title_6")
	self._Sprite_state_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Sprite_state_6")
	self._Sprite_kuang_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_kuang_7")
	self._Text_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_kuang_7"):getChildByName("Text_name_7")
	self._Sprite_fanbei_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_fanbei_7")
	self._Sprite_prize_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Panel_prize_7"):getChildByName("Sprite_prize_7")
	self._Sprite_guild_bg_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_guild_bg_7")
	self._Panel_guild_name_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_guild_bg_7"):getChildByName("Panel_guild_name_7")
	self._Text_title_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_guild_bg_7"):getChildByName("Panel_guild_name_7"):getChildByName("Text_title_7")
	self._Sprite_state_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Sprite_state_7")
	self._Sprite_kuang_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_kuang_8")
	self._Text_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_kuang_8"):getChildByName("Text_name_8")
	self._Sprite_fanbei_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_fanbei_8")
	self._Sprite_prize_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Panel_prize_8"):getChildByName("Sprite_prize_8")
	self._Sprite_guild_bg_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_guild_bg_8")
	self._Panel_guild_name_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_guild_bg_8"):getChildByName("Panel_guild_name_8")
	self._Text_title_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_guild_bg_8"):getChildByName("Panel_guild_name_8"):getChildByName("Text_title_8")
	self._Sprite_state_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Sprite_state_8")
	self._Sprite_kuang_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_kuang_9")
	self._Text_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_kuang_9"):getChildByName("Text_name_9")
	self._Sprite_fanbei_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_fanbei_9")
	self._Sprite_prize_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Panel_prize_9"):getChildByName("Sprite_prize_9")
	self._Sprite_guild_bg_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_guild_bg_9")
	self._Panel_guild_name_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_guild_bg_9"):getChildByName("Panel_guild_name_9")
	self._Text_title_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_guild_bg_9"):getChildByName("Panel_guild_name_9"):getChildByName("Text_title_9")
	self._Sprite_state_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Sprite_state_9")
	self._Sprite_kuang_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_kuang_10")
	self._Text_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_kuang_10"):getChildByName("Text_name_10")
	self._Sprite_fanbei_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_fanbei_10")
	self._Sprite_prize_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Panel_prize_10"):getChildByName("Sprite_prize_10")
	self._Sprite_guild_bg_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_guild_bg_10")
	self._Panel_guild_name_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_guild_bg_10"):getChildByName("Panel_guild_name_10")
	self._Text_title_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_guild_bg_10"):getChildByName("Panel_guild_name_10"):getChildByName("Text_title_10")
	self._Sprite_state_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Sprite_state_10")
	self._Sprite_kuang_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_kuang_11")
	self._Text_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_kuang_11"):getChildByName("Text_name_11")
	self._Sprite_fanbei_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_fanbei_11")
	self._Sprite_prize_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Panel_prize_11"):getChildByName("Sprite_prize_11")
	self._Sprite_guild_bg_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_guild_bg_11")
	self._Panel_guild_name_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_guild_bg_11"):getChildByName("Panel_guild_name_11")
	self._Text_title_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_guild_bg_11"):getChildByName("Panel_guild_name_11"):getChildByName("Text_title_11")
	self._Sprite_state_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Sprite_state_11")
	self._Sprite_kuang_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_kuang_12")
	self._Text_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_kuang_12"):getChildByName("Text_name_12")
	self._Sprite_fanbei_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_fanbei_12")
	self._Sprite_prize_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Panel_prize_12"):getChildByName("Sprite_prize_12")
	self._Sprite_guild_bg_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_guild_bg_12")
	self._Panel_guild_name_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_guild_bg_12"):getChildByName("Panel_guild_name_12")
	self._Text_title_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_guild_bg_12"):getChildByName("Panel_guild_name_12"):getChildByName("Text_title_12")
	self._Sprite_state_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Sprite_state_12")
	
    --label list
    
    --button list
    self._Button_city_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Button_city_1")
	self._Button_city_1_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_1Click), "zoom"))

	self._Panel_prize_1_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_tianshui"):getChildByName("Panel_prize_1")
	self._Panel_prize_1_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_1Click), "zoom"))

	self._Button_city_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Button_city_2")
	self._Button_city_2_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_2Click), "zoom"))

	self._Panel_prize_2_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_chendu"):getChildByName("Panel_prize_2")
	self._Panel_prize_2_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_2Click), "zoom"))

	self._Button_city_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Button_city_3")
	self._Button_city_3_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_3Click), "zoom"))

	self._Panel_prize_3_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_hanzhong"):getChildByName("Panel_prize_3")
	self._Panel_prize_3_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_3Click), "zoom"))

	self._Button_city_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Button_city_4")
	self._Button_city_4_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_4Click), "zoom"))

	self._Panel_prize_4_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianning"):getChildByName("Panel_prize_4")
	self._Panel_prize_4_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_4Click), "zoom"))

	self._Button_city_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Button_city_5")
	self._Button_city_5_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_5Click), "zoom"))

	self._Panel_prize_5_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_yongan"):getChildByName("Panel_prize_5")
	self._Panel_prize_5_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_5Click), "zoom"))

	self._Button_city_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Button_city_6")
	self._Button_city_6_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_6Click), "zoom"))

	self._Panel_prize_6_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_changan"):getChildByName("Panel_prize_6")
	self._Panel_prize_6_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_6Click), "zoom"))

	self._Button_city_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Button_city_7")
	self._Button_city_7_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_7Click), "zoom"))

	self._Panel_prize_7_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_nanpi"):getChildByName("Panel_prize_7")
	self._Panel_prize_7_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_7Click), "zoom"))

	self._Button_city_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Button_city_8")
	self._Button_city_8_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_8Click), "zoom"))

	self._Button_prize_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Button_prize_8")
	self._Button_prize_8_t:onTouch(Functions.createClickListener(handler(self, self.onButton_prize_8Click), "zoom"))

	self._Panel_prize_8_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jiangxia"):getChildByName("Panel_prize_8")
	self._Panel_prize_8_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_8Click), "zoom"))

	self._Button_city_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Button_city_9")
	self._Button_city_9_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_9Click), "zoom"))

	self._Button_prize_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Button_prize_9")
	self._Button_prize_9_t:onTouch(Functions.createClickListener(handler(self, self.onButton_prize_9Click), "zoom"))

	self._Panel_prize_9_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xuchang"):getChildByName("Panel_prize_9")
	self._Panel_prize_9_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_9Click), "zoom"))

	self._Button_city_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Button_city_10")
	self._Button_city_10_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_10Click), "zoom"))

	self._Panel_prize_10_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianan"):getChildByName("Panel_prize_10")
	self._Panel_prize_10_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_10Click), "zoom"))

	self._Button_city_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Button_city_11")
	self._Button_city_11_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_11Click), "zoom"))

	self._Panel_prize_11_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_jianye"):getChildByName("Panel_prize_11")
	self._Panel_prize_11_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_11Click), "zoom"))

	self._Button_city_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Button_city_12")
	self._Button_city_12_t:onTouch(Functions.createClickListener(handler(self, self.onButton_city_12Click), "zoom"))

	self._Panel_prize_12_t = self.view_t.csbNode:getChildByName("main"):getChildByName("ScrollView_guild"):getChildByName("Image_guild_map"):getChildByName("Panel_xiapi"):getChildByName("Panel_prize_12")
	self._Panel_prize_12_t:onTouch(Functions.createClickListener(handler(self, self.onPanel_prize_12Click), "zoom"))

	self._Button_back_t = self.view_t.csbNode:getChildByName("main"):getChildByName("Button_back")
	self._Button_back_t:onTouch(Functions.createClickListener(handler(self, self.onButton_backClick), "zoom"))

end
--@auto code uiInit end


--@auto button backcall begin

--@auto code Button_back btFunc
function GuildBattleViewController:onButton_backClick()
    Functions.printInfo(self.debug,"Button_back button is click!")
    GuildBattleData:sendLeave()
    GameCtlManager:pop(self)
end
--@auto code Button_back btFunc end

--@auto code Button_city_1 btFunc
function GuildBattleViewController:onButton_city_1Click()
    Functions.printInfo(self.debug,"Button_city_1 button is click!")
    local id = 1
    self:send( 1 )
end
--@auto code Button_city_1 btFunc end

--@auto code Button_city_2 btFunc
function GuildBattleViewController:onButton_city_2Click()
    Functions.printInfo(self.debug,"Button_city_2 button is click!")
    local id = 2
    self:send( 2 )
end
--@auto code Button_city_2 btFunc end

--@auto code Button_city_3 btFunc
function GuildBattleViewController:onButton_city_3Click()
    Functions.printInfo(self.debug,"Button_city_3 button is click!")
    local id = 3
    self:send( 3 )
end
--@auto code Button_city_3 btFunc end

--@auto code Button_city_4 btFunc
function GuildBattleViewController:onButton_city_4Click()
    Functions.printInfo(self.debug,"Button_city_4 button is click!")
    local id = 4
    self:send( 4 )
end
--@auto code Button_city_4 btFunc end

--@auto code Button_city_5 btFunc
function GuildBattleViewController:onButton_city_5Click()
    Functions.printInfo(self.debug,"Button_city_5 button is click!")
    local id = 5
    self:send( 5 )
end
--@auto code Button_city_5 btFunc end

--@auto code Button_city_6 btFunc
function GuildBattleViewController:onButton_city_6Click()
    Functions.printInfo(self.debug,"Button_city_6 button is click!")
    local id = 6
    self:send( 6 )
end
--@auto code Button_city_6 btFunc end

--@auto code Button_city_7 btFunc
function GuildBattleViewController:onButton_city_7Click()
    Functions.printInfo(self.debug,"Button_city_7 button is click!")
    local id = 7
    self:send( 7 )
end
--@auto code Button_city_7 btFunc end

--@auto code Button_city_8 btFunc
function GuildBattleViewController:onButton_city_8Click()
    Functions.printInfo(self.debug,"Button_city_8 button is click!")
    local id = 8
    self:send( 8 )
end
--@auto code Button_city_8 btFunc end

--@auto code Button_city_9 btFunc
function GuildBattleViewController:onButton_city_9Click()
    Functions.printInfo(self.debug,"Button_city_9 button is click!")
    local id = 9
    self:send( 9 )
end
--@auto code Button_city_9 btFunc end

--@auto code Button_city_10 btFunc
function GuildBattleViewController:onButton_city_10Click()
    Functions.printInfo(self.debug,"Button_city_10 button is click!")
    local id = 10
    self:send( 10 )
end
--@auto code Button_city_10 btFunc end

--@auto code Button_city_11 btFunc
function GuildBattleViewController:onButton_city_11Click()
    Functions.printInfo(self.debug,"Button_city_11 button is click!")
    local id = 11
    self:send( 11 )
end
--@auto code Button_city_11 btFunc end

--@auto code Button_city_12 btFunc
function GuildBattleViewController:onButton_city_12Click()
    Functions.printInfo(self.debug,"Button_city_12 button is click!")
    local id = 12
    self:send( 12 )
end
--@auto code Button_city_12 btFunc end

--@auto code Panel_prize_1 btFunc
function GuildBattleViewController:onPanel_prize_1Click()
    Functions.printInfo(self.debug,"Panel_prize_1 button is click!")
    local cityId = 1
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_1 btFunc end

--@auto code Panel_prize_2 btFunc
function GuildBattleViewController:onPanel_prize_2Click()
    Functions.printInfo(self.debug,"Panel_prize_2 button is click!")
    local cityId = 2
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_2 btFunc end

--@auto code Panel_prize_3 btFunc
function GuildBattleViewController:onPanel_prize_3Click()
    Functions.printInfo(self.debug,"Panel_prize_3 button is click!")
    local cityId = 3
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_3 btFunc end

--@auto code Panel_prize_4 btFunc
function GuildBattleViewController:onPanel_prize_4Click()
    Functions.printInfo(self.debug,"Panel_prize_4 button is click!")
    local cityId = 4
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_4 btFunc end

--@auto code Panel_prize_5 btFunc
function GuildBattleViewController:onPanel_prize_5Click()
    Functions.printInfo(self.debug,"Panel_prize_5 button is click!")
    local cityId = 5
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_5 btFunc end

--@auto code Panel_prize_6 btFunc
function GuildBattleViewController:onPanel_prize_6Click()
    Functions.printInfo(self.debug,"Panel_prize_6 button is click!")
    local cityId = 6
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_6 btFunc end

--@auto code Panel_prize_7 btFunc
function GuildBattleViewController:onPanel_prize_7Click()
    Functions.printInfo(self.debug,"Panel_prize_7 button is click!")
    local cityId = 7
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_7 btFunc end

--@auto code Panel_prize_8 btFunc
function GuildBattleViewController:onPanel_prize_8Click()
    Functions.printInfo(self.debug,"Panel_prize_8 button is click!")
    local cityId = 8
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_8 btFunc end

--@auto code Panel_prize_9 btFunc
function GuildBattleViewController:onPanel_prize_9Click()
    Functions.printInfo(self.debug,"Panel_prize_9 button is click!")
    local cityId = 9
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_9 btFunc end

--@auto code Panel_prize_10 btFunc
function GuildBattleViewController:onPanel_prize_10Click()
    Functions.printInfo(self.debug,"Panel_prize_10 button is click!")
    local cityId = 10
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_10 btFunc end

--@auto code Panel_prize_11 btFunc
function GuildBattleViewController:onPanel_prize_11Click()
    Functions.printInfo(self.debug,"Panel_prize_11 button is click!")
    local cityId = 11
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_11 btFunc end

--@auto code Panel_prize_12 btFunc
function GuildBattleViewController:onPanel_prize_12Click()
    Functions.printInfo(self.debug,"Panel_prize_12 button is click!")
    local cityId = 12
    self:openChildView("app.ui.popViews.GvgPrizePopView", {data = {id = cityId}})
end
--@auto code Panel_prize_12 btFunc end

--@auto code Button_prize_8 btFunc
function GuildBattleViewController:onButton_prize_8Click()
    Functions.printInfo(self.debug,"Button_prize_8 button is click!")
end
--@auto code Button_prize_8 btFunc end

--@auto code Button_prize_9 btFunc
function GuildBattleViewController:onButton_prize_9Click()
    Functions.printInfo(self.debug,"Button_prize_9 button is click!")
end
--@auto code Button_prize_9 btFunc end

--@auto button backcall end


--@auto code view display func
function GuildBattleViewController:onCreate()
    Functions.printInfo(self.debug_b," GuildBattleViewController controller create!")
end

function GuildBattleViewController:onDisplayView()
	Functions.printInfo(self.debug_b," GuildBattleViewController view enter display!")
    Functions.loadImageWithWidget(self._Image_guild_map_t,"res/map/guildCity.png")
    self.titleInit_X = self._Text_title_1_t:getPositionX()
    GuildBattleData:sendBuildingInfo(handler(self, self.callbackC))

    --接收领取占领奖励广播
    local onPrizeInfo = function(event)
        self:show()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.OCCUPY_PRIZE, onPrizeInfo)
    
    --接收大城状态
    local onStateInfo = function(event)
        self:show()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.BATTLE_STATE, onStateInfo)
    
    --竟价排行界面
    local onRankInfo = function(event)
        self:bidRankShow()
    end
    Functions.bindEventListener(self.view_t, GameEventCenter, GuildBattleData.BID_RANK_INFO, onRankInfo)
end
--@auto code view display func end

function GuildBattleViewController:send(id)
    local data = GuildBattleData:getBuildingInfo()
    if data[id].isOpen then

        GuildBattleData:sendIntoBuilding(id)
        --GuildBattleData:sendBidRank( id, handler(self, self.bidRankShow ))
    else
        --弹出报错信息
        PromptManager:openTipPrompt(ConfigHandler:getServerErrorCode(1100))
    end
end

function GuildBattleViewController:show()
    Functions.printInfo(self.debug_b," GuildBattleViewController controller create!")
    local data = GuildBattleData:getBuildingInfo()
    for k, v in pairs(data) do
        local wigt = string.format("_Text_title_%d_t", k)
        local name = string.format("_Text_name_%d_t", k)
        local prize = string.format("_Panel_prize_%d_t", k)
        local SpriteRate = string.format("_Sprite_fanbei_%d_t", k)
        local SpriteBG = string.format("_Sprite_guild_bg_%d_t", k)
        
        local state = string.format("_Sprite_state_%d_t", k)
        self[state]:setVisible(true)
        
        local scaleby = cc.ScaleBy:create(0.5, 1.3)
        local actionbyback = scaleby:reverse()
        local seq = cc.Sequence:create( scaleby,actionbyback)
        local repeatForever = cc.RepeatForever:create(seq)
        
        
        if v.state == 0 then
            self[state]:setVisible(false)
            --Functions.loadImageWithSprite(self[state], "lk/ui_res/GuildBattleUI/dun_green.png")
        elseif v.state == 1 then
            Functions.loadImageWithSprite(self[state], "lk/ui_res/GuildBattleUI/jingjiazhong.png")
            self[state]:runAction(repeatForever)
        elseif v.state == 2 then
            Functions.loadImageWithSprite(self[state], "lk/ui_res/GuildBattleUI/dengdaigongcheng.png")
            self[state]:runAction(repeatForever)
        elseif v.state == 3 then
            Functions.loadImageWithSprite(self[state], "lk/ui_res/GuildBattleUI/gongchengzhanzhong.png")
            self[state]:runAction(repeatForever)
        end
        
        if v.Rate >= 2 then
            --奖励翻倍
            self[SpriteRate]:setVisible(true)
        else
            self[SpriteRate]:setVisible(false)
        end
        if v.rewardState == 1 then
            self[prize]:setVisible(true)
            local Sprite_prize = string.format("_Sprite_prize_%d_t", k)
            
            local jumpby = cc.JumpBy:create(1, cc.p(0, 0), 4, 20)
            local easeSineIn = cc.EaseSineIn:create(jumpby)
            local seq = cc.Sequence:create(easeSineIn, cc.DelayTime:create(2))
            
            local repeatForever = cc.RepeatForever:create(seq)
            self[Sprite_prize]:runAction(repeatForever)
        else
            self[prize]:setVisible(false)
            
        end
        
        if v.isOpen then
        	Functions.initLabelOfString(self[wigt], v.ownName)
        else
            local ButtonCity = string.format("_Button_city_%d_t", k)
            local fanbei = string.format("_Sprite_fanbei_%d_t", k)
            local kuang = string.format("_Sprite_kuang_%d_t", k)
            self[SpriteBG]:setVisible(false)
            Functions.setEnabledBt(self[ButtonCity], false)
            Functions.setGraySprite(self[fanbei], true)
            Functions.setGraySprite(self[kuang], true)
        end
        Functions.initLabelOfString(self[name], g_bigCity[k].name)
        
        local Panel = string.format("_Panel_guild_name_%d_t", k)
        
        local PanelSize = self[Panel]:getContentSize()
        local PanelWidth = PanelSize.width
        
        local nameSize = self[wigt]:getContentSize()
        local nameWidth = nameSize.width
        
        local sizeX = self[wigt]:getPositionX()
        local sizeY = self[wigt]:getPositionY()
        
        local callfunSize = function ()
            self[wigt]:setPosition(self.titleInit_X, sizeY)
        end

        local opppopop = string.len(v.ownName) 
        if string.len(v.ownName) > 15 and v.isOpen then
            local moveBy = cc.MoveBy:create(5,cc.p(-(PanelWidth + nameWidth), 0))
            self[wigt]:stopAllActions()
            Functions.playSequenceAction(self[wigt], {{actionName = moveBy, repeatNum = 1}}, 0, 0, false, callfunSize)
        else
            self[wigt]:setPosition(self.titleInit_X-PanelSize.width*0.5-nameWidth*0.5, sizeY)
        end
    end
end


function GuildBattleViewController:callbackC()
    Functions.printInfo(self.debug_b," callbackC")
    self:showView()
    self:show()
end

function GuildBattleViewController:onChangeView()

end

function GuildBattleViewController:bidRankShow()
    Functions.printInfo(self.debug_b," bidRankShow")
    self:openChildView("app.ui.popViews.GvgBidRankPopView")
end

return GuildBattleViewController