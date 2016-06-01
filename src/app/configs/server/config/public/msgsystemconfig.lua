--公告消息系统 配置文件

--
g_MsgSysConfig = 
{
	--系统公告最大数量
	SysMsgCount = 20,
	--玩家信息公告最大数量
	PlayMsgCount = 200,
	--一次发送给玩家的公告消息数
	SendMsgCount = 2,
	--再次获取公告信息的CD时间，秒
	GetMsgTime = 5,
	
	--等级达到通知
	LevelNotice = {20,30,40,50,60,70,80,90,99},
	--打过关卡通知
	--PassNotice = {{1,1},{1,3},{1,4},},
	--抽卡通知
	SampleCardNotice = {4, 5},
	--抽卡通知
	SampleBoxNotice = {5},
}
