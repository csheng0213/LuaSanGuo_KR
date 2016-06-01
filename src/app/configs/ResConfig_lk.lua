local ResConfig = {}

--图片资源
ResConfig.spriteFrameRes = {

headPilistRes =
{
    plistPath = "lk/spriteFrameRes/HeadPlist.plist",
    imagePath = "lk/spriteFrameRes/HeadPlist.pvr.ccz"
},
  
Ani_AwardCard_bai =
{
    plistPath = "lk/animaRes/Ani_AwardCard_bai.plist",
    imagePath = "lk/animaRes/Ani_AwardCard_bai.pvr.ccz"
},
Ani_AwardCard_fei =
{
    plistPath = "lk/animaRes/Ani_AwardCard_fei.plist",
    imagePath = "lk/animaRes/Ani_AwardCard_fei.pvr.ccz"
},
Ani_AwardCard_Star =
{
    plistPath = "lk/animaRes/Ani_AwardCard_Star.plist",
    imagePath = "lk/animaRes/Ani_AwardCard_Star.pvr.ccz"
},

Ani_intensify_bao =
{
    plistPath = "lk/animaRes/intensify_bao.plist",
    imagePath = "lk/animaRes/intensify_bao.pvr.ccz"
},

Ani_intensify_card =
{
    plistPath = "lk/animaRes/intensify_card.plist",
    imagePath = "lk/animaRes/intensify_card.pvr.ccz"
},

Ani_Compound_card =
{
    plistPath = "lk/animaRes/Ani_Compound.plist",
    imagePath = "lk/animaRes/Ani_Compound.pvr.ccz"
},

Ani_combatAni = 
{
    plistPath = "lk/animaRes/combatAni.plist",
    imagePath = "lk/animaRes/combatAni.png"
},

}
--声音资源
ResConfig.soundRes = {

    }

--动画资源
ResConfig.animationRes = {

AwardCard_bai = {
    time = 0.1,
    spriteFrameResName = "Ani_AwardCard_bai",
    spriteFrameName = "bbc",
    endIndex = 18
},
AwardCard_fei = {
    time = 0.1,
    spriteFrameResName = "Ani_AwardCard_fei",
    spriteFrameName = "fk",
    endIndex = 8
},
AwardCard_Star = {
    time = 0.1,
    spriteFrameResName = "Ani_AwardCard_Star",
    spriteFrameName = "bguang",
    endIndex = 12
},  
intensify_bao = {
    time = 0.1,
    spriteFrameResName = "Ani_intensify_bao",
    spriteFrameName = "intensify_bao",
    endIndex = 10
},
intensify_card = {
    time = 0.1,
    spriteFrameResName = "Ani_intensify_card",
    spriteFrameName = "intensify_card",
    endIndex = 9
},

Compound_card = {
    time = 0.1,
    spriteFrameResName = "Ani_Compound_card",
    spriteFrameName = "hc",
    endIndex = 18
},
combatAni = {
    time = 0.15,
    spriteFrameResName = "Ani_combatAni",
    spriteFrameName = "",
    endIndex = 8
},    
}


return ResConfig