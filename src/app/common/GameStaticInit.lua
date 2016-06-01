 

if CC_SHOW_FPS then
    cc.Director:getInstance():setDisplayStats(true)
end

--初始化游戏全局枚举变量
GloableEnum = require("app.configs.GloableEnum")

--初始化游戏全局状态数据
GameState = require("app.gameData.GameState")
GameState:init()

--加载语言配置表
if G_CurrentLanguage == "ch" then
	LanguageConfig = require("app.configs.languageConfig_ch")
elseif G_CurrentLanguage == "hr" then
	LanguageConfig = require("app.configs.languageConfig_hr")
end

--全局事件中心初始化
GameEventCenter = require("app.common.GlobalEventCenter")
GameEventCenter:init()

--全局功能函数初始化
Functions = require("app.common.Functions")

--初始化全局服务器配置
ServerConfig = require("app.configs.ServerConfig")
ServerConfig:init()

--全局控制器初始化  
GameCtlManager= require("app.baseMVC.ViewControllerManager")

--全局动作工具初始化
UIActionTool = require("app.common.UIActionTool")

--全局工厂
Factory = require("app.common.Factory")

--全局网络模块初始化
if NetWork then
	NetWork:destory()
end

NetWork = require("app.common.NetWork")
NetWork:init()

--加载sdk配置
SDKConfig = require("app.sdk.SDKConfig")
SDKConfig:init()

--全局网络模块初始化
if HttpClient then
	HttpClient:destory()
end
HttpClient = require("app.common.HttpClient")
HttpClient:init()

--初始化时间管理器
if TimerManager then
	TimerManager:destory()
end
TimerManager = require("app.common.TimerManager")
TimerManager:init()

--初始化全局提示管理器
PromptManager = require("app.ui.common.PromptManager")
PromptManager:init()

--初始化声音组件
Audio = require("app.common.Audio")
Audio:init()

--
NativeUtil = {}
if G_SDKType == 2 then 
	NativeUtil = require("app.common.Tstore_NativeUtil")
elseif G_SDKType == 3 then 
	NativeUtil = require("app.common.Cstore_NativeUtil")
elseif G_SDKType == 4 then 
	NativeUtil = require("app.common.Gplay_NativeUtil")
elseif G_SDKType == 5 then 
	NativeUtil = require("app.common.Astore_NativeUtil")
else
	NativeUtil = require("app.common.NativeUtil")
end
NativeUtil:init()

--加载模块开管理器
ModelManager = require("app.common.ModelManager")
ModelManager:init()

Player = require("app.gameData.Player")
Player:init()

-- ]]
