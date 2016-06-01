--属性系统
--[[
    处理各类属性的计算
    属性buff类型: 1:生命 2:攻击 3:法术 4:法防 5:移动速度
--]]


local max_fight = 30000
local min_fight = 1000

--获得卡牌领兵
--@param : format { id = }
-- id:卡牌id
function pm_GetCardLeadSoldierNum(param)
	assert(param and param.id, "param is error")

	local row = g_RoleCardConfig[param.id]
	if not row then
		return 0
	end
	
	--AddLog('yfvar1,yfvar2,pjvar1+pjvar2+pjvar3+pjvar4+pjvar5+pjvar6:'..yfvar1..','..yfvar2..','..pjvar1..','..pjvar2..','..pjvar3..','..pjvar4..','..pjvar5..','..pjvar6)
	local res = (4/1100)*math.pow(row.tongyu, 2.1)
	--AddLog('Soldier:'..res)
	return math.floor(res)
end

--获取上阵英雄战斗力
--遗留问题， attack = attackEx hp = hpEx mp = fasEx soldier = fafEx 
-- heroInfo format { id = , level = , class = , attackEx = , hpEx = , fasEx = , fafEx = } 
-- id,level,class( 卡牌id, 等级, 阶级); attackEx,hpEx,fasEx,fafEx(其他系统额外添加的 攻击力, 生命, 法术, 法防)

--@param : param : { heroInfo = , partHeros = , equipInfos = }
--@ carInfo (当前卡牌信息); partHeros (偏将信息数组); equipInfos (装备信息数组);

function cs_GetCardFightValue(param)
	
	local att = pm_GetCardAttack(param)
	local hp = pm_GetCardHp(param)
	local fas = pm_GetCardFas(param)
	local faf = pm_GetCardFaf(param)

	local total = math.floor(att + hp*0.15 + fas*0.61 + faf*0.547)
	return total,att,hp,fas,faf
end

--获得生命
function pm_GetCardHp(param)
	assert(param and param.heroInfo, "参数错误，必须有主卡信息")

	local heroInfo = param.heroInfo
	local partHeros = param.partHeros
	local equipInfos = param.equipInfos

	local attackEx, hpEx, fasEx, fafEx
    attackEx = heroInfo.attackEx or heroInfo.attack or 0
    hpEx     = heroInfo.hpEx or heroInfo.hp or 0
    fasEx    = heroInfo.fasEx or heroInfo.mp or 0
    fafEx    = heroInfo.fafEx or heroInfo.soldier or 0

	local row = g_RoleCardConfig[heroInfo.id]
	if not row then
		return 0
	end

	local pjAddValue = 0
	local yfAddPercent = 0
	if partHeros then
		pjAddValue = pm_GetCardHpEx(partHeros)

		local yfv1,yfv2,yft1,yft2 = cs_GetYuanFenIds(heroInfo.id, partHeros)
		if yft1 == 1 then
			yfAddPercent = yfAddPercent + yfv1
		end
		
		if yft2 == 1 then
			yfAddPercent = yfAddPercent + yfv2
		end

	end

	local equipAddValue = 0 
	local equipAddPercent = 0
	if equipInfos then
		for k, v in pairs(equipInfos) do
			if v.attr and v.attr.type == EquipmentData.equipAttrType.hp then
				equipAddValue = equipAddValue + v.attr.value
			end

			if v.rdAttr and v.rdAttr.type == EquipmentData.equipAttrType.hp then
				equipAddPercent = equipAddPercent + v.rdAttr.value
			end
		end
	end
	
	--AddLog('yfvar1,yfvar2,pjvar1+pjvar2+pjvar3+pjvar4+pjvar5+pjvar6:'..yfvar1..','..yfvar2..','..pjvar1..','..pjvar2..','..pjvar3..','..pjvar4..','..pjvar5..','..pjvar6)
	local originalValue = (row.wuli*0.6 + row.zhili*0.4)*((heroInfo.class - 1)*0.1 + 1)
    local baseValue = 40*originalValue + 1.616*(heroInfo.level - 1)*originalValue

	local res = baseValue*(1 + yfAddPercent + equipAddPercent/100) + pjAddValue + equipAddValue*(1 + equipAddPercent/100)
		+ hpEx*equipAddPercent/100
	--print('Attack:'..res )
	return math.floor(res + hpEx)
end


--获得卡牌基础攻击力
function pm_GetCardAttack(param)
	assert(param and param.heroInfo, "参数错误，必须有主卡信息")

	local heroInfo = param.heroInfo
	local partHeros = param.partHeros
	local equipInfos = param.equipInfos

    local attackEx, hpEx, fasEx, fafEx
    attackEx = heroInfo.attackEx or heroInfo.attack or 0
    hpEx     = heroInfo.hpEx or heroInfo.hp or 0
    fasEx    = heroInfo.fasEx or heroInfo.mp or 0
    fafEx    = heroInfo.fafEx or heroInfo.soldier or 0

	local row = g_RoleCardConfig[heroInfo.id]
	if not row then
		return 0
	end

	local pjAddValue = 0
	local yfAddPercent = 0
	if partHeros then
		pjAddValue = pm_GetCardAttackEx(partHeros)

		local yfv1,yfv2,yft1,yft2 = cs_GetYuanFenIds(heroInfo.id, partHeros)
		if yft1 == 2 then
			yfAddPercent = yfAddPercent + yfv1
		end
		
		if yft2 == 2 then
			yfAddPercent = yfAddPercent + yfv2
		end
	end

	local equipAddValue = 0 
	local equipAddPercent = 0
	if equipInfos then
		for k, v in pairs(equipInfos) do
			if v.attr and v.attr.type == EquipmentData.equipAttrType.attack then
				equipAddValue = equipAddValue + v.attr.value
			end

			if v.rdAttr and v.rdAttr.type == EquipmentData.equipAttrType.attack then
				equipAddPercent = equipAddPercent + v.rdAttr.value
			end
		end
	end
	
	local originalValue = math.pow(row.wuli, 1.8)*((heroInfo.class-1)*0.1+1)
	local baseValue = 0.08*originalValue + 0.003232*originalValue*(heroInfo.level - 1)
	local res = baseValue*(1 + equipAddPercent/100 + yfAddPercent) + pjAddValue + equipAddValue*(1 + equipAddPercent/100)
		+ attackEx*equipAddPercent/100

	return math.floor(res + attackEx)
end

