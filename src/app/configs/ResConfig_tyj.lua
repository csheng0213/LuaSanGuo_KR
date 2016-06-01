local ResConfig = {}

--图片资源
ResConfig.spriteFrameRes = {
        propRes = {
            plistPath = "tyj/spriteFrameRes/daoju.plist",
            imagePath = "tyj/spriteFrameRes/daoju.png"
        },
        achievementRes = {
            plistPath = "tyj/spriteFrameRes/achievement.plist",
            imagePath = "tyj/spriteFrameRes/achievement_frame.pvr.ccz"
        },
        heroCardRes = {
            plistPath = "tyj/spriteFrameRes/CardPlist.plist",
            imagePath = "tyj/spriteFrameRes/CardPlist.pvr.ccz"
        },
        playerHeadRes = {
            plistPath = "tyj/spriteFrameRes/kakuang.plist",
            imagePath = "tyj/spriteFrameRes/kakuang.pvr.ccz"
        },
        sodiersRes = {
            plistPath = "tyj/spriteFrameRes/SodiersCradinfo.plist",
            imagePath = "tyj/spriteFrameRes/SodiersCradinfo.png"
        },
        tianTiRes = {
            plistPath = "tyj/spriteFrameRes/highLadder.plist",
            imagePath = "tyj/spriteFrameRes/highLadder.pvr.ccz"
        },
        zhengRongRes = {
            plistPath = "tyj/spriteFrameRes/herosinfo.plist",
            imagePath = "tyj/spriteFrameRes/herosinfo.pvr.ccz"
        }, 
        xueZhanRes = {
            plistPath = "tyj/spriteFrameRes/xuezhan.plist",
            imagePath = "tyj/spriteFrameRes/xuezhan.pvr.ccz"
        }, 
        payRes = {
            plistPath = "tyj/spriteFrameRes/pay.plist",
            imagePath = "tyj/spriteFrameRes/pay.pvr.ccz"
        },
        equipmentRes = {
            plistPath = "tyj/spriteFrameRes/equipment.plist",
            imagePath = "tyj/spriteFrameRes/equipment.png"
        },
        dynamicUI_res = {
            plistPath = "tyj/dynamicUI_res/dynamicUI_res.plist",
            imagePath = "tyj/dynamicUI_res/dynamicUI_res.png"
        },
       --动画资源
        sevenStarBaoAnimas = {
           plistPath = "tyj/animaRes/Ani_SevenStars_bao.plist",
           imagePath = "tyj/animaRes/Ani_SevenStars_bao.pvr.ccz"
        },
        sevenStarCardAnimas = {
            plistPath = "tyj/animaRes/sevenstar_st.plist",
            imagePath = "tyj/animaRes/sevenstar_st.pvr.ccz"
        },
        xueZhanAnimas = {
            plistPath = "tyj/animaRes/xuezhan_effects.plist",
            imagePath = "tyj/animaRes/xuezhan_effects.pvr.ccz"
        },
        loadingAnimas = {
            plistPath = "cs/animaRes/uiAnimas/Ani_loading.plist",
            imagePath = "cs/animaRes/uiAnimas/Ani_loading.pvr.ccz"
        },
        shiLianAnimas = {
            plistPath = "tyj/animaRes/heroTryToEffects.plist",
            imagePath = "tyj/animaRes/heroTryToEffects.pvr.ccz"
        },  
        chengJiuAnimas = {
            plistPath = "tyj/animaRes/chengJiuAnimas.plist",
            imagePath = "tyj/animaRes/chengJiuAnimas.png"
        }, 
        taskRewardAnimas = {
            plistPath = "tyj/animaRes/taskReward.plist",
            imagePath = "tyj/animaRes/taskReward.png"
        }, 
        enhanceAnimas = {
            plistPath = "tyj/animaRes/enhance.plist",
            imagePath = "tyj/animaRes/enhance.png"
        },
}

--声音资源
ResConfig.soundRes = {

    }

--动画资源
ResConfig.animationRes = {
--七星坛
    An_bao = {
        time=0.07,
        spriteFrameResName = "sevenStarBaoAnimas",
        spriteFrameName = "Ani_SevenStars_bao",
        endIndex = 8
    },
    An_card = {
        time=0.07,
        spriteFrameResName = "sevenStarCardAnimas",
        spriteFrameName = "Ani_SevenStars",
        endIndex = 8
    }, 
--血战
    An_easy = {
        time=0.07,
        spriteFrameResName = "xueZhanAnimas",
        spriteFrameName = "Ani_easy",
        endIndex = 6
    },  
    An_diff = {
        time=0.07,
        spriteFrameResName = "xueZhanAnimas",
        spriteFrameName = "Ani_put",
        endIndex = 9
    },   
    An_lianYu = {
        time=0.07,
        spriteFrameResName = "xueZhanAnimas",
        spriteFrameName = "Ani_greensmoke",
        endIndex = 9
    },  
--布阵
    An_footNote = {
        time=0.07,
        spriteFrameResName = "playerHeadRes",
        spriteFrameName = "footnote",
        endIndex = 5
    },  
--试炼
    An_shiLian = {
        time=0.1,
        spriteFrameResName = "shiLianAnimas",
        spriteFrameName = "Ani_cardaround",
        endIndex = 10
    }, 
    --成就动画
    An_chengJiu= {
        time=0.04,
        spriteFrameResName = "chengJiuAnimas",
        spriteFrameName = "",
        endIndex = 17
    }, 
     --任务领奖动画
    An_taskReward= {
        time=0.1,
        spriteFrameResName = "taskRewardAnimas",
        spriteFrameName = "",
        endIndex = 6
    },
--加载资源动画
    --马儿跑
    An_loading= {
        time=0.07,
        spriteFrameResName = "loadingAnimas",
        spriteFrameName = "Ani_loading",
        endIndex = 8
    }, 
   --点点动
    An_point= {
        time=0.2,
        spriteFrameResName = "loadingAnimas",
        spriteFrameName = "Ani_point",
        endIndex = 4
    }, 
    --洗练动画
    An_enhance= {
        time=0.05,
        spriteFrameResName = "enhanceAnimas",
        spriteFrameName = "000",
        endIndex = 63
    }, 
}


return ResConfig