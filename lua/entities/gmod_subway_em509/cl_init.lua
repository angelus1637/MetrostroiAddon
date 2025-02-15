--------------------------------------------------------------------------------
-- All the models, materials, sounds belong to their corresponding authors. Permission is granted to only distribute these models through Garry's Mod Steam Workshop and the official Metrostroi GitHub accounts for use with Garry's Mod and Metrostroi Subway Simulator.
--
-- It is forbidden to use any of these models, materials, sounds and other content for any commercial purposes without an explicit permission from the authors. It is forbidden to make any changes in these files in any derivative projects without an explicit permission from the author.
--
-- The following models are (C) 2015-2018 oldy (Aleksandr Kravchenko). All rights reserved.
-- models\metrostroi_train\81-502:
-- - 81-502  (Ema-502 head)
-- - 81-501  (Em-501 intermediate)
-- models\metrostroi_train\81-702:
-- - 81-702  (D head)
-- - 81-702  (D intermediate)
-- models\metrostroi_train\81-703:
-- - 81-703  (E head)
-- - 81-508  (E intermediate)
-- models\metrostroi_train\81-707:
-- - 81-707  (Ezh head)
-- - 81-708  (Ezh1 intermediate)
-- models\metrostroi_train\81-710:
-- - 81-710  (Ezh3 head)
-- - 81-508T (Em-508T intermediate)
-- models\metrostroi_train\81-717:
-- - 81-717  (Moscow head)
-- - 81-714  (Moscow intermediate)
-- - 81-717  (St. Petersburg head)
-- - 81-714  (St. Petersburg intermediate)
-- models\metrostroi_train\81-718:
-- - 81-718  (TISU head)
-- - 81-719  (TISU intermediate)
-- models\metrostroi_train\81-720:
-- - 81-720  (Yauza head)
-- - 81-721  (Yauza intermediate)
-- - 81-722  (Yubileyniy head)
-- models\metrostroi_train\81-722:
-- - 81-723  (Yubileyniy intermediate motor)
-- - 81-724  (Yubileyniy intermediate trailer)
--------------------------------------------------------------------------------
include("shared.lua")

---Вагон типа Еж
--------------------------------------------------------------------------------
ENT.ClientProps = {}
ENT.ButtonMap = {}
ENT.AutoAnims = {}
ENT.AutoAnimNames = {}
ENT.ClientSounds = {}

ENT.ButtonMap["Main1"] = {
    pos = Vector(455.5,-31.2,-11.2+0.2),
    ang = Angle(0,-90,11.5),
    width = 285,
    height = 180,
    scale = 0.0588,
    hideseat = 0.2,

    buttons = {
        {ID = "KU8Set", x=88,y=35, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z=-12,vmin=1, vmax=0,
            var="KU8",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU10Set", x=187, y=35, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-12,vmin=1, vmax=0,
            var="KU10",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU9Set", x=138,y=35, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-9,vmin=1, vmax=0,
            var="KU9",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU2Toggle", x=227, y=29,w=42,h=55, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-21,
            var="KU2",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},



        {ID = "KU15Set", x=15,y=40,w=42,h=55, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-21,
            var="KU15",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},

        {ID = "KU1Toggle", x=88,y=80, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-20,scale=0.85,ang=90,
            var="KU1",speed=16,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU11Set", x=138,y=87, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z=-9,vmin=1, vmax=0,
            var="KU11",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        {ID = "KU4Set", x=36.5, y=137, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-12,vmin=1, vmax=0,
            var="KU4",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU5Set", x=89, y=137, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl", z=-12,vmin=1, vmax=0,
            var="KU5",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},

        {ID = "UV1Set", x=138, y=136, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-12,vmin=1, vmax=0,
            var="UV1",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},


        ----Door panel
        {ID = "KU6Set", x=188, y=136, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-12,vmin=1, vmax=0,
            var="KU6",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU7Set", x=248, y=136, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl", z=-12,vmin=1, vmax=0,
            var="KU7",speed=16,
            sndvol = 0.07, snd = function(val) return val and "button3_on" or "button3_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU6KToggle",x=190, y=81, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-508/em508_switcher.mdl",z=-20,scale=0.85,
            var="KU6K",speed=6,ang=0,
            disableoff="KU6Set",disableon="KU7Set",
            getfunc = function(ent)
                return ent:GetPackedBool("KU6K") and (ent:GetPackedBool("KU6") and 0.8 or 1) or (ent:GetPackedBool("KU7") and 0.2 or 0)
            end,
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Left","Train.Buttons.Right"}
        }},
        {ID = "!KU6K",x=188, y=136, radius=0, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2.5,y=-30,vmin=0.83,vmax=1,
            var="KU6K",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        {ID = "!KU7K",x=248, y=136, radius=0, model = {
            model = "models/metrostroi_train/81-703/cabin_doors_cover.mdl",ang = Angle(0,180,180),z=-2.5,y=-30,vmin=0,vmax=0.17,
            var="KU6K",speed=1,
            sndvol = 0.10, snd = function(val) return val and "kr_left" or "kr_right" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
        --{ID = "DoorSelectToggle",   x=43.6+43*4.5, y=180, radius=12, tooltip=""},
    }
}

local strength = {
    [0] = 0.86,
    [1] = 0.29,
    [2] = 0.71,
    [3] = 0.71,
    [4] = 0.57,
    [5] = 0.71,
    [6] = 0.86,
    [7] = 0.43,
    [8] = 1.00,
    [9] = 0.86,
}
ENT.ButtonMap["Lamps"] = {
    pos = Vector(457.8  ,-30.1-1,-7.4),
    ang = Angle(0,-90,90-30),
    width = 290,
    height = 70,
    scale = 0.0588,
    hideseat=0.2,

    buttons = {
        {ID = "!GRP", x=13+20+0*25+12,y=6, w=50-24,h=50, tooltip="", model = {
            lamp = {model = "",bscale=Vector(1.2,0.6,1),z = -45, var="GRP"}
        }},
        {ID = "!LSN", x=13+20+1*25+12,y=6, w=50-24,h=50, tooltip="", model = {
            lamp = {model = "",bscale=Vector(1.2,0.6,1),z = -45,var="SN",getfunc = function(ent) return ent:GetPackedRatio("RRP")^2*1.01 end}
        }},
        {ID = "!RRP", x=13+20+2*25+12,y=6, w=50-24,h=50, tooltip="", model = {
            lamp = {model = "",bscale=Vector(1.2,0.6,1),z = -45,var="RP",getfunc = function(ent) return math.Clamp((ent:GetPackedRatio("RRP")-0.45)*7,0,1) end}
        }},
        {ID = "!Speedometer1",x=110-6+12,y=9,w=50-24,h=50,tooltip="",model = {
            name="Speed2",model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl",color=Color(250,50,20),skin=0,z=-40,ang=Angle(0,0,-90),            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),math.floor(ent:GetPackedRatio("Speed")*100)) end,
            sprite = {bright=0.1,size=.5,scale=0.02,vscale=0.025,z=1,color=Color(250,50,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("V1") then return 0 end
                return strength[math.floor(ent:GetPackedRatio("Speed")*10)%10]
            end},
        }},
        {ID = "!Speedometer2",x=110+6+12,y=9,w=50-24,h=50,tooltip="",model = {
            name="Speed1",model = "models/metrostroi_train/81-717/segments/segment_mvm.mdl",color=Color(250,50,20),skin=0,z=-40,ang=Angle(0,0,-90),            tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.Speed"),math.floor(ent:GetPackedRatio("Speed")*100)) end,
            sprite = {bright=0.1,size=.5,scale=0.02,vscale=0.025,z=1,color=Color(250,50,20),aa=true,getfunc= function(ent)
                if not ent:GetPackedBool("V1") then return 0 end
                return strength[math.floor(ent:GetPackedRatio("Speed")*100)%10]
            end},
        }},
        {ID = "!SD", x=43+20+3*25+12,y=6, w=50-24,h=50, tooltip="", model = {
            lamp = {model = "",bscale=Vector(1.2,0.6,1),z = -45, var="SD",}
        }},
        {ID = "!UKS", x=43+20+4*25+12,y=6, w=50-24,h=50, tooltip="", model = {
            lamp = {model = "",bscale=Vector(1.2,0.6,1),z = -45, var="UKS",}
        }},


        {   ID = "KU16Toggle",    x=255, y=49, radius=10, tooltip="", model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_w_a.mdl",ang = 180,z=-2,
            var="KU16",speed=16,
            sndvol = 1, snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["PanelLamp"] = {
    pos = Vector(453.7,-57.31,42),
    ang = Angle(180,275,-5),
    width = 100,
    height = 200,
    scale = 0.0588,

    buttons = {
        {ID = "PanelLampToggle", x=0, y=0, w=100, h=200, tooltip="",var="PanelLights"},
    }
}

ENT.ButtonMap["AVU"] = {
    pos = Vector(462.9,-19,35.5),
    ang = Angle(0,-95.5,90),
    width = 95,
    height = 85,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {   ID = "OtklAVUToggle",    x=48, y=51, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-2,
            var="OtklAVU",speed=16,
            plomb = {model = "models/metrostroi_train/81/plomb.mdl",ang=270,x=-1,y=24,z=-2,var="OtklAVUPl", ID="OtklAVUPl",},
            sndvol = 1, snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "!AVULight",           x=69, y=51, radius=10, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl", skin = 3, z = -4,
            lamp = {model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6,var="AVU",color=Color(210,170,255),},
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(210,170,255),},
        }},
    }
}
ENT.ClientProps["asotp"] = {
    model = "models/metrostroi_train/81-707/asotp.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat = 1,
}
ENT.ButtonMap["ASNP"] = {
    pos = Vector(461.42,-35.2,36.4),
    ang = Angle(-0.4,-97,90),
    width = 115,
    height = 60,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "R_ASNPMenuSet",x=58, y=48.5, radius=8, tooltip = "Информатор: Меню",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPMenu",speed=12, vmin=0, vmax=0.9,z=-3,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPUpSet",x=105, y=14.5, radius=8, tooltip = "Информатор: Вверх",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPUp",speed=12, vmin=0, vmax=0.9,z=-3,
            sndvol = 0.5,snd = function(val) return val and "pnm_button1_on" or "pnm_button2_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPDownSet",x=105, y=31, radius=8, tooltip = "Информатор: Вниз",model = {
            model = "models/metrostroi_train/81-720/button_round.mdl",
            var="R_ASNPDown",speed=12, vmin=0, vmax=0.9,z=-3,
            sndvol = 0.5,snd = function(val) return val and "pnm_button2_on" or "pnm_button1_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "R_ASNPOnToggle",x=12, y=18, radius=8, tooltip = "Информатор: Включение",model = {
            model = "models/metrostroi_train/81-720/tumbler2.mdl", ang=0, z = -3,
            var="R_ASNPOn",speed=12, vmin=1, vmax=0,
            sndvol = 0.5,snd = function(val) return val and "pnm_on" or "pnm_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["ASNPScreen"] = {
    pos = ENT.ButtonMap["ASNP"].pos+Vector(-0.1,-1.6,-0.85),
    ang = Angle(-.4,-97,90),
    width = 512,
    height = 128,
    scale = 0.008,
    hideseat = 0.2,
    hide=true,
}


ENT.ButtonMap["IGLAButtons"] = {
    pos = Vector(459.1,-53.7,15.81+1),
    ang = Angle(-0,237.1,90),
    width = 87,
    height = 70,
    scale = 0.0625,
    hideseat = 0.2,
    buttons = {
        {ID = "IGLA1USet",x=11, y=39, w=12, h=7, tooltip=""},
        {ID = "IGLA1Set",x=11, y=46, w=12, h=7, tooltip=""},
        {ID = "IGLA1DSet",x=11, y=53, w=12, h=7, tooltip=""},
        {ID = "IGLA2USet",x=65, y=39, w=12, h=7, tooltip=""},
        {ID = "IGLA2Set",x=65, y=46, w=12, h=7, tooltip=""},
        {ID = "IGLA2DSet",x=65, y=53, w=12, h=7, tooltip=""},
        {ID = "!IGLASR",x=17.9, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLASR",color=Color(175,250,20),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=-1,}
        }},
        {ID = "!IGLARX",x=27.5, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLARX",color=Color(255,56,30),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-1,}
        }},
        {ID = "!IGLAErr",x=40.5, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAErr",color=Color(255,168,000),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,168,000),z=-1,}
        }},
        {ID = "!IGLAOSP",x=50, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOSP",color=Color(175,250,20),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(175,250,20),z=-1,}
        }},
        {ID = "!IGLAPI",x=59.5, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAPI",color=Color(255,56,30),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-1,}
        }},
        {ID = "!IGLAOff",x=69, y=10.5, radius=3, tooltip="", model = {
            lamp = {speed=16,model = "models/metrostroi_train/common/lamps/svetodiod2.mdl", var="IGLAOff",color=Color(255,56,30),z=-2},
            sprite = {bright=0.5,size=0.25,scale=0.01,color=Color(255,56,30),z=-1,}
        }},
    }
}
ENT.ButtonMap["IGLA"] = {
    pos = ENT.ButtonMap["IGLAButtons"].pos+Vector(-0.30,-0.6,-1.25),
    ang = ENT.ButtonMap["IGLAButtons"].ang,
    width = 512,
    height = 128,
    scale = 0.025/2.7,
    hideseat = 0.2,
    hide=true,

}
ENT.ClientProps["E_informator"] = {
    model = "models/metrostroi_train/equipment/rri_informator_portable.mdl",
    pos = Vector(404.75,-38,-4.2),
    ang = Angle(0,0,0),
    hideseat = 0.2,
}
ENT.ButtonMap["RRI"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(-0.65,-0.5,5),
    ang = Angle(0,90,0),
    width = 60,
    height = 25,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "RRIEnableToggle",x=10,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-4,
            var="RRIEnable",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!RRIRewind",x=30,y=12.5,radius=0,model = {
            model = "models/metrostroi_train/81-502/buttons/tumbler_b_a.mdl",ang = 180,z=-3,
            getfunc = function(ent) return ent:GetPackedRatio("RRIRewind") end,
            var="RRIRewind",speed=8,
            sndvol = 0.5,snd = function(_,val) return val==2 and "triple_0-up" or val==0 and "triple_0-down" or "triple_up-0" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "RRIRewindSet2",x=30-5,y=12.5-10,w=10,h=10,tooltip=""},
        {ID = "RRIRewindSet0",x=30-5,y=12.5,w=10,h=10,tooltip=""},

        {ID = "RRIAmplifierToggle",x=50,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_tumbler_t1.mdl",ang = 180,z=-4,
            var="RRIAmplifier",speed=16,
            sndvol = 1,snd = function(val) return val and "switchbl_on" or "switchbl_off" end,
            sndmin = 90,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "!RRIOn",x=70,y=12.5,radius=10,tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_slc77.mdl",z = -13,
            lamp = { model = "models/metrostroi_train/81-717/buttons/slc_77_lamp.mdl",ang=62,x=-0.3,y=-0.3,z=20.6, var="RRIOn", color=Color(210,170,255), getfunc=function(ent,min,max,var) return ent:GetPackedBool(var) and (1-(ent.AnnLamp or 0)^1.5*0.6) or 0 end, },
            sprite = {bright=0.2,size=.5,scale=0.03,z=20,color=Color(210,170,255),},
        }},
    }
}
ENT.ButtonMap["RRIScreen"] = {
    pos = ENT.ClientProps["E_informator"].pos+Vector(2,-2.9,5),
    ang = Angle(0,90,90),
    width = 121,
    height = 103,
    scale = 0.07,
    hideseat = 0.2,
    hide=true,

    buttons = {
        {ID = "RRIUp",x=30,y=60,radius=10,tooltip=""},
        {ID = "RRIDown",x=30,y=80,radius=10,tooltip=""},
        {ID = "RRILeft",x=20,y=70,radius=10,tooltip=""},
        {ID = "RRIRight",x=40,y=70,radius=10,tooltip=""},
    }
}