--获取法术
function pm_GetCardFas(param)
	assert(param and param.heroInfo, "参数错误，必须有主卡信息")

	local heroInfo = param.heroInfo
	local partHeros = param.partHeros
	local equipInfos = param.equipInfos

    local attackEx, hpEx, fasEx, fafEx
    attackEx = heroInfo.attackEx or heroInfo.attack or 0
    hpEx     = heroInfo.hpEx or heroInfo.hp or 0
    fasEx    = heroInfo.fasEx or heroInfo.mp or 0
    fafEx    = heroInfo.fafEx or heroInfo.soldier or 0

	local row = g_RoleCardConfig[heroInfo.id]
	if not row then
		return 0
	end

	local pjAddValue = 0
	local yfAddPercent = 0
	if partHeros then
		pjAddValue = pm_GetCardFasEx(partHeros)

		local yfv1,yfv2,yft1,yft2 = cs_GetYuanFenIds(heroInfo.id, partHeros)
		if yft1 == 3 then
			yfAddPercent = yfAddPercent + yfv1
		end

		if yft2 == 3 then
			yfAddPercent = yfAddPercent + yfv2
		end

	end

	local equipAddValue = 0 
	local equipAddPercent = 0
	if equipInfos then
		for k, v in pairs(equipInfos) do
			if v.attr and v.attr.type == EquipmentData.equipAttrType.fas then
				equipAddValue = equipAddValue + v.attr.value
			end

			if v.rdAttr and v.rdAttr.type == EquipmentData.equipAttrType.fas then
				equipAddPercent = equipAddPercent + v.rdAttr.value
			end
		end
	end
	
	--AddLog('yfvar1,yfvar2,pjvar1+pjvar2+pjvar3+pjvar4+pjvar5+pjvar6:'..yfvar1..','..yfvar2..','..pjvar1..','..pjvar2..','..pjvar3..','..pjvar4..','..pjvar5..','..pjvar6)
	local originalValue = math.pow(row.zhili, 1.7)*((heroInfo.class - 1)*0.1 + 1)
	local baseValue = 0.1728*originalValue + 0.006981*originalValue*(heroInfo.level - 1)
	local res = baseValue*(1 + yfAddPercent + equipAddPercent/100) + pjAddValue + equipAddValue*(1 + equipAddPercent/100)
			+ fasEx*equipAddPercent/100
	return math.floor(res + fasEx)
end

--获取法防
function pm_GetCardFaf(param)
	assert(param and param.heroInfo, "参数错误，必须有主卡信息")

	local heroInfo = param.heroInfo
	local partHeros = param.partHeros
	local equipInfos = param.equipInfos

    local attackEx, hpEx, fasEx, fafEx
    attackEx = heroInfo.attackEx or heroInfo.attack or 0
    hpEx     = heroInfo.hpEx or heroInfo.hp or 0
    fasEx    = heroInfo.fasEx or heroInfo.mp or 0
    fafEx    = heroInfo.fafEx or heroInfo.soldier or 0

	local row = g_RoleCardConfig[heroInfo.id]
	if not row then
		return 0
	end

	local pjAddValue = 0
	local yfAddPercent = 0
	if partHeros then
		pjAddValue = pm_GetCardFafEx(partHeros)

		local yfv1,yfv2,yft1,yft2 = cs_GetYuanFenIds(heroInfo.id, partHeros)
		if yft1 == 4 then
			yfAddPercent = yfAddPercent + yfv1
		end
		
		if yft2 == 4 then
			yfAddPercent = yfAddPercent + yfv2
		end
	end

	local equipAddValue = 0 
	local equipAddPercent = 0
	if equipInfos then
		for k, v in pairs(equipInfos) do
			if v.attr and v.attr.type == EquipmentData.equipAttrType.faf then
				equipAddValue = equipAddValue + v.attr.value
			end

			if v.rdAttr and v.rdAttr.type == EquipmentData.equipAttrType.faf then
				equipAddPercent = equipAddPercent + v.rdAttr.value
			end
		end
	end
	
	--AddLog('yfvar1,yfvar2,pjvar1+pjvar2+pjvar3+pjvar4+pjvar5+pjvar6:'..yfvar1..','..yfvar2..','..pjvar1..','..pjvar2..','..pjvar3..','..pjvar4..','..pjvar5..','..pjvar6)
	local originalValue = row.zhili*((heroInfo.class - 1)*0.1 + 1)
	local baseValue = 2.4*originalValue + 0.09696*originalValue*(heroInfo.level - 1)
	local res = baseValue*(1 + yfAddPercent + equipAddPercent/100) + pjAddValue + equipAddValue*(1 + equipAddPercent/100)
			+ fafEx*equipAddPercent/100
	--print('Attack:'..res )
	return math.floor(res + fafEx)
end

--获得偏将攻击力加成
--@param : partHeros : 偏将信息数组 
function pm_GetCardAttackEx(partHeros)

	local sum = 0
	for k, v in ipairs(partHeros) do
		if v.id and v.id > 0 then
			sum = sum + pm_GetCardAttack({ heroInfo = v }) * g_RoleCardConfig[v.id].pjAddEx
		end
	end
	return math.floor(sum)
end

--获得偏将血量加成
function pm_GetCardHpEx(partHeros)

	local sum = 0
	for k, v in ipairs(partHeros) do
	    if v.id and v.id > 0 then
            sum = sum + pm_GetCardHp({ heroInfo = v }) * g_RoleCardConfig[v.id].pjAddEx
		end
	end
	return math.floor(sum)

end

--获取偏将法术加成
function pm_GetCardFasEx(partHeros)

	local sum = 0
	for k, v in ipairs(partHeros) do
		if v.id and v.id > 0 then
			sum = sum + pm_GetCardFas({ heroInfo = v }) * g_RoleCardConfig[v.id].pjAddEx
		end
	end
	return math.floor(sum)

end

--获取偏将法防加成
function pm_GetCardFafEx(partHeros)

	local sum = 0
	for k, v in ipairs(partHeros) do
		if v.id and v.id > 0 then
			sum = sum + pm_GetCardFaf({ heroInfo = v }) * g_RoleCardConfig[v.id].pjAddEx
		end
	end
	return math.floor(sum)

end

