local adbrixIntent = {
    --firstTimeExperience
    ["terms_try"] = function ()
        NativeUtil:javaCallHanler({command = "firstTimeExperience",activityName = "terms_try"})
    end,
    ["terms_complete"] = function ()
        NativeUtil:javaCallHanler({command = "firstTimeExperience",activityName = "terms_complete"})
    end, 
    ["login_try"] = function ()
        NativeUtil:javaCallHanler({command = "firstTimeExperience",activityName = "login_try"})
    end,
    ["login_complete"] = function ()

    end, 
    ["btn_gamestart_try"] = function ()

    end,
    ["btn_gamestart_complete"] = function ()

    end, 
    ["update_try"] = function ()

    end,
    ["update_complete"] = function ()

    end, 
    ["cartoon_0_1_try"] = function ()

    end,
    ["loading_1_try"] = function ()

    end, 
    ["loading_1_complete"] = function ()

    end,
    ["tutorial_combat_try"] = function ()

    end, 
    ["tutorial_combat_complete"] = function ()

    end,
    ["cartoon_1_1_try"] = function ()

    end, 
    ["cartoon_1_3_complete"] = function ()

    end,
    ["nickname_create_try"] = function ()

    end, 
    ["nickname_create_complete"] = function ()

    end,
    ["loading_2_try"] = function ()

    end, 
    ["loading_2_complete"] = function ()

    end,
    ["level_2"] = function ()

    end, 
    ["level_3"] = function ()

    end, 
    ["level_4"] = function ()

    end,
    ["level_5"] = function ()

    end, 
    ["level_6"] = function ()

    end,
    --buy
    ["3300"] = function ()
        NativeUtil:javaCallHanler({command = "buy",activityName = "3300"})
    end, 
    ["5500"] = function ()

    end,
    ["11000"] = function ()

    end, 
    ["33000"] = function ()

    end, 
    ["55000"] = function ()

    end,
    ["110000"] = function ()

    end,    
    --retension
    ["herohof_inter"] = function (  )
        NativeUtil:javaCallHanler({command = "retension",activityName = "herohof_inter"})
    end,
    ["herohof_buy_sliver_1_free"] = function (  )

    end,
    ["herohof_buy_sliver_1_nonfree"] = function (  )

    end,
    ["herohof_buy_sliver_10"] = function (  )

    end,
    ["herohof_buy_gold_1_free"] = function (  )

    end,
    ["herohof_buy_gold_1_nonfree"] = function (  )

    end,
    ["herohof_buy_gold_10"] = function (  )

    end,
    ["blood_inter"] = function (  )

    end,
    ["blood_try"] = function (  )

    end,
    ["hero_traing_inter"] = function (  )

    end,
    ["hero_traing_try"] = function (  )

    end,
    ["castle_inter"] = function (  )

    end,
    ["mgt_castle_mission_try"] = function (  )

    end,
    ["mgt_castle_mission_complete"] = function (  )

    end,
    ["mgt_castle_mission_reward_complete"] = function (  )

    end,
    ["seven_castle_try"] = function (  )

    end,
    ["seven_castle_try"] = function (  )

    end,
    ["pvp_inter"] = function (  )

    end,
    ["pvp_try"] = function (  )

    end,
    ["shop_inter"] = function (  )

    end,
    ["silver_inter"] = function (  )

    end,
    ["silver_buy"] = function (  )

    end,
    ["energy_inter"] = function (  )

    end,
    ["energy_buy"] = function (  )

    end,
    ["newhero_buy"] = function (  )

    end,
    ["pvp_more_buy"] = function (  )

    end,
    ["dungeon_reset_buy"] = function (  )

    end,
    ["mgt_castle_mission_reward_buy"] = function (  )

    end,
    ["guild_create_buy"] = function (  )

    end,
    ["guild_reward_reset_buy"] = function (  )

    end,
    ["growth_wealth"] = function (  )

    end,
    ["gold_recharging_inter"] = function (  )

    end,
}
return adbrixIntent