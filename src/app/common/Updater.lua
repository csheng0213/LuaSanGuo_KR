local Updater = {}

Updater.RLS_NONE = 0
Updater.RLS_CHECKVERSION = 1
Updater.RLS_CHECKVERSIONFAILED = 2
Updater.RLS_GETFILELIST = 3
Updater.RLS_GETFILELISTFAILED = 4
Updater.RLS_DOWNLOADFILE = 5
Updater.RLS_DOWNLOADFILEFAILED = 6
Updater.RLS_LOADING = 7
Updater.RLS_COMPLETED = 8
Updater.RLS_UNCOMPRESS = 9
Updater.RLS_UNCOMPRESS_FAILED = 10
Updater.RLS_BIG_UPDATE = 11
Updater.RLS_RESTART_CLIENT = 12
Updater.RLS_MAX = 13

Updater.updateManagerUrl = ServerConfig.currentURL .. "sanguoGMSomeFunc/GetUpdateServStatus"

function Updater.beginUpdate()
    UpdateGame(UpdateServerURL, FileMidVersion or CurrentMidVersion, FileMinVersion or CurrentMinVersion)
end

function Updater.getUpdateState()
    return GetUpdateState()
end

function Updater.getUpdateInfo()
	local fileIndex, fileProgress, totalToDownload, nowDownloaded = GetUpdateCurInfo()
	totalToDownload = math.floor(totalToDownload/(1000*1000)*100)/100
	nowDownloaded   = math.floor(nowDownloaded/(1000*1000)*100)/100
	return { index = fileIndex, progress = math.floor(fileProgress*100), total = totalToDownload, nowDownloaded = nowDownloaded }
end

return Updater