--获得缘分id ,传入参数：主卡id，6个偏将id -- 其中没有的传入0或者nil --返回 缘分值1,2，缘分类型1,2
--269 76
function cs_GetYuanFenIds(mid, partHeros)

	if not mid or mid == 0 then
		return 0,0,0,0
	end
	if not g_RoleCardConfig then
		assert(false, "卡牌配置数据未加载")
	end
	local row = g_RoleCardConfig[mid]
	if not row then
		assert(false, "卡牌配置数据无法找到")
	end
	if not row or not row.relation then
		return 0,0,0,0
	end

	local id1 = row.relation.relatedID1
	local id2 = row.relation.relatedID2
	local type1 = 0
	local type2 = 0
	local value1 = 0
	local value2 = 0

	for k, v in pairs(partHeros) do
		if v.id == id1 then
			value1 = row.relation.value1
			type1  = row.relation.type1
		elseif v.id == id2 then
			value2 = row.relation.value2
			type2  = row.relation.type2
		end
	end

	return value1, value2, type1, type2
end

-- 计算土兵血量受领兵的加成
function pm_GetSoldierHpEx(hp, lead)
    --     最大加成比    测定常数       测定常数  理论最大领兵，相当于将领兵映射到0~250的区间
    return hp*( 1 + lead/100)*1.5
end

-- 计算土兵攻击受领兵的加成
function pm_GetSoldierAtkEx(atk, lead)
    return atk*( 1 + lead/100)*0.6
end

--计算士兵法术受领兵的加成
function pm_GetSoldierFasEx(fas, lead)
	return fas*( 1 + lead/100)*1
end

--计算士兵法防受领兵的加成
function pm_GetSoldierFafEx(faf, lead)
	return faf*( 1 + lead/100)
end

--士兵对应模型数量
function pm_GetSoldierModelNum(level)
	--print('level:'..level)
	if level < 10 then
		return 1
	elseif level < 20 then
		return 2
	elseif level < 30 then
		return 3
	else
        return 4
	end
end


--获得单个模型的数量
function pm_GetSingleModelSNum( leadNum, modelCount)
	local gridLeadNum = math.floor(leadNum / 9)
	local sigleModelNum = math.floor(gridLeadNum / modelCount)
	return sigleModelNum
end



--1.13卡牌升级消耗铜钱
function cs_CardUpLevelMoney(exps, level )
	local money = math.floor(exps * 1 + 100)
	return money
end


--进阶消耗铜钱数
function cs_GetRoleJinJie( evolution, m_class, quality )
	--local money = math.floor(math.pow(evolution+1,2)*(m_class)*1000 + quality*5000)
	return g_csBaseCfg.upMoney[m_class]
end

--进化消耗铜钱数
function cs_GetRoleKJinHua( evolution, m_class, quality )
	local money = math.floor(math.pow(evolution+1,3)*5000 + quality*50000)
	return money
end


--获得玩家升级经验：传入当前等级，返回下一级需要的经验值
function g_csGetNextExp(lvl)
	--lvl = lvl + 1
	--return lvl*lvl*lvl*2-lvl*lvl*4+100
	return g_roleUplevelExp[lvl] or 0
end

--获得错误码
function g_csGetErrorString(ecode)
	local str = g_csErrorString[ecode]
	if not str then
		AddLog('ecode error:'..tostring(ecode))
		str = '启禀主公，战事发送了意外，请稍后重试'
	end
	AddLog(str)
	return str
end





