
-- 0 - disable debug info, 1 - less debug info, 2 - verbose debug info
DEBUG = 0

-- use framework, will disable all deprecated API, false - use legacy API
CC_USE_FRAMEWORK = true

-- show FPS on screen
CC_SHOW_FPS = false

-- disable create unexpected global variable
CC_DISABLE_GLOBAL = false

-- for module display
CC_DESIGN_RESOLUTION = {
    width = 1136,
    height = 640,
    autoscale = "FIXED_HEIGHT",
    callback = function(framesize)
        local ratio = framesize.width / framesize.height
        if ratio <= 1.34 then
            -- iPad 768*1024(1536*2048) is 4:3 screen
        return { autoscale = "FIXED_WIDTH" }
        end
    end
}

-- 是否是运营维护apk 
G_IsDebugClient = false 

-- update
-- true 使用更新功能， fales 不使用更新功能,用于当前代码调试
G_IsUpdate = false

--是否使用sdk
G_IsUseSDK = false


--SDK类型：1：NStore,2:TStore 3:CStore 4:gplay 5:ios-store
G_SDKType = 3

-- NetWork 是否连接内网，true: 连接内网，false: 连接外网
G_IsLinkLoaclIp = false


--外网服务器id
G_ServerId = 4

--是否自动获取当前链接的服务器和更新地址
G_IsAutoGetUrl = false
G_AutoPatchUrl = "http://14.63.163.47:8095/sanguoGM/sanguoGMSomeFunc/GetOneItemInfo"
-- G_AutoPatchUrl = "http://171.212.112.50:8095/sanguoGM/sanguoGMSomeFunc/GetOneItemInfo"

--当前设备类型： 1 android, 2 ios 
G_DeviceType = 1

--当前平台： -1 maintenance 0 test 1 N-store, 2 T-store, 3 C-store, 4 gplay 5 ios-store 
G_PlatformType = 1

--当前语言
G_CurrentLanguage = "hr"

--时候开启新手引导
G_IsOpenGuide = false

--是否开启首战
G_IsOpenFirstFight = false

--是否自定义启动画面
G_IsHaveLanchImage = false

--当前版本
CurrentBigVersion = 3
CurrentMidVersion = 3
CurrentMinVersion = 2

--输出内存信息
DEBUG_MEM = false