--VU Panel
ENT.ButtonMap["VU"] = {
    pos = Vector(464.20,-17,20),
    ang = Angle(0,268,90),
    width = 70,
    height = 100,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "VUToggle", x=0, y=0, w=70, h=100, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=-8, ang = 180,
            labels={{model="models/metrostroi_train/81-502/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["KU14"] = {
    pos = Vector(463.5,-18,5.3),
    ang = Angle(0,268,90),
    width = 45,
    height = 85,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KU14Set", x=0, y=0, w=45, h=85, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudbrown.mdl", z=0,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=12,ang=90,z=18.9,x=0,y=-25.5}},
            var="KU14",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["KU10R"] = {
    pos = Vector(462.6,-15.8,-0.8),
    ang = Angle(5,270,90),
    width = 140,
    height = 80,
    scale = 0.0625,
    hideseat=0.2,

    buttons = {
        {   ID = "KU10RSet",      x=0, y=0, w=140,h=80, tooltip="", model = {
            model = "models/metrostroi_train/81-702/buttons/emer_doors.mdl", z=0, ang=Angle(-90,0,0),
            var="KU10R",speed=12,
            sndvol = 0.1, snd = function(val) return val and "vu220b1_on" or "vu220b1_off" end,
            sndmin = 90, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["Stopkran"] = {
    pos = Vector(461.6,27,3),
    ang = Angle(0,-90,90),
    width = 100,
    height = 1300,
    scale = 0.1/2,
        buttons = {
            {ID = "EmergencyBrakeValveToggle",x=0, y=0, w=100, h=1300, tooltip="", tooltip="",tooltip="",states={"Train.Buttons.Closed","Train.Buttons.Opened"},var="EmergencyBrakeValve"},
    }
}
ENT.ClientProps["stopkran"] = {
    model = "models/metrostroi_train/81-717/stop_mvm.mdl",
    pos = Vector(464.5-0.1,24.4,-3),
    ang = Angle(0,270,0),
    hide = 0.8,
}
ENT.ClientSounds["EmergencyBrakeValve"] = {{"stopkran",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}

ENT.ButtonMap["AVMain"] = {
    pos = Vector(405.5,40,36),
    ang = Angle(0,90,90),
    width = 290,
    height = 270,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "AVToggle", x=0, y=0, w=290, h=270, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_av8r.mdl",x=-35, y=55, z=23, ang = Angle(90,0,0),
            var="AV",speed=0.85, vmin=0.73,vmax=0.80,
            sndvol = 1, snd = function(val) return val and "av8_on" or "av8_off" end,
        }},
    }
}


ENT.ButtonMap["KRR"] = {
    pos = Vector(403,-25,4),
    ang = Angle(0,90,90),
    width = 20,
    height = 20,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KRRSet",         x=10, y=10, radius=20, tooltip="", model = {
            model = "models/metrostroi_train/81-710/ezh3_button_red.mdl",
            var="KRR",speed=16,vmin=1,vmax=0,
            sndvol = 0.10, snd = function(val) return val and "button2_on" or "button1_off" end,sndmin = 60, sndmax = 1e3/3, sndang = Angle(-90,0,0),
        }},
    }
}