--随机获得角色名：0-男 1-女
--随机角色名
local g_csRoleName = {
	{"李","王","张","刘","陈","杨","赵","黄","周","吴","徐","孙","胡","朱","高","林","何","郭","马","罗","梁","宋","郑","谢","韩","唐","冯","于","董","萧","程","曹","袁","邓","许","傅","沈","曾","彭","吕","苏","卢","蒋","蔡","贾","丁","魏","薛","叶","阎","余","潘","杜","戴","夏","钟","汪","田","任","姜","范","方","石","姚","谭","廖","邹","熊","金","陆","郝","孔","白","崔","康","毛","邱","秦","江","史","顾","侯","邵","孟","尤","万","段","雷","钱","汤","尹","黎","易","常","武","乔","贺","赖","龚","文","莫","欧阳","太史","端木","上官","司马","东方","独孤","南宫","夏侯","诸葛","尉迟","皇甫","太叔","公孙","长孙","宇文","司徒","鲜于","司寇","拓跋","轩辕","令狐","左丘",},
	{"位","杰","洋","勇","磊","强","军","涛","超","刚","明","俊","战","胜","永","丛","斌","博","冬","健","睿","尧","玄","巍","旭","焯","律","帅","敏","蔚","飞","聪","迪","琳","哲","亮","炎","宏","圣杰","俊楠","鸿涛","伟祺","荣轩","子轩","鸿涛","浩宇","瑾瑜","智宸","烨华","正豪","昊然","志泽","睿渊","弘文","哲瀚","楷瑞","建辉","昕远","致远","俊驰","雨泽","烨磊","国豪","伟奇","文博","天佑","文昊","修杰","黎昕","远航","旭尧","英杰","圣杰","俊楠","鸿涛","伟祺","荣轩","浩宇","瑾瑜","昊","天","思聪","展鹏","笑愚","伟强","文强","志强","志明","明志","炫明","雪松","思源","智渊","思淼","晓","啸","天宇","浩然","文轩","鹭洋","振家","乐驹","晓博","文博","昊焱","立果","金鑫","锦程",
		"嘉熙","鹏飞","子默","思远","浩轩","语堂","聪健","鹏程","鹏","家意","振国","博","鸿","文淼","世杰","涵霖","琦枫","欣雨","冬霖","涵文","宽","冬鑫","晟宏","昊鹏","玮鑫","智睿","冬麟","唯翰","咏麒","远志","彬","瀚","宇恒","志远","明君","俊峰","东升","俊凯","明琦","思远","冠杰","泽成","泽辉","泽凯","锦华","新杰","家辉","向阳","志扬","天奇","冠恒","博才","旭华","建宏","博涛","文辉","英成","继山","玉良","恒一","守帅","晓明","江麟","学宇","一丁","锦东","水生","崇江","永强","玮晔","易和","艺元","昌俊","志毅","伟丰","晓伟","海涛","康强","天来","少林","熠斐","尔乐","建勇","树青","雄波","加乐","志权","春朋","淦清","智韬","广堂","一源","桂武","健华","肇祺","伟坚","楚水",
		"俊鸣","剑衡","伟果","滨","文俊","志权","春朋","淦清","康","山东","友明","铭基","奎泽","国星","科霖","建平","懿强","英祖","浩均","志星","诗途","绍永","弋戈","晓宇","焯文","雄略","宇航","清锋","伟伟","春辉","佳村","永捷","景辉","宗锡","永杰","启明","启勇","敏彦","镜林","世鸿","启杰","耀良","振飞","庆山","泽波","斯鸿","康令","利蓬","利可","宏坤","芍文","明明","子鹏","巨河","佑能","志","辉","蔚丹","锦城","浩斌","佳权","川琪","英政","涛洲","伟炜","智钊","建峰","付钊","基民","国森","锦其","柱民","元杰","彦秋","宝昌","清远","金耀","景照","基委","洪成","宗辉","文耀","海波","年煜","钢鸿","菊顺","曼华","成钢","心石","德东","镇威","剑华","肇祺","勇强","燕辉","嘉豪","锡洪",
		"富连","泽彬","晓东","满钦","勇坚","历程","林胜","志列","林胜","志列","飞儒","英生","进添","一贵","天可","浩强","培雄","君成","允侦","林安","文广","昭典","植文","泽峰","远大","永楷","志兴","文","岳","义毅","仁相","雪武","链彬","海滨","晓凯","和鹏","碧涛","新发","洪祥","燕增","锦武","乐胜","金富","海泉","进均","基民","显声","周明","锦伦","亮明","华杰","保健","海瑞","汝坚","培培","雷镭","海平","楚烈","兰瑞","凯洪","文敏","捷洧","坚贞","崇耿","晓昫","勇标","耿义","东升","奕锋","丹宏","顺孝","建豪","坚炎","洽鹏","晓丰","文加","周全","昭","贤","文忠","丕汉","伟国","志华","卓锐","德芹","继华","满钦","剑华","心石","海泉","和鹏","一贵","冠荣","德芹","林胜","创辉","耿义",
		"陆林","少航","鄂波","国威","仲川","曦文","肇波","熠栋","怡明","铿翘","上圣","观程","子鹏","维山","锦芬","祥海","官富","冠州","国雄","肖军","宇忠","志洲","汉昭","志翔","孝坤","港忠","国兴","德才","韬韬","扬彦","泽楷","家帆","若谷","丁财","根旺","炳松","荣生","焕奕","观程","东彬","建仕","官富","俏浩","宇轩","绍安","氏",},
	{"李","王","张","刘","陈","杨","赵","黄","周","吴","徐","孙","胡","朱","高","林","何","郭","马","罗","梁","宋","郑","谢","韩","唐","冯","于","董","萧","程","曹","袁","邓","许","傅","沈","曾","彭","吕","苏","卢","蒋","蔡","贾","丁","魏","薛","叶","阎","余","潘","杜","戴","夏","钟","汪","田","任","姜","范","方","石","姚","谭","廖","邹","熊","金","陆","郝","孔","白","崔","康","毛","邱","秦","江","史","顾","侯","邵","孟","尤","万","段","雷","钱","汤","尹","黎","易","常","武","乔","贺","赖","龚","文","莫","欧阳","太史","端木","上官","司马","东方","独孤","南宫","夏侯","诸葛","尉迟","皇甫","太叔","公孙","长孙","宇文","司徒","鲜于","司寇","拓跋","轩辕","令狐","左丘","明月",},
	{"千凡","又蕊","安荷","初兰","安阳","代晴","晓彤","醉珊","从易","平彤","平卉","含真","之彤","怀青","友柳","幻雪","初柔","慕春","飞玉","秋晴","映儿","之风","语云","觅易","南曼","忆柔","安瑶","痴蕊","恨易","映云","曼丝","平真","幼凡","寒风","灵玉","傲文","思双","冷青","秋竹","碧霜","春云","沛芹","语巧","绿岚","念凝","书雪","醉双","山阳","念柳","平筠","醉南","碧巧","晓露","寻菡","沛白","平灵","水彤","安彤","涵易","乐巧","依风","紫南","亦丝","易蓉","紫萍","惜萱","诗蕾","寻绿","诗双","寻云","孤丹","谷蓝","惜香","谷枫","山灵","幻丝","友梅","从云","雁丝","盼旋","幼旋","尔蓝","沛山","代丝","痴梅","觅松","冰香","依玉","冰之","妙梦","以冬","碧春","曼青","冷菱","雪曼","安白",
		"香桃","安春","千亦","凌蝶","又夏","南烟","靖易","沛凝","翠梅","书文","雪卉","乐儿","傲丝","安青","初蝶","寄灵","惜寒","雨竹","冬莲","绮南","翠柏","平凡","亦玉","孤兰","秋珊","新筠","半芹","夏瑶","念文","晓丝","涵蕾","雁凡","谷兰","灵凡","凝云","曼云","丹彤","南霜","夜梦","从筠","雁芙","语蝶","依波","晓旋","念之","盼芙","曼安","采珊","盼夏","初柳","迎天","曼安","南珍","妙芙","语柳","含莲","晓筠","夏山","尔容","采春","念梦","傲南","问薇","雨灵","凝安","冰海","初珍","宛菡","冬卉","盼晴","冷荷","寄翠","幻梅","如凡","语梦","易梦","千","柔","向露","梦玉","傲霜","依霜","灵松","诗桃","书蝶","恨真","冰蝶","山槐","以晴","友易","梦桃","香","菱","孤云","水蓉","雅容","飞烟",
		"雁荷","代芙","醉易","夏烟","山梅","若南","恨桃","依秋","依波","香巧","紫萱","涵易","忆之","幻巧","水风","安寒","白亦","惜玉","碧春","怜雪","听南","念蕾","梦竹","千凡","寄琴","采波","元冬","思菱","平卉","笑柳","雪卉","南蓉","谷梦","巧兰","绿蝶","飞荷","平安","孤晴","芷荷","曼冬","寻巧","寄波","尔槐","以旋","绿蕊","初夏","依丝","怜南","千山","雨安","水风","寄柔","念巧","幼枫","凡桃","新儿","春翠","夏波","雨琴","静槐","元槐","映阳","飞薇","小凝","映寒","傲菡","谷蕊","笑槐","飞兰","笑卉","迎荷","元冬","书竹","半烟","绮波","小之","觅露","夜雪","春柔","寒梦","尔风","白梅","雨旋","芷珊","山彤","尔柳","沛柔","灵萱","沛凝","白容","乐蓉","映安","依云","映冬","凡雁","梦蝶",
		"醉柳","梦凡","秋巧","若云","元容","怀蕾","灵寒","天薇","白风","访波","亦凝","易绿","夜南","曼凡","亦巧","青易","冰真","白萱","友安","诗翠","雪珍","海之","小蕊","又琴","香彤","语梦","惜蕊","迎彤","沛白","雁山","易蓉","雪晴","诗珊","春冬","又绿","冰绿","半梅","笑容","沛凝","念瑶","天真","含巧","如冬","向真","从蓉","春柔","亦云","向雁","尔蝶","冬易","丹亦","夏山","醉香","盼夏","孤菱","安莲","问凝","冬萱","晓山","雁蓉","梦蕊","山菡","南莲","飞双","凝丝","思萱","怀梦","雨梅","冷霜","向松","迎丝","迎梅","听双","山蝶","夜梅","醉冬","巧云","雨筠","平文","青文","半蕾","幼菱","寻梅","含之","香之","含蕊","亦玉","靖荷","碧萱","寒云","向南","书雁","怀薇","思菱","忆文","翠巧",
		"怀山","若山","向秋","凡白","绮烟","从蕾","天曼","又亦","依琴","曼彤","沛槐","又槐","元绿","安珊","夏之","易槐","宛亦","白翠","丹云","问寒","易文","傲易","青旋","思真","妙之","半双","若翠","初兰","怀曼","惜萍","初之","宛丝","寄南","小萍","幻儿","千风","天蓉","雅青","寄文","代天","春海","惜珊","向薇","冬灵","惜芹","凌青","谷芹","香巧","雁桃","映雁","书兰","盼香","向山","寄风","访烟","绮晴","傲柔","寄容","以珊","紫雪","芷容","书琴","寻桃","涵阳","怀寒","易云","采蓝","代秋","惜梦","尔烟","谷槐","怀莲","涵菱","水蓝","访冬","半兰","又柔","冬卉","安双","冰岚","香薇","语芹","静珊","幻露","访天","静柏","凌","丝","小翠","雁卉","访文","凌文","芷云","思柔","巧凡","慕山","依云",
		"千柳","从凝","安梦","香旋","凡巧","映天","安柏","平萱","以筠","忆曼","新竹","绮露","觅儿","碧蓉","白竹","飞兰","曼雁","雁露","凝冬","含灵","初阳","海秋","香天","夏容","傲冬","谷翠","冰双","绿兰","盼易","思松","梦山","友灵","绿竹","灵安","凌柏","秋柔","又蓝","尔竹","香天","天蓝","青枫","问芙","语海","灵珊","凝丹","小蕾","迎夏","水之","飞珍","冰夏","亦竹","飞莲","海白","元蝶","春蕾","芷天","怀绿","尔容","元芹","若云","寒烟","听筠","采梦","凝莲","元彤","觅山","痴瑶","代桃","冷之","盼秋","秋寒","慕","蕊","巧夏","海亦","初晴","巧蕊","听安","芷雪","以松","梦槐","寒梅","香岚","寄柔","映冬","孤容","晓蕾","安萱","听枫","夜绿","雪莲","从丹","碧蓉","绮琴","雨文","幼荷","青柏",
		"痴凝","初蓝","忆安","盼晴","寻冬","雪珊","梦寒","迎南","巧香","采南","如彤","春竹","采枫","若雁","翠阳","沛容","幻翠","山兰","芷波","雪瑶","代巧","寄云","慕卉","冷松","涵梅","书白","乐天","雁卉","宛秋","傲旋","新之","凡儿","夏真","静枫","痴柏","恨蕊","乐双","白玉","问玉","寄松","丹蝶","元瑶","冰蝶","访曼","代灵","芷烟","白易","尔阳","怜烟","平卉","丹寒","访梦","绿凝","冰菱","语蕊","痴梅","思烟","忆枫","映菱","访儿","凌兰","曼岚","若枫","傲薇","凡灵","乐蕊","秋灵","谷槐","觅云","水凡","灵秋","代卉","笑天","白夏","又青","冬梅","从珊","又香","雪容","以彤","冷萱","夜卉","念雁","尔阳","水荷","尔真","孤阳","之卉","依薇","妙双","醉巧","痴海","惜筠","从筠","碧白","曼珍",
		"觅晴","寄蓉","慕雁","水丹","幼霜","凝绿","又松","丹山","元旋","怜云","觅丹","向槐","水冬","天青","语丝","怀芹","曼彤","雪绿","从冬","凌春","问风","凌寒","代蓝","幼白","山雁","若薇","芷蓝","寄蓝","谷之","海凡","新柔","靖之","涵桃","怀雁","怀桃","含云","雨凝","幻玉","寄蕾","怜双","诗丹","亦梅","向露","水竹","雨筠","书凝","紫云","冬雁","翠荷","小凝","念霜","水蕊","友槐","雅柏","青寒","夏兰","迎真","醉芙","以柳","半槐","尔晴","以儿","以菡","访旋","友容","沛海","秋荷","雪瑶","之柳","恨玉","山白","凌双","忆莲","又易","平蓝","忆蓝","寄柔","冰芹","醉竹","静筠","乐曼","紫山","巧青","安真","绿松","易雁","静梅","宛丹","忆风","依白","访真","香凝","寒绿","雨荷","雅萱","晓巧",
		"芷枫","映梦","沛柔","初风","幼绿","盼烟","宛云","涵霜","笑真","之双","语寒","醉冬","海亦","又曼","诗青","从文","之薇","傲蕊","又旋","南绿","冰筠","巧安","采阳","巧荷","靖珍","书阳","绿云","梦萱","翠莲","采荷","千柔","幻露","代丹","安露","露露","秀萍","沛风","秋亦","之灵","静丝","以蓝","寒灵","水曼","丹旋","雅云","平青","语玉","代灵","雅松","采亦","忆青","水云","以阳","雁旋","含兰","雨青","笑巧","孤蝶","映风","海风","飞之","含阳","涵兰","曼菱","冷海","灵烟","冷海","幻蓉","惜曼","海亦","忆筠","灵冬","紫玉","依烟","沛灵","丹琴","灵蕊","静绿","冰蕊","盼凝","碧雁","初珍","语枫","南绿","友芹","香琴","又蓉","雨菱","思双","痴双","海真","紫筠","易蝶","思云","小雪","天云",
		"念雁","平绿","慕珍","访曼","念瑶","青山","又容","问绿","丹菡","傲琴","含云","惜风","乐彤","从柳","巧雁","含之","宛旋","忆梅","笑桃","凡云","沛亦","梦竹","之绿","初菡","初桃","听梦","如竹","绮寒","千蕊","采珍","沛春","痴安","曼安","痴梅","夏蓉","山天","南春","乐白","寻翠","迎荷","灵荷","南芹","凡晴","凡白","沛绿","平柔","幼柳","紫柔","安天","依菱","凌晴","巧凝","飞竹","绿波","以琴","雅珍","山彤","若松","夏海","傲夏","冷绿","半亦","丹翠","念凡","碧儿","梦凝","孤波","紫安","香萱","思柔","水翠","书柔","忆云","元之","绮柳","之霜","幻南","迎双","晓阳","半芙","书容","访松","以秋","小竹","亦梦","春儿","雪春","涵真","寒晴","乐青","依竹","初玉","夏柳","新柔","雁香","之雁",
		"访波","半菡","冷桃","夜风","念雪","夜梅","向丝","元雪","沛安","雨琴","含天","香莲","雅蓉","从波","笑卉","山云","水秋","乐",}
}
function cs_GetRoleName(sex)
	AddLog('sex:'..sex)
	if sex == 0 then
		local x = math.random(#g_csRoleName[1])
		local m = math.random(#g_csRoleName[2])
		local name = (g_csRoleName[1][x] or "")..(g_csRoleName[2][m] or "")
		AddLog(name)
		return name
	else
		local x = math.random(#g_csRoleName[3])
		local m = math.random(#g_csRoleName[4])
		local name = (g_csRoleName[3][x] or "")..(g_csRoleName[4][m] or "")
		AddLog(name)
		return name
	end
end

--------------------------------------------


g_IllegalWords =
{
"毛泽东","周恩来","刘少奇","朱德","彭德怀","林彪","刘伯承","陈毅","贺龙","聂荣臻","徐向前","罗荣桓","叶剑英","李大钊","陈独秀","孙中山","孙文","孙逸仙","邓小平","陈云","江泽民","李鹏","朱镕基","李瑞环","尉健行","李岚清","胡锦涛","罗干","温家宝","习近平","吴邦国","曾庆红","贾庆林","黄菊","吴官正","李长春","吴仪","回良玉","曾培炎","周永康","曹刚川","唐家璇","华建敏","陈至立","陈良宇","张德江","张立昌","俞正声","王乐泉","刘云山","王刚","王兆国","刘淇","贺国强","郭伯雄","胡耀邦","王乐泉"," 李登辉","连战","陈水扁","宋楚瑜","吕秀莲","郁慕明","蒋介石","蒋中正","蒋经国","马英九","李克强","曾慶紅","胡耀邦","胡錦涛","江擇民",
"布什","布莱尔","小泉纯一郎","萨马兰奇","安南","阿拉法特","普京","默克尔","克林顿","里根","尼克松","林肯","杜鲁门","赫鲁晓夫","列宁","斯大林","马克思","恩格斯","金正日","金日成","萨达姆","胡志明","西哈努克","希拉克","撒切尔","阿罗约","曼德拉","卡斯特罗","富兰克林","华盛顿","艾森豪威尔","拿破仑","亚历山大","路易","拉姆斯菲尔德","劳拉","鲍威尔","布朗","奥巴马","梅德韦杰夫","潘基文","希特勒","塞福昂•艾则孜",
"本拉登","拉登","奥马尔","柴玲","达赖喇嘛","江青","张春桥","姚文元","王洪文","东条英机","希特勒","墨索里尼","冈村秀树","冈村宁次","高丽朴","赵紫阳","王丹","沃尔开西","李洪志","李大师","赖昌星","马加爵","班禅","额尔德尼","山本五十六","阿扁",
"藏独","高丽棒子","回回","疆独","蒙古鞑子 台独","台独分子","台联","台湾民国"," 藏青会 藏妇会","西藏独立","新疆独立","南蛮","老毛子","回民吃猪肉 藏?独","藏旗","东北独立","回民暴动","苗疆","西藏","台湾共和国","西藏分裂","台湾獨立","台湾共和国",
"大法","法轮","法轮功","瘸腿帮","真理教","真善忍","转法轮","自焚","走向圆满","黄大仙","风水","跳大神","神汉","神婆","真理教","大卫教","阎王","黑白无常","牛头马面","法一轮一大一法","falundafa","fa轮","hongzhi","轮功","falun","FLG","喇嘛","李红智","falundafa","发^^轮","法论工","達賴","法谪功","李洪志","法仑攻","毛法轮大法",
"吸毒","贩毒","赌博","拐卖","走私","卖淫","造反","监狱","强奸","轮奸","抢劫","先奸后杀","出售假钞","出售枪支","出售手枪","买卖枪支","自杀指南",
"安非他命","大麻","可卡因","海洛因","冰毒","摇头丸","杜冷丁","鸦片","罂粟","迷幻药","白粉","嗑药","吸毒","罂粟","盐酸二氢埃托啡","三唑仑","麥角酸二乙基酰胺","兴奋剂","迷歼药","可卡因","可卡叶","鹽酸二氢埃托啡","磕药","大麻","磕藥","毛可卡叶","盐酸二乙酰吗啡","挥发型迷药","鸦片","罌粟","吗啡碱","苯環利啶","毛麦角酸","可待因","苯环已呱啶","摇头玩","昏药","K粉","吗啡片","大麻树脂","麻醉乙醚","盐酸二乙醯吗啡","迷幻藥",
"sf","私服","私人服务器","wg","外挂 WG","waigua","加速补丁","脚本","外掛","外卦","私—服","运营","运营者","运营组","运营商","运营长","运营官","运营人",
"Client Server","CS","Cs","cs","cS","KEFU","kefu","Kefu","KeFu","助理","客户服务","客服",
"game master","GAMEMASTER","GameMaster","GM","Gm","gM","gm","G.M","游戏管理员","管理员",
"爱滋","淋病","梅毒","爱液","屄","逼","臭机八","臭鸡巴","吹喇叭","吹箫","催情药","屌","肛交","肛门","龟头","黄色","机八","机巴","鸡八","鸡巴","机掰","机巴","鸡叭 鸡鸡","鸡掰","鸡奸","妓女","奸","茎","精液","精子","尻","口交","滥交","乱交","轮奸","卖淫","屁眼","嫖娼","强奸","强奸犯","情色","肉棒","乳房","乳峰","乳交","乳头","乳晕","三陪","色情","射精","手淫","威而钢","威而柔","伟哥","性高潮","性交","性虐","性欲","穴","颜射","阳物","一夜情","阴部","阴唇","阴道","阴蒂","阴核","阴户","阴茎","阴门","淫","淫秽","淫乱","淫水","淫娃","淫液","淫汁","淫穴","淫洞","援交妹","做爱","梦遗","阳痿","早泄","奸淫","性交","换妻","AV片","av","H漫画",
"も","れ","ア","ガ","ダ","ナ","ピ","ヨ","ヲ","ㄌ","ㄖ","ㄠ","▼","","","｀","く","す","っ","ね","ぷ","め","る","ァ","カ","サ","タ","ド","ビ","ポ","ョ","ヱ","ㄋ","ㄕ","ㄟ","ㄩ","〩","え","げ","ぜ","て","ば","ぺ","や","ゎ","イ","ギ","ジ","ヂ","ヌ","ブ","ム","リ","ヴ","Ж","ㄎ","ㄘ","ㄢ","┇","┑","┛","┥","┯","┹","◢","ぇ","け","せ","づ","は","べ","ゃ","ろ","ィ","キ","シ","チ","ニ","フ","ミ","ラ","ン","Ё","П","Щ","ㄗ","ㄡ","§","№","☆","★","○","●","◎","◇","◆","□","▲","¤","▆","▇","█","█","■","▓","≡","╝","╚","╔","╗","╬","═","╓","╩","┠","┨","卐","◤","◥","△","が","ざ","だ","な","ぴ","ま","よ","を","エ","ゲ","ゼ","テ","バ","ペ","ヤ","ヮ","Γ","Ν","Ψ","ぎ","じ","ぬ","ぶ","む","り","オ","ゴ","ゾ","ト","ヒ","ボ","ユ","ヰ","お","ご","ぞ","と","ひ","ぼ","ゆ","ゐ","ウ","グ","ズ","ツ","ノ","ヘ","モ","レ","","ぉ","こ","そ","で","ぱ","ほ","ゅ","わ","ゥ","ク","ス","ッ","ネ","メ","ル","ヵ","┈","┒","├","┦","┰","┺","╄","╗","╡","╫","◣","⊙","★","ⅲ",
}

--获得当前最大体力
function cs_GetMaxEnergy(lvl)
	--local ex = math.max(0,math.floor((lvl-20)/5)) * 5
	--return g_csBaseCfg.MaxBaseEnergy + ex
	return 2000
end

--士兵升级消耗武魂数
--消耗武魂=（士兵等级+（阶数-1）*30）^2*参数A+参数B*阶数^4
--暂定：参数A=50 参数B=1000
function cs_GetRoleLevelUP( level, ladde )
	local aaa = level+(ladde-1)*10
	local spend = aaa*aaa*50+1000*math.pow(ladde,4)
	return spend
end

--主城税收当前可收铜币的公式
--玩家等级，士兵等级，士兵阶级
function cs_GetTax( level, slvl, class )
	local cs = 0.006
	local jscs = 1
	if class==2 then
		jscs = 1.5
	elseif class==3 then
		jscs = 2
	end
	local tax = ( (slvl+(class-1)*30) *jscs*cs+1 )*level*100
	return tax
end

--出售角色卡
--卡 品质，等级，阶级，进阶数
function cs_SellCard( quality, level, class)
	local money = g_csBaseCfg.SellRoleCard[class][quality]
	return money
end

-- 3-5星卡牌提供经验=常数*等级N+[（1+进阶数*0.1）*进化数]*参数
local g_killcardchangshu = 100
local g_killcardSpe1 = 2000
local g_killcardSpe2 = 5000
local g_killcardSpe3 = 10000
local g_killcardcanshu = {[1]=300,[2]=500,[3]=800,[4]=1200,[5]=2000,}
function cs_GetCardKillExp(prop,slot,id, quality, level, class)
	-- local sum = 0
	-- for k = 1,level - 1 do
		-- sum = sum + g_roleCardUp[k]
	-- end
	
	-- local cardCurExp = 0
	-- cardCurExp = prop.m_pRoleCardBag[slot].m_exp
	-- sum = sum + cardCurExp
	
	-- sum = math.floor(sum / 2)
	return g_csBaseCfg.CardExp[quality]  --+ sum
end
--获得卡牌的总经验
function cs_GetCardAllExp(prop,slot,level)
	local sum = 0
	for k = 1,level - 1 do
		sum = sum + g_roleCardUp[k]
	end
	local cardCurExp = 0
	cardCurExp = prop.m_pRoleCardBag[slot].m_exp
	sum = math.floor(sum + cardCurExp)
	return sum
end
--获取卡牌的总武魂
function cs_GetCardAllSoul(prop,slot)
	local class = prop.m_pRoleCardBag[slot].m_class
	local sum = 0
	for k = 1, class - 1 do
		sum = sum + g_csBaseCfg.upSoul[k]
	end
	return sum
end
--获取卡牌的总钱数
function cs_GetCardAllMoney(prop,slot)
	local class = prop.m_pRoleCardBag[slot].m_class
	local sum = 0
	for k = 1, class - 1 do
		sum = sum + g_csBaseCfg.upMoney[k]
	end
	return sum
end
--获取阶级对应的卡牌数量
function cs_GetCardAllCard(prop, slot)
	local class = prop.m_pRoleCardBag[slot].m_class
	local sum = 0
	for k = 1, class - 1 do
		sum = sum + g_csBaseCfg.upCardCount[k]
	end
	return sum
end

--强化士兵消耗的道具
function cs_SoldierItem(lvl)
	return (lvl-1) * 1
end

--团队副本开启活跃
function cs_UnionLiven()
	return 1000 * 66
end

function cs_MakeSkillString(
                range, pos, frdly,
                cond, pct_cond, prob, condv, condvp,
                delay, interval, total_time,
                effect, propc, state, pct, val,
                stype,
                raw_mp, raw_atk)
    local sr_str = {
        --[[ 1]]"周围",
        --[[ 2]]"扇形范围",
        --[[ 3]]"前方",

        --[[ 4]]"全体",
        --[[ 5]]"除了自己的全体单位",
        --[[ 6]]"主将",
        --[[ 7]]"副将",
        --[[ 8]]"士兵",

        --[[ 9]]"武将",
        --[[10]]"的目标",
        --[[11]]"的当前目标",

        --[[12]]"攻击最高的单位",
        --[[13]]"生命最高的单位",
        --[[14]]"筹谋最高的单位",
        --[[15]]"攻击速度最快的单位",
        --[[16]]"移动速度最快的单位",
        --[[17]]"攻击范围最大的单位",

        --[[18]]"攻击最低的单位",
        --[[19]]"生命最低的单位",
        --[[20]]"筹谋最低的单位",
        --[[21]]"攻击速度最慢的单位",
        --[[22]]"移动速度最慢的单位",
        --[[23]]"攻击范围最小的单位",

        --[[24]]"最近的将领",

        --[[25]]"步兵",
        --[[26]]"骑兵",
        --[[27]]"弓兵",

        --[[28]]"蜀国武将",
        --[[29]]"吴国武将",
        --[[30]]"魏国武将",
        --[[31]]"群雄武将",

        --[[32]]"全体武将",

        --[[33]]"最近武将的周围单位",
        --[[34]]"最近武将的扇形范围单位",
        --[[35]]"最近武将的前方单位",
    }

    local sp_str = {
        --[[36]]"武将自身",
        --[[37]]"指定目标",
        --[[38]]"指定位置",
    }
    
    local ses_str = {
        --[[39]]"百分比吸血",
                "", "", "", -- 3个克制
        --[[40]]"固定免伤",
        --[[41]]"百分比免伤",
    }

    local spc_str = {
        --[[42]]"攻击",
        --[[43]]"生命",
        --[[44]]"生命上限",
        --[[45]]"筹谋",
        --[[46]]"筹谋上限",
        --[[47]]"攻击速度",
        --[[48]]"移动速度",
        --[[49]]"攻击范围",
    }

    local svc_str = {
        --[[50]]"生命大于",
        --[[51]]"生命小于",
    }

    local svpc_str = {
        --[[52]]"生命大于",
        --[[53]]"生命小于",
    }

    local mp_pct = 0.0
    local atk_pct = 0.0

    if stype == 1 then
        mp_pct = 0.75
        atk_pct = 0.25
    elseif stype == 2 then
        mp_pct = 0.3
        atk_pct = 0.7
    end

    local getExProp = function(v)
        return
        --       最大加成比
        v + v * 1.2 * (
            1 - 1.01 ^ (      -- 测定常数
                -(
                    raw_atk * atk_pct +
                    raw_mp * mp_pct
                ) * 250.0 / 5000.0    -- 理论属性最大值，映射到0~250的区间
            )
        )
    end

    val = tonumber(string.format("%0.0f", getExProp(val)))
    pct = getExProp(pct)

    local p = {}
    for i=1,20 do
        p[i]=""
    end

    local svc_s = svc_str[cond]
    local svpc_s = svpc_str[pct_cond]
    if svc_s or svpc_s then
        p[1] = "当"
        p[4] = "时，"
    end

    if svc_s then
        p[2] = svc_s .. condv
    end
    if svpc_s then
        p[3] = svpc_s .. string.format("%0.0f", condvp*100) .. "%"

        if svc_s then
            p[3] = "，" .. p3
        end
    end

    local precision = 0.001

    if math.abs(prob - 1.0) > precision then
        p[5] = "有" .. string.format("%0.0f", prob*100) .. "%几率"
    end

    -- SE_PROP_CHANGE    SE_PROP_CHANGE_TIME
    if effect == 1 or effect == 2 then
        if pct > precision then
            p[6] = "增加"
        elseif pct < -precision then
            p[6] = "减少"
        else
            if val > 0 then
                p[6] = "增加"
            else
                p[6] = "减少"
            end
        end
    else
        p[6] = "使"
    end

    if frdly == 1 then
        p[7] = "我方"
    else
        p[7] = "敌军"
    end

    local sp_s = sp_str[pos]
    p[8] = sp_s or ""

    local range_s = sr_str[range]
    p[9] = range_s or ""

    -- SR_CIRCLE  SR_SECTOR  SR_RECTANGEL
    if range == 1 or range == 2 or range == 3 then
        p[10] = p[7]
        p[7] = ""
        p[11] = "单位"

    -- SR_SELF  SR_TARGET  SR_CUR_TARGET
    elseif range ~= 9 and range ~= 10 and range ~= 11 then
        p[8] = ""
    end

    if range == 9 then
        p[7] = ""
        p[9] = ""
    end

    local ses_s = ses_str[state]
    -- SE_PROP_CHANGE    SE_PROP_CHANGE_TIME
    if effect ~= 1 and effect ~= 2 then
        local s = ses_s or ""
        if effect == 5 then
            s = "冰冻"
        end
        p[12] = "进入" .. s .. "状态"

        local tmp = ""
        if math.abs(pct) > precision then
            tmp = string.format("%0.0f", math.abs(pct)*100) .. "%"
        end

        if val ~= 0 then
            tmp = tostring(val)
        end

        if string.len(tmp) ~= 0 then
            p[12] = p[12] .. "，数值为" .. tmp
        end
    else
        if math.abs(pct) > precision then
            p[12]  = string.format("%0.0f", math.abs(pct)*100) .. "%"
            if val ~= 0 then
                p[13] = "+"
            end
        end

        if val ~= 0 then
            p[14] = "" .. math.abs(val) .. "点"
        end

        local spc_s = spc_str[propc]
        p[15] = "的" .. (spc_s or "") .. "，具体数值受到" ..
                (stype == 1 and "筹谋" or "攻击") .. "影响"
    end

    local isec = string.format("%0.1f", interval/60.0)
    isec = string.sub(isec, -2, -1) == ".0" and string.sub(isec, 1, -3) or isec
    local tsec = string.format("%0.1f", total_time/60.0)
    tsec = string.sub(tsec, -2, -1) == ".0" and string.sub(tsec, 1, -3) or tsec

    if interval ~= total_time then
        p[16] = "，每" .. isec .. "秒一次，持续" .. tsec .. "秒"
    elseif interval ~= 0 then
        p[16] = "，持续" .. tsec .. "秒"
    end

    --[[
    p[17] = "后返还"

    -- SE_PROP_CHANGE_TIME
    if effect ~= 2 then
        p[17] = ""
    end
    --]]

    p[18] = "。"

    local ret_str = table.concat(p)
    print(ret_str)
    
    return ret_str
end



function cs_getPassMoney(l,s)
	return math.floor( ( ((l-1)*10+s)-1)^1.5 +100 )
end
