local ResConfig = {}

--图片资源
ResConfig.spriteFrameRes = {

gameSet = {
    plistPath = "cs/spriteFrameRes/gameSet.plist",
    imagePath = "cs/spriteFrameRes/gameSet.png"
},

--技能动画资源
hitEffects = {
    plistPath = "cs/animaRes/skillAnimas/hitEffects.plist",
    imagePath = "cs/animaRes/skillAnimas/hitEffects.pvr.ccz"
},

Ani_daoguang_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_daoguang.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_daoguang.pvr.ccz"
},
Ani_duodaoguang_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_duodaoguang.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_duodaoguang.pvr.ccz"
},
Ani_greenLight_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_greenLight.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_greenLight.pvr.ccz"
},
Ani_ice_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_ice.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_ice.pvr.ccz"
},
Ani_KnifeLight_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_KnifeLight.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_KnifeLight.pvr.ccz"
},
Ani_Lightning_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_Lightning.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_Lightning.pvr.ccz"
},
Ani_phoenix_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_phoenix.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_phoenix.pvr.ccz"
},
Ani_phoenixdis_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_phoenixdis.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_phoenixdis.pvr.ccz"
},
Ani_purpleLight_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_purpleLight.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_purpleLight.pvr.ccz"
},
Ani_redLight_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_redLight.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_redLight.pvr.ccz"
},
Ani_SLightning_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_SLightning.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_SLightning.pvr.ccz"
},
Ani_vampire_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_vampire.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_vampire.pvr.ccz"
},
Ani_yellowLight_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_yellowLight.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_yellowLight.pvr.ccz"
},
combatBefore = {
    plistPath = "cs/ui_res/CombatUI/before.plist",
    imagePath = "cs/ui_res/CombatUI/before.pvr.ccz"
},
Ani_dian_res = {
    plistPath = "cs/animaRes/skillAnimas/Ani_dian.plist",
    imagePath = "cs/animaRes/skillAnimas/Ani_dian.pvr.ccz"
},
Ani_levelup_res = {
    plistPath = "cs/animaRes/uiAnimas/uplevel.plist",
    imagePath = "cs/animaRes/uiAnimas/uplevel.png"
}
,

}

if G_CurrentLanguage == "ch" then
    ResConfig.spriteFrameRes.Ani_levelup_res = 
    {
        plistPath = "cs/animaRes/uiAnimas/Ani_levelup.plist",
        imagePath = "cs/animaRes/uiAnimas/Ani_levelup.pvr.ccz"
    }
end

--声音资源
ResConfig.soundRes = {
    
}

--动画资源
ResConfig.animationRes = {

Ani_baoqi = {
    time = 0.06,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_baoqi",
    endIndex = 13 
},
Ani_fireball = {
    time = 0.06,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_fireball",
    endIndex = 7
},
Ani_fireballB = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_fireballB",
    endIndex = 8 
},
Ani_bubinhit = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_bubinhit",
    endIndex = 4 
},
Ani_gongbinghit = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_gongbinghit",
    endIndex = 4 
},
Ani_herohit = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_herohit",
    endIndex = 4 
},
Ani_qibinghit = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_qibinghit",
    endIndex = 4 
},
Ani_skillRelease = {
    time = 0.1,
    spriteFrameResName = "hitEffects",
    spriteFrameName = "Ani_skillRelease",
    endIndex = 11 
},

--技能动画资源
Ani_daoguang = {
    time = 0.1,
    spriteFrameResName = "Ani_daoguang_res",
    spriteFrameName = "Ani_daoguang",
    endIndex = 9
},
Ani_dian = {
    time = 0.1,
    spriteFrameResName = "Ani_dian_res",
    spriteFrameName = "Ani_dian",
    endIndex = 8
},
Ani_duodaoguang = {
    time = 0.1,
    spriteFrameResName = "Ani_duodaoguang_res",
    spriteFrameName = "Ani_duodaoguang",
    endIndex = 14
},
Ani_greenLight = {
    time = 0.1,
    spriteFrameResName = "Ani_greenLight_res",
    spriteFrameName = "Ani_greenLight",
    endIndex = 15
},
Ani_ice = {
    time = 0.1,
    spriteFrameResName = "Ani_ice_res",
    spriteFrameName = "Ani_ice",
    endIndex = 18
},
Ani_KnifeLight = {
    time = 0.1,
    spriteFrameResName = "Ani_KnifeLight_res",
    spriteFrameName = "Ani_KnifeLight",
    endIndex = 11
},
Ani_Lightning = {
    time = 0.1,
    spriteFrameResName = "Ani_Lightning_res",
    spriteFrameName = "Ani_Lightning",
    endIndex = 15
},

Ani_phoenix = {
    time = 0.1,
    spriteFrameResName = "Ani_phoenix_res",
    spriteFrameName = "Ani_phoenix",
    endIndex = 20
},
Ani_phoenixdis = {
    time = 0.1,
    spriteFrameResName = "Ani_phoenixdis_res",
    spriteFrameName = "Ani_phoenixdis",
    endIndex = 20
},
Ani_purpleLight = {
    time = 0.1,
    spriteFrameResName = "Ani_purpleLight_res",
    spriteFrameName = "Ani_purpleLight",
    endIndex = 11
},
Ani_redLight = {
    time = 0.1,
    spriteFrameResName = "Ani_redLight_res",
    spriteFrameName = "Ani_redLight",
    endIndex = 14
},
Ani_SLightning = {
    time = 0.1,
    spriteFrameResName = "Ani_SLightning_res",
    spriteFrameName = "Ani_SLightning",
    endIndex = 10
},
Ani_vampire = {
    time = 0.1,
    spriteFrameResName = "Ani_vampire_res",
    spriteFrameName = "Ani_vampire",
    endIndex = 10
},
Ani_yellowLight = {
    time = 0.1,
    spriteFrameResName = "Ani_yellowLight_res",
    spriteFrameName = "Ani_yellowLight",
    endIndex = 11
},
Ani_yellowLight = {
    time = 0.1,
    spriteFrameResName = "Ani_yellowLight_res",
    spriteFrameName = "Ani_yellowLight",
    endIndex = 11
},
Ani_levelup = {
    time = 0.06,
    spriteFrameResName = "Ani_levelup_res",
    spriteFrameName = "Ani_levelup",
    endIndex = 24
}

}


return ResConfig