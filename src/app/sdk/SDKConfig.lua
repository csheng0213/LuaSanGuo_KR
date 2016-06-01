local SDKConfig = {}
    --是否开启SDK
    isOpenSDK = false
    SDKConfig.forumUrl = "http://m.cafe.naver.com/sjzp/18"   
    SDKConfig.strategyUrl = "http://m.cafe.naver.com/ArticleList.nhn?search.clubid=28313460&search.menuid=3&search.boardtype=L"
    SDKConfig.faqUrl = "https://game.nanoo.so/sjzp/customer/faq"
    SDKConfig.oneToOneUrl = "https://game.nanoo.so/sjzp/customer/inquiry_post"
    SDKConfig.eulaOneUrl = "https://game.nanoo.so/sjzp/customer/faq/1024"
    SDKConfig.eulaTwoUrl = "https://game.nanoo.so/sjzp/customer/faq/1025"
    SDKConfig.popUpKey= {"start","lobby","fighting","ladder","seven_star",
						 "hero_train","blood_fight","recruit","society","hero","upgrade",
						 "embattle","equipment","package","combining","task","store","achievement",
						 "buy_gold","reward","sign_in","vip","gift",}
    SDKConfig.packageName={
        [1]= "com.dstamp.sjzb.aos.nstore",
        [2]= "com.dstamp.sjzb.aos.ostore",
        [3]= "com.dstamp.sjzb.aos.cstore",
        [4]= "com.dstamp.sjzb.aos.gplay",
        [5]= "com.dstamp.sjzb.ios.astore",
    }
    SDKConfig.AppMarket={
        [1] = "Nstore",
        [2] = "Onestore",
        [3] = "Cstore",
        [4] = "Gplay",
        [5] = "Astore",
    }
function SDKConfig:init()
	
end
return SDKConfig