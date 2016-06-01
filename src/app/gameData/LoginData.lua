local LoginData = {}


--事件
LoginData.LOGIN_ADD_SERVER_EVENT = "LOGIN_ADD_SERVER_EVENT"



function LoginData:init()
	self._serverList = {}
end

function LoginData:addServerItem(data)
	self._serverList[#self._serverList + 1] = data
	GameEventCenter:dispatchEvent({ name = LoginData.LOGIN_ADD_SERVER_EVENT, data = data })
end




return LoginData