---Av1 Panel
ENT.ButtonMap["AV1"] = {
    pos = Vector(403.5,39.3,18),
    ang = Angle(0,90,90),
    width = 340,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VU3Toggle", x=0, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU3",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU2Toggle", x=120, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU2",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
        {ID = "VU1Toggle", x=240, y=0, w=100, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=0,ang=90,z=20.9,x=0,y=-12.5}},
            var="VU1",speed=6,
            sndvol = 0.5, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 50, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}


ENT.ButtonMap["AV2"] = {
    pos = Vector(403.5,31.7,26),
    ang = Angle(0,90,90),
    width = 100,
    height = 136,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "RSTToggle", x=0, y=0, w=100, h=136, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=3,ang=90,z=20.9,x=0,y=-12.5}},
            plomb = {model = "models/metrostroi_train/equipment/vu_plomb_left.mdl",ang=Angle(-90,90,0),x=-8,y=33.7,z=9.3,var="RSTPl", ID="RSTPl",},
            var="RST",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
ENT.ButtonMap["50V"] = {
    pos = Vector(403.4,20.5,8.5),
    ang = Angle(0,90,90),
    width = 100,
    height = 136,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "50VToggle", x=0, y=0, w=100, h=136, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black.mdl", z=20, ang = 180,
            var="50V",speed=6,
            sndvol = 1, snd = function(val) return val and "vu22_on" or "vu22_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}


-- Battery panel
ENT.ButtonMap["Battery"] = {
    pos = Vector(403.5,21.2,17.3),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "VBToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black_3.mdl", z=15, ang=Angle(90,0,180),
            var="VB",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}
-- Battery panel
ENT.ButtonMap["PassHeaters"] = {
    pos = Vector(404.10,-45,29),
    ang = Angle(0,90,90),
    width = 250,
    height = 140,
    scale = 0.0625,
    hide = 0.8,

    buttons = {
        {ID = "HPassToggle", x=0, y=0, w=250, h=140, tooltip="", model = {
            model = "models/metrostroi_train/Equipment/vu22_black_2.mdl", z=15, ang=Angle(90,0,180),
            var="HPass",speed=6,vmin=1,vmax=0,
            sndvol = 1, snd = function(val) return val and "vu223_on" or "vu223_off" end,
            sndmin = 100, sndmax = 1e3, sndang = Angle(0,0,0),
        }},
    }
}

-- Parking brake panel
ENT.ButtonMap["ParkingBrake"] = {
    pos = Vector(457,45.0,-2.0),
    ang = Angle(0,-83,90),
    width = 300,
    height = 400,
    scale = 0.0625,

    buttons = {
        {ID = "ParkingBrakeLeft",x=0, y=0, w=150, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
        {ID = "ParkingBrakeRight",x=150, y=0, w=150, h=400, tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.ParkingBrake"),ent:GetPackedRatio("ManualBrake")*100) end},
    }
}

-- Train driver helpers panel
ENT.ButtonMap["DriverMicrophone"] = {
    pos = Vector(446,-58.5,10.8),
    ang = Angle(0,-89,90),
    width = 30,
    height = 30,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "R_Program1Set",  x=15, y=30, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -5.5,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=7,ang=90,z=2,x=0,y=27}},
            var="R_Program1",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["HelperPanel"] = {
    pos = Vector(453.5,59,22.45),
    ang = Angle(0,-53,90),
    width = 60,
    height = 235,
    scale = 0.0625,
    hideseat = 0.2,

    buttons = {
        {ID = "KU13Set", x=0, y=0, w=60,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-19, color = Color(255,255,255),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=9,ang=90,z=18.9,x=0,y=-25.5}},
            var="KU13",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "KU3Toggle", x=0, y=110, w=60,h=80, tooltip="", model = {
            model = "models/metrostroi_train/switches/vudblack.mdl", z=-19, color = Color(255,255,255),
            labels={{model="models/metrostroi_train/81-707/labels/vu_labels.mdl",skin=10,ang=90,z=18.9,x=0,y=-25.5}},
            var="KU3",speed=6,
            sndvol = 1, snd = function(val) return val and "vu224_on" or "vu224_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Unlocked","Train.Buttons.Locked"},
        }},
        {ID = "R_Program1HSet",  x=14, y=220, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=7,ang=90,z=2,x=0,y=-24}},
            var="R_Program1H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,
            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
        {ID = "R_Program2HSet",  x=44, y=220, radius=15, tooltip="",model = {
            model = "models/metrostroi_train/81-710/ezh3_button_black.mdl",z = -3,
            labels={{model="models/metrostroi_train/81-702/labels/vu_labels.mdl",skin=8,ang=90,z=2,x=0,y=-24}},
            var="R_Program2H",speed=16,vmin=1,vmax=0,
            sndvol = 0.07,snd = function(val) return val and "button1_on" or "button3_off" end,            sndmin = 60,sndmax = 1e3,sndang = Angle(-90,0,0),
        }},
    }
}

