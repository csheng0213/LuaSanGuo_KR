local ServerConfig = {}

-- 171.212.112.50:8095
ServerConfig.LocalServer = 
{
    PUBLICE_AND = "http://192.168.0.104:8085/sanguoGM/",
    updateUrl = "http://192.168.0.104:8095/sanguoGM/luaupdate/"
--    PUBLICE_AND = "http://171.212.112.178:18085/sanguoGM/",
--    updateUrl = "http://171.212.112.178:18095/sanguoGM/luaupdate/"
}


ServerConfig.LanServer = 
{
    [1] = {
        PUBLICE_AND = "http://120.26.201.186:8085/sanguoGM/" ,
        updateUrl = "http://120.26.201.186:8100/sanguoGM/luaupdate/"
        },
    [2] = {
        PUBLICE_AND = "http://14.63.168.151:8085/sanguoGM/" ,
        updateUrl = "http://szjp-patch-kr.dstamp.net/test1/"
        },
    [3] = {
        PUBLICE_AND = "http://14.63.163.47:8085/sanguoGM/" ,
        updateUrl = "http://szjp-patch-kr.dstamp.net/test2/"
        },
    [4] = {
        PUBLICE_AND = "http://121.42.147.30:8085/sanguoGM/" ,
        updateUrl = "http://121.42.147.30:8100/sanguoGM/luaupdate/"
    },
    [5] = {
        PUBLICE_AND = "http://14.63.170.172:8085/sanguoGM/" ,--CBT
        updateUrl = "http://szjp-patch-kr.dstamp.net/live/"
    },
    [6] = {
        PUBLICE_AND = "http://121.40.110.58:8085/sanguoGM/" ,--CBT
        updateUrl = "http://121.40.110.58:8100/sanguoGM/luaupdate/"
    },
}

--SDK类型
--1 N-store, 2 T-store, 3 C-store, 4 gplay 5 ios-store
ServerConfig.DownLoadUrls = 
{
    [1] = "http://m.nstore.naver.com/appstore/web/detail.nhn?productNo=2075829"
}

ServerConfig.currentURL = nil

function ServerConfig:init()
    if G_IsLinkLoaclIp then
        ServerConfig.currentURL = ServerConfig.LocalServer.PUBLICE_AND
        UpdateServerURL = ServerConfig.LocalServer.updateUrl
    elseif not G_IsAutoGetUrl then
        ServerConfig.currentURL = ServerConfig.LanServer[G_ServerId].PUBLICE_AND
        UpdateServerURL = ServerConfig.LanServer[G_ServerId].updateUrl
        GameState.storeAttr.CurGameDownLoadUrl_s = ServerConfig.DownLoadUrls[G_SDKType]
    elseif G_IsAutoGetUrl then
        if GameState then
            ServerConfig.currentURL = GameState.storeAttr.CurGameLoginUrl_s
            UpdateServerURL = GameState.storeAttr.CurGameUpdateUrl_s
        end
    end
end

function ServerConfig:setURL(loginUrl, updateUrl)
    ServerConfig.currentURL = loginUrl
    UpdateServerURL = updateUrl
end

return ServerConfig