ENT.ButtonMap["HVMeters"] = {
    pos = Vector(460,-56,28.9),
    ang = Angle(0,-90-51.8,90),

    width = 66,
    height = 152,
    scale = 0.0625,

    buttons = {
        {ID = "!EnginesVoltage", x=0,y=0,w=66,h=72,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesVoltage"),ent:GetPackedRatio("EnginesVoltage")*1000) end},
        {ID = "!EnginesCurrent", x=0,y=79,w=66,h=72,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.EnginesCurrent"),ent:GetPackedRatio("EnginesCurrent")*1000-500) end},
    }
}

ENT.ButtonMap["BLTLPressure"] = {
    pos = Vector(460.5,-54,9.8),
    ang = Angle(0,-144,90),
    width = 114,
    height = 114,
    scale = 0.0625,

    buttons = {
        {ID = "!BLTLPressure", x=57,y=57,radius=57,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BLTLPressure"),ent:GetPackedRatio("TLPressure")*12,ent:GetPackedRatio("BLPressure")*12) end},
    }
}
ENT.ButtonMap["BCPressure"] = {
    pos = Vector(460.4,-49.5,3.5),
    ang = Angle(0,-90-20,90),

    width = 76,
    height = 76,
    scale = 0.0625,

    buttons = {
        {ID = "!BCPressure", x=38,y=38,radius=38,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BCPressure"),ent:GetPackedRatio("BCPressure")*6) end},
    }
}
ENT.ButtonMap["BatteryVoltage"] = {
    pos = Vector(463.4,-17.3,10.5),
    ang = Angle(0,267,90),
    width = 68,
    height = 68,
    scale = 0.0625,

    buttons = {
        {ID = "!BatteryVoltage", x=0,y=0,w=68,h=68,tooltip="",tooltipFunc = function(ent) return Format(Metrostroi.GetPhrase("Train.Buttons.BatteryVoltage"),ent:GetPackedRatio("BatteryVoltage")*150) end},
    }
}
ENT.ButtonMap["DriverValveBLDisconnect"] = {
    pos = Vector(450.50,-51,-36.5),
    ang = Angle(-90,0,0),
    width = 200,
    height = 100,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveBLDisconnectToggle", x=0, y=0, w=200, h=100, tooltip="", model = {
            var="DriverValveBLDisconnect",sndid="brake_disconnect",
            sndvol = 1, snd = function(val) return "disconnect_valve" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}
ENT.ButtonMap["DriverValveTLDisconnect"] = {
    pos = Vector(447+5,-46,-31),
    ang = Angle(-90,-10,0),
    width = 200,
    height = 90,
    scale = 0.0625,

    buttons = {
        {ID = "DriverValveTLDisconnectToggle", x=0, y=0, w=200, h=90, tooltip="", model = {
            var="DriverValveTLDisconnect",sndid="train_disconnect",
            sndvol = 1, snd = function(val) return val and "pneumo_TL_open" or "pneumo_TL_disconnect" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
            states={"Train.Buttons.Closed","Train.Buttons.Opened"},
        }},
    }
}

ENT.ButtonMap["FrontPneumatic"] = {
    pos = Vector(470,-45.0,-58.0),
    ang = Angle(0,90,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "FrontBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="FbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "FrontTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="FtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["FrontBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(450+19, -30, -68.5),
    ang = Angle(-15,-90,0),
    hide = 2,
}
ENT.ClientProps["FrontTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(450+19, 30.5, -68.5),
    ang = Angle( 15,-90,0),
    hide = 2,
}
ENT.ClientSounds["FrontBrakeLineIsolation"] = {{"FrontBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["FrontTrainLineIsolation"] = {{"FrontTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ButtonMap["RearPneumatic"] = {
    pos = Vector(-473,45.0,-58.0),
    ang = Angle(0,270,90),
    width = 900,
    height = 100,
    scale = 0.1,

    buttons = {
        {ID = "RearBrakeLineIsolationToggle",x=000, y=0, w=400, h=100, tooltip="",var="RbI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
        {ID = "RearTrainLineIsolationToggle",x=500, y=0, w=400, h=100, tooltip="",var="RtI",states={"Train.Buttons.Opened","Train.Buttons.Closed"}},
    }
}
ENT.ClientProps["RearTrain"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_blue.mdl",
    pos = Vector(-450-21, -30.5, -68.5),
    ang = Angle( 15,90,0),
    hide = 2,
}
ENT.ClientProps["RearBrake"] = {--
    model = "models/metrostroi_train/bogey/disconnect_valve_red.mdl",
    pos = Vector(-450-21, 30, -68.5),
    ang = Angle(-15,90,0),
    hide = 2,
}
ENT.ClientSounds["RearBrakeLineIsolation"] = {{"RearBrake",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}
ENT.ClientSounds["RearTrainLineIsolation"] = {{"RearTrain",function() return "disconnect_valve" end,1,1,50,1e3,Angle(-90,0,0)}}


ENT.ButtonMap["GV"] = {
    pos = Vector(170-3,50+20,-60),
    ang = Angle(0,225-15,90),
    width = 260,
    height = 260,
    scale = 0.1,
    buttons = {
        {ID = "GVToggle",x=0, y=0, w= 260,h = 260, tooltip="", model = {
            var="GV",sndid = "gv",
            sndvol = 0.8,sndmin = 80, sndmax = 1e3/3, sndang = Angle(-90,0,0),
            snd = function(val) return val and "gv_f" or "gv_b" end,
            states={"Train.Buttons.Disconnected","Train.Buttons.On"}
        }},
    }
}
ENT.ClientProps["gv"] = {
    model = "models/metrostroi/81-717/gv.mdl",
    pos = Vector(153.5-3,36+20,-78),
    ang = Angle(-90,90,-90),
    color = Color(150,255,255),
    hide = 0.5,
}
ENT.ClientProps["gv_wrench"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["gv"].pos,
    ang = Angle(-90,0,0),
    hide = 0.5,
}

ENT.ButtonMap["AirDistributor"] = {
    pos = Vector(-215,69,-60),
    ang = Angle(0,180,90),
    width = 170,
    height = 260,
    scale = 0.1,
    hideseat=0.1,
    hide=true,
    screenHide = true,

    buttons = {
        {ID = "AirDistributorDisconnectToggle",x=0, y=0, w= 170,h = 260, tooltip="",var="AD",states={"Train.Buttons.On","Train.Buttons.Off"}},
    }
}

-- UAVA
ENT.ButtonMap["UAVAPanel"] = {
    pos = Vector(453.5,56,-5),
    ang = Angle(0,-70,90),
    width = 180,
    height = 200,
    scale = 0.0625,

    buttons = {
        {ID = "UAVAToggle",x=0, y=0, w=60, h=200, tooltip="", model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
            var="UAVA",
            sndid="UAVALever",sndvol = 1, snd = function(val) return val and "uava_on" or "uava_off" end,
            sndmin=30, sndmax = 1e3, sndang = Angle(-90,0,0),
        }},
        {ID = "UAVACToggle",x=60, y=0, w=120, h=150, tooltip="",var="UAVAC",states={"Train.Buttons.UAVAOff","Train.Buttons.UAVAOn"}},
        {ID = "UKSDisconnectToggle",x=60, y=150, w=120, h=50, tooltip="",var="UKSDisconnect",states={"Train.Buttons.Closed","Train.Buttons.Opened"}, model = {
            plomb = {var="UAVAPl", ID="UAVAPl",},
        }},
    }
}


for i=0,3 do
    ENT.ClientProps["TrainNumberL"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,69,-26),
        ang = Angle(180,0,180),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
for i=0,3 do
    ENT.ClientProps["TrainNumberR"..i] = {
        model = "models/metrostroi_train/common/bort_numbers.mdl",
        pos = Vector(295+i*6.6-4*6.6/2,-66.4,-26),
        ang = Angle(0,0,0),
        skin=0,
        hide = 1.5,
        callback = function(ent)
            ent.WagonNumber = false
        end,
    }
end
ENT.ButtonMap["FrontDoor"] = {
    pos = Vector(468,17,41),
    ang = Angle(0,-90,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "FrontDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door1",sndid="door1",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["CabinDoor"] = {
    pos = Vector(417.5,64,41),
    ang = Angle(0,0,90),
    width = 642,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "CabinDoor",x=0,y=0,w=642,h=1900, tooltip="", model = {
            var="door4",sndid="door4",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor"] = {
    pos = Vector(384,-16,41),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door3",sndid="door3",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}

ENT.ButtonMap["PassengerDoor1"] = {
    pos = Vector(384,19,41),
    ang = Angle(0,-90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "PassengerDoor",x=0,y=0,w=700,h=1900, tooltip=""},
    }
}
ENT.ButtonMap["RearDoor"] = {
    pos = Vector(-470,-16,41),
    ang = Angle(0,90,90),
    width = 700,
    height = 1900,
    scale = 0.1/2,
    buttons = {
        {ID = "RearDoor",x=0,y=0,w=700,h=1900, tooltip="", model = {
            var="door2",sndid="door2",
            sndvol = 1, snd = function(val) return val and "cab_door_open" or "cab_door_close" end,
            sndmin=90, sndmax = 1e3, sndang = Angle(-90,0,0),
            noTooltip = true,
        }},
    }
}
--------------------------------------------------------------------------------
ENT.ClientPropsInitialized = false
if not ENT.ClientSounds["br_334"] then ENT.ClientSounds["br_334"] = {} end
table.insert(ENT.ClientSounds["br_334"],{"brake",function(ent,_,var) return "br_334_"..var end,1,1,50,1e3,Angle(-90,0,0)})
ENT.ClientProps["brake"] = {
    model = "models/metrostroi_train/81-703/cabin_cran_334.mdl",
    pos = Vector(456.55,-52.57,-4.4),
    ang = Angle(0,-133,0),
    hideseat = 0.2,
}
ENT.ClientProps["controller"] = {
    model = "models/metrostroi_train/81-502/kv_black.mdl",
    pos = Vector(457.85,-22.8,-6),
    ang = Angle(0,180+13,0),
    hideseat = 0.2,
}
ENT.ClientProps["reverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(0.3,0,-0.8),
    ang = Angle(180,90,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["rcureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = ENT.ClientProps["controller"].pos+Vector(-4.4,0,-1.5),
    ang = Angle(180,180-25,180),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}
ENT.ClientProps["krureverser"] = {
    model = "models/metrostroi_train/reversor/reversor_classic.mdl",
    pos = Vector(406.5,-22,-2.5),
    ang = Angle(-5,90,90),
    hideseat = 0.2,
    modelcallback = function(ent)
        return ent.HasGoldenReverser and "models/metrostroi_train/reversor/reversor_gold.mdl" or "models/metrostroi_train/reversor/reversor_classic.mdl"
    end,
}

ENT.ClientProps["brake_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran1.mdl",
    pos = Vector(449.90,-56.47,-33.9),
    ang = Angle(7,87,-90),
    hideseat = 0.2,
}
ENT.ClientProps["train_disconnect"] = {
    model = "models/metrostroi_train/81-707/cran3.mdl",
    pos = Vector(453.5,-51.8,-27.5),
    ang = Angle(7,79,-90),
    hideseat = 0.2,
}

ENT.ClientProps["parking_brake"] = {
    model = "models/metrostroi_train/81-703/cabin_parking.mdl",
    pos = Vector(456.72,35.5,-14.843545),
    ang = Angle(-90,7,0),
    hideseat = 0.2,
}

--------------------------------------------------------------------------------
ENT.ClientProps["train_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_nm.mdl",
    pos = Vector(457.98,-56.169998+0.1,4.80),
    ang = Angle(170.000000,-143.3,89),
    hideseat = 0.2,
}

ENT.ClientProps["brake_line"] = {
    model = "models/metrostroi_train/Equipment/arrow_e_tm.mdl",
    pos = Vector(457.96,-56.150002+0.1,4.79),
    ang = Angle(170.000000,-143.3,89),
    hideseat = 0.2,
}

ENT.ClientProps["brake_cylinder"] = {
    model = "models/metrostroi_train/Equipment/arrow_nm.mdl",
    pos = Vector(460.05,-51.7,1),
    ang = Angle(-110,70.55,-88.9),
    hideseat = 0.2,
}
----------------------------------------------------------------
ENT.ClientProps["voltmeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(458.265,-57.25,25.27),
    ang = Angle(-90.1,-51.75,0),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}
ENT.ClientProps["ampermeter"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(458.34,-57.19,20.65),
    ang = Angle(-90,-51.8,0),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}

ENT.ClientProps["volt1"] = {
    model = "models/metrostroi_train/81-710/ezh3_voltages.mdl",
    pos = Vector(463.26,-19.415,7.65),
    ang = Angle(-90.7,-2,0),
    bscale = Vector(1,1,1.3),
    hideseat = 0.2,
}
--------------------------------------------------------------------------------
--[[ENT.ClientProps["book"] = {
    model = "models/props_lab/binderredlabel.mdl",
    pos = Vector(401.763123,-32.429512,48.305576),
    ang = Angle(53,0,90),
}]]

ENT.ClientProps["salon"] = {
    model = "models/metrostroi_train/81-502/ema_salon_501.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["Ema_mirrors"] = {
    model = "models/metrostroi_train/81-707/mirrors_ezh.mdl",
    pos = Vector(2,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}
ENT.ClientProps["cabin"] = {
    model = "models/metrostroi_train/81-509/em509_cabine.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide=2,
}

ENT.ClientProps["sunprotectors"] = {
    model = "models/metrostroi_train/81-502/sun_protectors.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2.0,
}


ENT.ClientProps["asotp"] = {
    model = "models/metrostroi_train/81-707/asotp.mdl",
    pos = Vector(0,0,1),
    ang = Angle(0,0,0),
    hide = 2.0,
    }
ENT.ClientProps["underwagon"] = {
    model = "models/metrostroi_train/81-508/81-508_underwagon.mdl",
    pos = Vector(0.2,0,-18),
    ang = Angle(0,0,0),
    hide = 2.0,
}

ENT.ClientProps["Lamps_pult"] = {
    model = "models/metrostroi_train/equipment/lamp_gauges.mdl",
    pos = Vector(446.027,-55.398,42.27),
    ang = Angle(-4.305,6.175,8),
    hideseat = 0.2,
}
ENT.ClientProps["Lamps_emer1"] = {
    model = "models/metrostroi_train/81-502/lights_emer2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_emer2"] = {
    model = "models/metrostroi_train/81-502/lights_emer.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    --color=Color(255,255,255),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half1"] = {
    model = "models/metrostroi_train/81-502/lights_group1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_half2"] = {
    model = "models/metrostroi_train/81-502/light_group2_501.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 1.5,
}
ENT.ClientProps["Lamps_cab1"] = {
    model = "models/metrostroi_train/81-502/cabin_lamp_light.mdl",
    pos = Vector(0,-0.05,-0.2),
    ang = Angle(0,0,0),
    hide = 0.8,
}
ENT.ClientProps["Lamp_RTM"] = {
    model = "models/metrostroi_train/81-717/rtmlamp.mdl",
    pos = Vector(407.7,23.45,28.57),
    ang = Angle(0,180,0),
    scale=1.02
}

ENT.ClientProps["Drawers"] = {
    model = "models/metrostroi_train/81-509/em509_drawers.mdl",
    pos = Vector(-2,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}

ENT.ClientProps["GRP"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_rpgreen.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}

ENT.ClientProps["SN"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_sn.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}

ENT.ClientProps["RRP"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_rpred.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}

ENT.ClientProps["SD"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_sd.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}

ENT.ClientProps["UKS"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_uks.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}
--[[
ENT.ClientProps["PreviewLamps6"] = {
    model = "models/metrostroi_train/81-509/reflects/reflection_unnown.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hideseat=2,
}]]

ENT.ClientProps["tab"] = {
    model = "models/metrostroi_train/Equipment/tab.mdl",
    pos = Vector(16,0,8),
    ang = Angle(0,0,0),
    skin = 2,
    hide = 2,
}
ENT.ButtonMap["Route"] = {
    pos = Vector(465.7,35.3,2),
    ang = Angle(0,98,90),
    width = 153,
    height = 130,
    scale = 0.0625,
    buttons = {
        {ID = "RouteNumber1+",x=76.5*0,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2+",x=76.5*1,y=0, w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber1-",x=76.5*0,y=65,w=76.5,h=65, tooltip=""},
        {ID = "RouteNumber2-",x=76.5*1,y=65,w=76.5,h=65, tooltip=""},
    }
}
ENT.ClientProps["route"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_holder.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
}
ENT.ClientProps["route1"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number1.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}
ENT.ClientProps["route2"] = {
    model = "models/metrostroi_train/common/routes/ezh/route_number2.mdl",
    pos = Vector(0,0,0),
    ang = Angle(0,0,0),
    hide = 2,
    callback = function(ent)
        ent.RouteNumber.Reloaded = false
    end,
}

ENT.ClientProps["door0x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(344.692,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(110.668,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(-122.718,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x1"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(-356.091,65.305,-6.7),
    ang = Angle(0,-90,0),
    hide = 2.0,
}
ENT.ClientProps["door0x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos4.mdl",
    pos = Vector(344.692,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos3.mdl",
    pos = Vector(110.668,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door2x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos2.mdl",
    pos = Vector(-122.718,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door3x0"] = {
    model = "models/metrostroi_train/81-710/81-710_doors_pos1.mdl",
    pos = Vector(-356.091,-65.305+2.5,-6.7),
    ang = Angle(0,90,0),
    hide = 2.0,
}
ENT.ClientProps["door1"] = {
    model = "models/metrostroi_train/81-710/ezh3_door_noars_with_marshrut.mdl",
    pos = Vector(460.62+7.4,-14.53,-7),
    ang = Angle(0,-90,0),
    hide = 2,
    callback = function(ent)
        ent.LastStation.Reloaded = false
    end,
}
ENT.ButtonMap["LastStation"] = {
    pos = Vector(460.62+7.4,-14.53,2),
    ang = Angle(0,90,90),
    width = 500,
    height = 150,
    scale = 0.0625,
    buttons = {
        {ID = "LastStation-",x=000,y=0,w=250,h=150, tooltip=""},
        {ID = "LastStation+",x=250,y=0,w=250,h=150, tooltip=""},
    }
}

ENT.ClientProps["door2"] = {
    model = "models/metrostroi_train/81-710/81-710_door_tor.mdl",
    pos = Vector(-462.6-8,16.53,-7.24),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door3"] = {
    model = "models/metrostroi_train/81-710/81-710_door_interior_a.mdl",
    pos = Vector(382.3+18,-15,-8.1),
    ang = Angle(0,90,0),
    hide = 2,
}
ENT.ClientProps["door4"] = {
    model = "models/metrostroi_train/81-710/81-710_door_cab.mdl",
    pos = Vector(411.17+7.6,66.05,-6),
    ang = Angle(0,-90,0),
    hide = 2,
}
ENT.ClientProps["UAVALever"] = {
    model = "models/metrostroi_train/81-703/cabin_uava.mdl",
    pos = Vector(449+7.7,56.0,-10.24349),
    ang = Angle(0,-90+10,0),
    hideseat = 0.8,
}

ENT.ClientProps["RedLights"] = {
    model = "models/metrostroi_train/81-703/81-703_red_light.mdl",
    pos = Vector(-23+7.2,1,-191),
    ang = Angle(0,0,0.000000),
    nohide=true,
}
ENT.ClientProps["DistantLights"] = {
    model = "models/metrostroi_train/81-703/81-703_projcetor_light.mdl",
    pos = Vector(-23+8.0,1,-191),
    ang = Angle(00.000000,0.000000,0.000000),
    nohide=true,
}
ENT.ClientProps["WhiteLights"] = {
    model = "models/metrostroi_train/81-703/81-703_front_light.mdl",
    pos = Vector(-23+7.6,1,-191),
    ang = Angle(0,0,0),
    nohide=true,
}


ENT.Lights = {
    [1] = { "headlight",        Vector(470,0,-35), Angle(0,0,0), Color(200,130,88), brightness = 4 , fov=95, texture = "models/metrostroi_train/equipment/headlight",shadows = 1,headlight=true},
    [2] = { "headlight",        Vector(460,0,45), Angle(-20,0,0), Color(255,0,0), fov=164 ,brightness = 0.3, farz=250,texture = "models/metrostroi_train/equipment/headlight2",shadows = 0,backlight=true},
    [21] = { "headlight",       Vector(445,-55,41), Angle(75, 70,45), Color(190, 130, 88), fov=135, farz=90, brightness = 1.5, shadows = 1, texture = "models/metrostroi_train/equipment/headlight", hidden = "Lamps_pult"},
    [22] = { "headlight",       Vector(445,-55.0,32.2), Angle(0,0,0), Color(255,130,88), fov=125, farz=65,brightness = 1.5,shadows = 0, texture = "models/metrostroi_train/equipment/headlight", hidden = "Lamps_pult"},
    --[24] = { "headlight",       Vector(442,-53.0,-0.2), Angle(75,0,0), Color(255,130,88), fov=90, farz=65,brightness = 2,shadows = 0},
    [40] = { "headlight",       Vector(457.80,-37.3,-5.3),Angle(45,-40,120) , Color(255,125,25), farz = 6, nearz = 1, shadows = 0, brightness = 16, fov = 80, hidden = "cabin"},
    [41] = { "headlight",       Vector(457.80,-42.6,-5.3),Angle(45,40,120) , Color(255,125,25), farz = 6, nearz = 1, shadows = 0, brightness = 16, fov = 80, hidden = "cabin"},

    -- Emergency lit
    [9] = { "dynamiclight",    Vector(200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 3, distance = 200},
    [10] = { "dynamiclight",    Vector(-150, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 3, distance = 200},
    [11] = { "dynamiclight",    Vector( 200, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},
    [12] = { "dynamiclight",    Vector(   0, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},
    [13] = { "dynamiclight",    Vector(-260, 0, -5), Angle(0,0,0), Color(255, 176, 59), brightness = 4, distance = 260},
    -- Cabin
    [23] = { "dynamiclight",        Vector(425,0,40),  Angle(0,0,0), Color(252, 157, 77), brightness = 0.0007, distance = 600, hidden = "cabin"},

    [5] =   { "light",           Vector(465+5,-32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [6] =   { "light",           Vector(465+5, 32, 48), Angle(0,0,0), Color(255,50,50),     brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [30]  = { "light",           Vector(465+5  ,   -45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [31]  = { "light",           Vector(465+5  ,   45, -37), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 1.5, texture = "sprites/light_glow02", size = 2 },
    [32]  = { "light",           Vector(465+5  ,   0, 48), Angle(0,0,0), Color(255,220,180), brightness = 0.2, scale = 2.5, texture = "sprites/light_glow02", size = 2 },

    Lamps_pult = {"light", Vector(445.8,-55.5,42), Angle(0,0,0),Color(255,220,180),brightness = 0.35,scale = 0.4, texture = "sprites/light_glow02", hidden = "Lamps_pult"},
    Lamps_cab = {"light", Vector(404,1.2,56), Angle(0,0,0),Color(255,220,180),brightness = 0.25,scale = 0.3, texture = "sprites/light_glow02", hidden = "Lamps_cab1"},
    Lamp_RTM = {"light", Vector(407.7,23.45,28.57), Angle(0,0,0),Color(255,180,60),brightness = 0.4,scale = 0.03, texture = "sprites/light_glow02", hidden = "Lamp_RTM"},
}

function ENT:Initialize()
    self.BaseClass.Initialize(self)

    self.FrontLeak = 0
    self.RearLeak = 0

    --self.Train:SetPackedRatio("EmergencyValve_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyValveEPK_dPdT", leak)
    --self.Train:SetPackedRatio("EmergencyBrakeValve_dPdT", leak)
    self.ASNP = self:CreateRT("710ASNP",512,128)
    self.IGLA = self:CreateRT("710IGLA",512,128)
    self.RRIScreen = self:CreateRT("710RRI",128,128)
    self.CraneRamp = 0
    self.ReleasedPdT = 0
    self.EmergencyValveRamp = 0
    self.EmergencyValveEPKRamp = 0
    self.EmergencyBrakeValveRamp = 0
end

function ENT:UpdateWagonNumber()
    for i=0,3 do
        local leftNum,rightNum = self.ClientEnts["TrainNumberL"..i],self.ClientEnts["TrainNumberR"..i]
        local num = math.floor(self.WagonNumber%(10^(i+1))/10^i)
        if IsValid(leftNum) then
            leftNum:SetPos(self:LocalToWorld(Vector(295+i*6.6-4*6.6/2,69,-26)))
            leftNum:SetSkin(num)
        end
        if IsValid(rightNum) then
            rightNum:SetPos(self:LocalToWorld(Vector(-280-i*6.6-4*6.6/2,-66.6,-26)))
            rightNum:SetSkin(num)
        end
    end
end

--------------------------------------------------------------------------------
function ENT:Think()
    self.BaseClass.Think(self)
    if not self.RenderClientEnts or self.CreatingCSEnts then
        return
    end

    local typ = self:GetNW2Int("AnnType",1)
    self:HidePanel("RRI",typ~=1)
    self:HidePanel("RRIScreen",typ~=1 or self.CurrentCamera ~= 7)
    self:ShowHide("E_informator",typ==1)
    self:HidePanel("ASNP",typ~=2)
    self:HidePanel("ASNPScreen",typ~=2)
    self:HidePanel("IGLAButtons",typ~=2)
    self:HidePanel("IGLA",typ~=2)
    self:ShowHide("asotp",typ==2)

    -- Parking brake animation
    self.TrueBrakeAngle = self.TrueBrakeAngle or 0
    self.TrueBrakeAngle = self.TrueBrakeAngle + (self:GetPackedRatio("ManualBrake")*360*3.2 - self.TrueBrakeAngle)*2.0*(self.DeltaTime or 0)
    if self.ClientEnts and self.ClientEnts["parking_brake"] then
        self.ClientEnts["parking_brake"]:SetPoseParameter("position",1.0-((self.TrueBrakeAngle % 360)/360))
    end
    local BAsnd = math.floor(self.TrueBrakeAngle/10)
    if self.BrakeAngleSND ~= BAsnd then
        if not IsValid(self.Sounds["parking_brake_rolling"]) or self.Sounds["parking_brake_rolling"]:GetState() ~= GMOD_CHANNEL_PLAYING then
            self:PlayOnce("parking_brake_rolling","bass",1,1)
        end
        self.BrakeAngleSND = BAsnd
    end

    self:ShowHideSmooth("ars_indicator",self:Animate("L_ARS",self:GetPackedBool("L_ARS") and 1 or 0,0,1,5,false))

    local HL1 = self:Animate("whitelights",self:GetPackedBool("HeadLights1") and 1 or 0,0,1,5,false)
    local HL2 = self:Animate("distantlights",self:GetPackedBool("HeadLights2") and 1 or 0,0,1,5,false)
    local RL = self:Animate("redlights",self:GetPackedBool("RedLight") and 1 or 0,0,1,5,false)

    self:ShowHideSmooth("WhiteLights",HL1)
    self:ShowHideSmooth("DistantLights",HL2)
    self:ShowHideSmooth("RedLights",RL)
    self:SetLightPower(5,RL > 0,RL)
    self:SetLightPower(6,RL > 0,RL)
    self:SetLightPower(30,HL1 > 0, HL1)
    self:SetLightPower(31,HL1 > 0, HL1)
    self:SetLightPower(32,HL2 > 0, HL2)

    local bright = HL1*0.3+HL2*0.7
    self:SetLightPower(1,bright>0,bright)
    self:SetLightPower(2,RL>0,RL)

    local PL = HL1*self:Animate("lamps_pult",self:GetPackedBool("PanelLights") and 1 or 0,0,1,12,false)
    self:ShowHideSmooth("Lamps_pult",PL)
    self:SetLightPower("Lamps_pult",PL>0,PL)
    self:SetLightPower(21,PL>0,PL)
    self:SetLightPower(22,PL>0,PL)


    if IsValid(self.GlowingLights[1]) then
        if not self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 3144 then
            self.GlowingLights[1]:SetFarZ(3144)
        end
        if self:GetPackedBool("HeadLights1") and self.GlowingLights[1]:GetFarZ() ~= 5144 then
            self.GlowingLights[1]:SetFarZ(5144)
        end
    end

    self:ShowHideSmoothFrom("GRP","!GRP_lamp")
    self:ShowHideSmoothFrom("SN","!LSN_lamp")
    self:ShowHideSmoothFrom("RRP","!RRP_lamp")
    self:ShowHideSmoothFrom("SD","!SD_lamp")
    self:ShowHideSmoothFrom("UKS","!UKS_lamp")

    self:ShowHide("Speed1",self:GetPackedBool("V1"))
    self:ShowHide("Speed2",self:GetPackedBool("V1"))
    local speed = self:GetPackedRatio("Speed")*100.0
    if self:GetPackedBool("V1") then
        if IsValid(self.ClientEnts["Speed1"])then self.ClientEnts["Speed1"]:SetSkin(math.floor(speed)%10) end
        if IsValid(self.ClientEnts["Speed2"])then self.ClientEnts["Speed2"]:SetSkin(math.floor(speed/10)) end
    end

    local Lamps = self:GetPackedRatio("LampsStrength")

    local emer1 = self:Animate("lamps_emer1",self:GetPackedBool("Lamps_emer1") and 1 or 0,0,1,5,false)
    local cab = self:Animate("lamps_cab",self:GetPackedBool("Lamps_cab") and 1 or 0,0,1,5,false)
    local emer2 = self:Animate("lamps_emer2",self:GetPackedBool("Lamps_emer2") and 1 or 0,0,1,5,false)
    local half1 = self:Animate("lamps_half1",self:GetPackedBool("Lamps_half1") and 0.4+Lamps*0.6 or 0,0,1,5,false)
    local half2 = self:Animate("lamps_half2",self:GetPackedBool("Lamps_half2") and 0.4+Lamps*0.6 or 0,0,1,5,false)

    self:ShowHideSmooth("Lamps_emer1",emer1)
    self:ShowHideSmooth("Lamps_cab1",cab)
    self:ShowHideSmooth("Lamps_emer2",emer2)
    self:ShowHideSmooth("Lamps_half1",half1,Color(255,105+half1*150,105+half1*150))
    self:ShowHideSmooth("Lamps_half2",half2,Color(255,105+half2*150,105+half2*150))
    self:SetLightPower(23, cab > 0,cab)
    self:SetLightPower("Lamps_cab", cab > 0,cab)
    if not self:GetPackedBool("Lamps_half1") then
        self:SetLightPower(9,emer1 > 0,emer1*0.2+emer2*0.8)
        self:SetLightPower(10,emer2 > 0,emer2)
        self:SetLightPower(11, false)
        self:SetLightPower(12, false)
        self:SetLightPower(13, false)
    else
        self:SetLightPower(9,false)
        self:SetLightPower(10,false)
        self:SetLightPower(11, half1 > 0, half1*0.1+half2*0.9)
        self:SetLightPower(12, half1 > 0, half1*0.4+half2*0.6)
        self:SetLightPower(13, half1 > 0, half1*0.9+half2*0.1)
    end
    ---PB
    self:Animate("PB",self:GetPackedBool("PB") and 1 or 0,0,0.2,  12,false)

    self:Animate("UAVALever",   self:GetPackedBool("UAVA") and 1 or 0,     0,0.6, 128,  3,false)
    self:Animate("brake_disconnect",self:GetPackedBool("DriverValveBLDisconnect") and 1 or 0,0.5,0.25,  4,false)
    self:Animate("train_disconnect",self:GetPackedBool("DriverValveTLDisconnect") and 1 or 0,0.5,0.25,  4,false)
    self:Animate("EPK_disconnect",self:GetPackedBool("EPK") and 1 or 0,0.5,0.25,  3,false)
    self:Animate("stopkran", self:GetPackedBool("EmergencyBrakeValve") and 1 or 0,0,0.25, 7, false)

    -- Simulate pressure gauges getting stuck a little
    self:Animate("brake", self:GetPackedRatio("CranePosition"), 0.00, 0.48,256,24)
    self:Animate("controller",self:GetPackedRatio("ControllerPosition"),0, 0.31,  2,false)
    self:Animate("reverser",self:GetPackedRatio("ReverserPosition"),0.6, 0.4,  4,false)
    self:Animate("rcureverser",self:GetPackedBool("RCUPosition") and 1 or 0,0.77,0,3,false)
    self:Animate("krureverser",self:GetPackedRatio("KRUPosition"),0.5,1,3,false)
    self:Animate("volt1", self:GetPackedRatio("BatteryVoltage")^0.99,0.624,0.385,45,3)

    self:ShowHide("reverser",self:GetNW2Int("WrenchMode",0)==1)
    self:ShowHide("krureverser",self:GetNW2Int("WrenchMode",0)==2)
    self:ShowHide("rcureverser",self:GetNW2Int("WrenchMode",0)==3)



    ---Animate brakes
    self:Animate("brake_line",self:GetPackedRatio("BLPressure"),0.631, 0.795,  256,2)--,,0.01)
    self:Animate("train_line",self:GetPackedRatio("TLPressure"),0.631, 0.795,  256,2)--,,0.01)
    self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure")^0.95,0.085, 0.81,  256,2)--,,0.03)
    --[[self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"), 0, 0.743,  32,1)--,,0.03)
    local anim = self:Animate("brake_cylinder",self:GetPackedRatio("BCPressure"), 0, 0.743,  2048,6)--,,0.03)
    self.BrakeCylinder = self.BrakeCylinder or 0.5
    self.BrakeCylinder = math.Clamp(self.BrakeCylinder + (anim-self.BrakeCylinder)*self.DeltaTime*5 - math.min(0,(self.BrakeCylinder-anim)*math.Rand(0,1)*10)*(self.DeltaTime*33),0,1)]]
    self:Animate("voltmeter",self:GetPackedRatio("EnginesVoltage"),0.62,0.385,92,2)
    self:Animate("ampermeter",self:GetPackedRatio("EnginesCurrent"),0.63,0.373,92,2)


    local door2 = self:Animate("door2", self:GetPackedBool("RearDoor") and 0.99 or 0,0,0.25, 8, 1)
    local door1 = self:Animate("door1", self:GetPackedBool("FrontDoor") and 0.99 or 0,0,0.22, 8, 1)
    local door3 = self:Animate("door3", self:GetPackedBool("PassengerDoor") and 0.99 or 0,1,0.62, 8, 1)
    local door4 = self:Animate("door4", self:GetPackedBool("CabinDoor") and 0.99 or 0,1,0.78, 8, 1)

    if self.Door1 ~= (door1 > 0) then
        self.Door1 = door1 > 0
        self:PlayOnce("door1","bass",self.Door1 and 1 or 0)
    end
    if self.Door2 ~= (door2 > 0) then
        self.Door2 = door2 > 0
        self:PlayOnce("door2","bass",self.Door2 and 1 or 0)
    end
    if self.Door3 ~= (door3 < 1) then
        self.Door3 = door3 < 1
        self:PlayOnce("door3","bass",self.Door3 and 1 or 0)
    end
    if self.Door4 ~= (door4 < 1) then
        self.Door4 = door4 < 1
        self:PlayOnce("door4","bass",self.Door4 and 1 or 0)
    end

    self:Animate("FrontBrake", self:GetNW2Bool("FbI") and 0 or 1,0,1, 3, false)
    self:Animate("FrontTrain",  self:GetNW2Bool("FtI") and 1 or 0,0,1, 3, false)
    self:Animate("RearBrake",   self:GetNW2Bool("RbI") and 0 or 1,0,1, 3, false)
    self:Animate("RearTrain",   self:GetNW2Bool("RtI") and 1 or 0,0,1, 3, false)

    -- Main switch
    if self.LastGVValue ~= self:GetPackedBool("GV") then
        self.ResetTime = CurTime()+1.5
        self.LastGVValue = self:GetPackedBool("GV")
    end
    self:Animate("gv_wrench",self.LastGVValue and 1 or 0,0.5,0.9,128,1,false)
    self:ShowHideSmooth("gv_wrench",    CurTime() < self.ResetTime and 1 or 0.1)

    -- Animate doors
    if not self.DoorStates then self.DoorStates = {} end
    if not self.DoorLoopStates then self.DoorLoopStates = {} end
    for i=0,3 do
        for k=0,1 do
            local st = k==1 and "DoorL" or "DoorR"
            local doorstate = self:GetPackedBool(st)
            local id,sid = st..(i+1),"door"..i.."x"..k
            local state = self:GetPackedRatio(id)
            --print(state,self.DoorStates[state])
            if (state ~= 1 and state ~= 0) ~= self.DoorStates[id] then
                if doorstate and state < 1 or not doorstate and state > 0 then
                else
                    if state > 0 then
                        self:PlayOnce(sid.."o","",1,math.Rand(0.8,1.2))
                    else
                        self:PlayOnce(sid.."c","",1,math.Rand(0.8,1.2))
                    end
                end
                self.DoorStates[id] = (state ~= 1 and state ~= 0)
            end
            if (state ~= 1 and state ~= 0) then
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) + 2*self.DeltaTime,0,1)
            else
                self.DoorLoopStates[id] = math.Clamp((self.DoorLoopStates[id] or 0) - 6*self.DeltaTime,0,1)
            end
            self:SetSoundState(sid.."r",self.DoorLoopStates[id],0.8+self.DoorLoopStates[id]*0.2)
            local n_l = "door"..i.."x"..k--.."a"
            --local n_r = "door"..i.."x"..k.."b"
            local dlo = 1
            --local dro = 1
            if self.Anims[n_l] then
                dlo = math.abs(state-(self.Anims[n_l] and self.Anims[n_l].oldival or 0))
                if dlo <= 0 and self.Anims[n_l].oldspeed then
                    dlo = self.Anims[n_l].oldspeed/14
                end
            end
            self:Animate(n_l,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
            --self:Animate(n_r,state,0,1, dlo*14,false)--0.8 + (-0.2+0.4*math.random()),0)
        end
    end


    -- Brake-related sounds
    local dT = self.DeltaTime
    --self.TunnelCoeff = 0.8
    --self.StreetCoeff = 0
    local rollingi = math.min(1,self.TunnelCoeff+math.Clamp((self.StreetCoeff-0.82)/0.3,0,1))
    local rollings = math.max(self.TunnelCoeff*1,self.StreetCoeff)
    --if self:EntIndex() == 3239 then LocalPlayer():ChatPrint(Format("T: %.2f, S: %.2f",rollingi,rollings)) end
    -- Brake-related sounds
    local dT = self.DeltaTime
    local rol5 = math.Clamp(speed/1,0,1)*(1-math.Clamp((speed-3)/8,0,1))
    local rol10 = math.Clamp(speed/12,0,1)*(1-math.Clamp((speed-25)/8,0,1))
    local rol40p = Lerp((speed-25)/12,0.6,1)
    local rol40 = math.Clamp((speed-23)/8,0,1)*(1-math.Clamp((speed-55)/8,0,1))
    local rol40p = Lerp((speed-23)/50,0.6,1)
    local rol70 = math.Clamp((speed-50)/8,0,1)*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp(0.8+(speed-65)/25*0.2,0.8,1.2)
    local rol80 = math.Clamp((speed-70)/5,0,1)
    local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_5",math.min(1,rollingi*(1-rollings)+rollings*0.8)*rol5,1)
    self:SetSoundState("rolling_10",rollingi*rol10,1)
    self:SetSoundState("rolling_40",rollingi*rol40,rol40p)
    self:SetSoundState("rolling_70",rollingi*rol70,rol70p)
    self:SetSoundState("rolling_80",rollingi*rol80,rol80p)

    local rol_motors = math.Clamp((speed-20)/40,0,1)
    self:SetSoundState("rolling_motors",math.max(rollingi,rollings*0.3)*rol_motors,speed/56)

    local rol10 = math.Clamp(speed/15,0,1)*(1-math.Clamp((speed-18)/35,0,1))
    local rol10p = Lerp((speed-15)/14,0.6,0.78)
    local rol40 = math.Clamp((speed-18)/35,0,1)*(1-math.Clamp((speed-55)/40,0,1))
    local rol40p = Lerp((speed-15)/66,0.6,1.3)
    local rol70 = math.Clamp((speed-55)/20,0,1)--*(1-math.Clamp((speed-72)/5,0,1))
    local rol70p = Lerp((speed-55)/27,0.78,1.15)
    --local rol80 = math.Clamp((speed-70)/5,0,1)
    --local rol80p = Lerp(0.8+(speed-72)/15*0.2,0.8,1.2)
    self:SetSoundState("rolling_low"    ,rol10*rollings,rol10p) --15
    self:SetSoundState("rolling_medium2",rol40*rollings,rol40p) --57
    --self:SetSoundState("rolling_medium1",0 or rol40*rollings,rol40p) --57
    self:SetSoundState("rolling_high2"  ,rol70*rollings,rol70p) --70

    self.ReleasedPdT = math.Clamp(self.ReleasedPdT + 2*(-self:GetPackedRatio("BrakeCylinderPressure_dPdT",0)-self.ReleasedPdT)*dT,0,1)
    local release1 = math.Clamp((self.ReleasedPdT-0.1)/0.8,0,1)^2
    self:SetSoundState("release1",release1,1)
    self:SetSoundState("release2",(math.Clamp(0.3-release1,0,0.3)/0.3)*(release1/0.3),1.0)

    self.FrontLeak = math.Clamp(self.FrontLeak + 10*(-self:GetPackedRatio("FrontLeak")-self.FrontLeak)*dT,0,1)
    self.RearLeak = math.Clamp(self.RearLeak + 10*(-self:GetPackedRatio("RearLeak")-self.RearLeak)*dT,0,1)
    self:SetSoundState("front_isolation",self.FrontLeak,0.9+0.2*self.FrontLeak)
    self:SetSoundState("rear_isolation",self.RearLeak,0.9+0.2*self.RearLeak)

    self.CraneRamp = math.Clamp(self.CraneRamp + 8.0*((1*self:GetPackedRatio("Crane_dPdT",0))-self.CraneRamp)*dT,-1,1)
    self:SetSoundState("crane334_brake_low",math.Clamp((-self.CraneRamp)*2,0,1)^2,1)
    local high = math.Clamp(((-self.CraneRamp)-0.5)/0.5,0,1)^1
    self:SetSoundState("crane334_brake_high",high,1.0)
    self:SetSoundState("crane013_brake2",high*2,1.0)
    self:SetSoundState("crane334_brake_eq_high",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.2,0,1)^0.8*1,1)
    self:SetSoundState("crane334_brake_eq_low",--[[ math.Clamp(-self.CraneRamp*0,0,1)---]] math.Clamp(-self:GetPackedRatio("ReservoirPressure_dPdT")-0.4,0,1)^0.8*1.3,1)

    self:SetSoundState("crane334_release",math.Clamp(self.CraneRamp,0,1)^2,1.0)

    local emergencyBrakeValve = self:GetPackedRatio("EmergencyBrakeValve_dPdT", 0)
    self.EmergencyBrakeValveRamp = math.Clamp(self.EmergencyBrakeValveRamp + (emergencyBrakeValve-self.EmergencyBrakeValveRamp)*dT*8,0,1)
    self:SetSoundState("valve_brake",self.EmergencyBrakeValveRamp,0.8+self.EmergencyBrakeValveRamp*0.4)

    local emergencyValve = self:GetPackedRatio("EmergencyValve_dPdT", 0)^0.4*1.2
    self.EmergencyValveRamp = math.Clamp(self.EmergencyValveRamp + (emergencyValve-self.EmergencyValveRamp)*dT*16,0,1)
    local emer_brake = math.Clamp((self.EmergencyValveRamp-0.9)/0.05,0,1)
    local emer_brake2 = math.Clamp((self.EmergencyValveRamp-0.2)/0.4,0,1)*(1-math.Clamp((self.EmergencyValveRamp-0.9)/0.1,0,1))
    self:SetSoundState("emer_brake",emer_brake,1)
    self:SetSoundState("emer_brake2",emer_brake2,math.min(1,0.8+0.2*emer_brake2))

    local emergencyValveEPK = self:GetPackedRatio("EmergencyValveEPK_dPdT",0)
    self.EmergencyValveEPKRamp = math.Clamp(self.EmergencyValveEPKRamp + 1.0*((0.5*emergencyValveEPK)-self.EmergencyValveEPKRamp)*dT,0,1)
    if self.EmergencyValveEPKRamp < 0.01 then self.EmergencyValveEPKRamp = 0 end
    self:SetSoundState("epk_brake",self.EmergencyValveEPKRamp,1.0)

    -- Compressor
    local compressorvoltage = Lerp(self:GetPackedRatio("LampsStrength"),0.75,1.05)
    local compressorb = self:GetPackedBool("AV") and compressorvoltage or 1
    local compressorspeed = self:GetPackedBool("VB") and compressorb or 0
    local state = self:GetPackedBool("Compressor")
    self:SetSoundState("compressor",state and 0.6 or 0,compressorspeed or 0)


    -- ARS/ringer alert
    self:SetSoundState("ring",self:GetPackedBool("Ring") and 1 or 0,1)

    self:ShowHideSmooth("Lamp_RTM",self:Animate("lamps_rtm",self:GetPackedBool("VPR") and 1 or 0,0,1,8,false))
    self:SetSoundState("vpr",self:GetPackedBool("VPR") and 1 or 0,1)

    -- RK rotation
    if self:GetPackedBool("RK") then self.RKTimer = CurTime() end
    state = (CurTime() - (self.RKTimer or 0)) < 0.2
    self.PreviousRKState = self.PreviousRKState or false
    if self.PreviousRKState ~= state then
        self.PreviousRKState = state
        if state then
            self:SetSoundState("rk",0.7,1)
        else
            self:SetSoundState("rk",0,0)
        end
    end

    local work = self:GetPackedBool("AnnPlay")
    local noise = self:GetNW2Int("AnnouncerBuzz",-1) > 0
    self.NoiseVolume = self.NoiseVolume or 0
    self.AnnLamp = self.AnnLamp or 0
    local noisevolume = 1
    if self.Sounds["announcer1"] and IsValid(self.Sounds["announcer1"]) then noisevolume = (1-(self.Sounds["announcer1"]:GetLevel())*math.Rand(0.9,3))*1 end
    if self.NoiseVolume > noisevolume then
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 8*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    else
        self.NoiseVolume = math.Clamp(self.NoiseVolume + 0.5*(noisevolume-self.NoiseVolume)*dT,0.1,1)
    end
    local annvolume = self.Sounds.announcer1 and IsValid(self.Sounds.announcer1) and self.Sounds.announcer1:GetLevel()*math.Rand(0.9,3) or 0

    local lamp = math.max(annvolume,noise and self.NoiseVolume or 0)

    self.AnnLamp = math.Clamp(self.AnnLamp + 8*(lamp-self.AnnLamp)*dT,0,1)
    if self.AnnLamp < 0.01 then self.AnnLamp=0 end
    for k,v in ipairs(self.AnnouncerPositions) do
        for i=1,2 do
            self:SetSoundState(Format("announcer_noise%d_%d",i,k),noise and self.NoiseVolume*(v[3] or 1) or 0,1)
        end
        if IsValid(self.Sounds["announcer"..k]) then self.Sounds["announcer"..k]:SetVolume(work and (v[3] or 1) or 0) end
    end
end

function ENT:OnAnnouncer(volume)
    return self:GetPackedBool("AnnPlay") and volume  or 0
end

function ENT:Draw()
    self.BaseClass.Draw(self)
end
function ENT:DrawPost()
    self.RTMaterial:SetTexture("$basetexture", self.ASNP)
    self:DrawOnPanel("ASNPScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64,512,128,0)
    end)

    self.RTMaterial:SetTexture("$basetexture", self.IGLA)
    self:DrawOnPanel("IGLA",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(256,64+22,512,128+22,0)
    end)

    self:DrawOnPanel("AirDistributor",function()
        draw.DrawText(self:GetNW2Bool("AD") and "Air Distributor ON" or "Air Distributor OFF","Trebuchet24",0,0,Color(0,0,0,255))
    end)
    self.RTMaterial:SetTexture("$basetexture", self.RRIScreen)
    self:DrawOnPanel("RRIScreen",function(...)
        surface.SetMaterial(self.RTMaterial)
        surface.SetDrawColor(255,255,255)
        surface.DrawTexturedRectRotated(64,64,128,128,0)
    end)
end

function ENT:OnButtonPressed(button)
    if button == "PrevSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
    if button == "NextSign" then
        self.InfoTableTimeout = CurTime() + 2.0
    end

    if button and button:sub(1,3) == "Num" then
        self.InfoTableTimeout = CurTime() + 2.0
    end
end

function ENT:OnPlay(soundid,location,range,pitch)
    if location == "stop" then
        if IsValid(self.Sounds[soundid]) then
            self.Sounds[soundid]:Pause()
            self.Sounds[soundid]:SetTime(0)
        end
        return
    end
    if location == "bass" then
        if soundid == "VDOL" then
            return range > 0 and "vdol_on" or "vdol_off",location,1,pitch
        end
        if soundid == "VDOP" then
            return range > 0 and "vdor_on" or "vdor_off",location,1,pitch
        end
        if soundid == "VDZ" then
            return range > 0 and "vdz_on" or "vdz_off",location,1,pitch
        end
        if soundid:sub(1,4) == "IGLA" then
            return range > 0 and "igla_on" or "igla_off",location,1,pitch
        end
        if soundid == "LK2" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk2_on" or "lk2_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK3" then
            local speed = self:GetPackedRatio("Speed")
            local id = range > 0 and "lk3_on" or "lk3_off"
            self.SoundPositions[id][1] = 350-Lerp(speed/0.1,0,250)
            return id,location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "LK1" and range > 0 then
            local speed = self:GetPackedRatio("Speed")
            self.SoundPositions["lk5_on"][1] = 440-Lerp(speed/0.1,0,330)
            return "lk5_on",location,1-Lerp(speed/10,0.2,0.8),pitch
        end
        if soundid == "RVT" then
            return range > 0 and "rvt_on" or "rvt_off",location,1,pitch
        end
        if soundid == "K6" then
            return range > 0 and "k6_on" or  nil,location,1,pitch
        end
        if soundid == "RV2" then
            return range > 0 and "r1_5_on" or "r1_5_off",location,1,pitch
        end
        if soundid == "RPB" then
            return range > 0 and "rpb_on" or "rpb_off",location,1,pitch
        end
        if soundid == "KD" then
            return range > 0 and "kd_on" or "kd_off",location,1,pitch
        end
        if soundid == "KK" then
            return range > 0 and "kk_on" or "kk_off",location,1,pitch--0.8
        end
        if soundid == "K25" then
            return range > 0 and "k25_on" or "k25_off",location,1,pitch
        end
        if soundid == "RO" then
            return range > 0 and "ro_on" or "ro_off",location,1,0.8
        end
        if soundid == "Rp8" then
            return range > 0 and "rp8_on" or "rp8_off",location,1,pitch
        end
        if soundid == "ROT" then
            return range > 0 and "rot_on" or "rot_off",location,1,pitch
        end
        if soundid == "AVU" then
            return range > 0 and "avu_on" or "avu_off",location,1,0.9
        end
        if soundid == "brake" then
            self:PlayOnce("brake_f",location,range,pitch)
            self:PlayOnce("brake_b",location,range,pitch)
            return
        end
        if soundid == "UAVAC" then
            return "uava_reset",location,range,pitch
        end
    end
    return soundid,location,range,pitch
end


local dist = {
    Back1 = 550,
    AVMain = 550,
    AV1 = 550,
    AV2 = 550,
    Battery = 550,
}
for id,panel in pairs(ENT.ButtonMap) do
    if not panel.buttons then continue end
    for k,v in pairs(panel.buttons) do
        if v.model then
            local dist = dist[id] or 150
            if v.model.model then
                v.model.hideseat=dist
            elseif v.model.lamp then
                v.model.lamp.hideseat=dist
            end
        end
    end
end
Metrostroi.GenerateClientProps()
