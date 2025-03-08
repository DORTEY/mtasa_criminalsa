Vehicle={
    SellPercentage=75,

    PayNSpray={
        Locations={--garageID, x,y,z,type,size
            {19, -1904.3,285.5,40.1,"cylinder",4},--SF Downtown
            {36, 1976.6,2162.4,10.2,"cylinder",4},--LV Redsands East
            {41, -99.8,1118.4,19.3,"cylinder",4},--Fort Carson
            {8, 2062.8,-1831.5,12.5,"cylinder",4},--LS Idlewood
            {47, 720.2,-455.8,16.3,"cylinder",4},--LS Dillomore
            {11, 1024.9,-1023.7,31.1,"cylinder",4},--LS Temple
            {12, 487.3,-1741.6,10.2,"cylinder",4},--LS Beach
            {40, -1420.6,2583.6,55.8,"cylinder",4},--LV El Quebrados
            {27, -2425.6,1019.6,49.4,"cylinder",4},--SF Juniper
            {24, -1786.9,1214.8,24.1,"cylinder",4},--SF downtown
            {nil, 2515.0,-1468.2,23.0,"cylinder",3.5},--LS East LS
            {nil, 2544.8,115.6,25.4,"cylinder",3.5},--Palomino Creek
            {nil, 92.7,-165.1,1.6,"cylinder",3.5},--Blueberry Acres
            {nil, 386.6,2537.7,15.5,"cylinder",3.5},--Verdant Meadows
            {nil, 2006.0,2311.0,9.8,"cylinder",3.5},--Redsands East
            {nil, 30.5,-2636.8,39.4,"cylinder",3.5},--Flint Country
            {nil, -2108.1,-2401.7,30.4,"cylinder",3.5},--Angel Pine
            {nil, 1370.5,-1849.2,12.6,"cylinder",3.5},--Verdant Bluffs
        },
        Percentage=1.5,
        Timer=5*1000,
    },

    Carhouse={
        Marker={--x,y,z,mType,mSize,mR,mG,mB,mA,Carhouse,  blipID,blipR,blipG,blipB,tooltip
            {1577.8,-1232.2,16.7,"cylinder",1.4,0,240,255,120,"LS-CAR", 3,0,150,255,"Vehicleshop"},
            {1957.3,-2183.6,12.5,"cylinder",1.4,0,240,255,120,"LS-AIR", 7,0,150,255,"Helicoptershop"},
        },
        Cam={--startX,startY,startZ, spawnX,spawnY,spawnZ,spawnRot
            ["LS-CAR"]={1580.0,-1254.7,20.2, 1588.7,-1254.7,18.2,0},
            ["LS-AIR"]={1866.8,-2404.4,18.2, 1866.8,-2378.8,13.8,90},
        },
        SpawnPositions={--x,y,z,rotZ, playerX,playerY,playerZ
            ["LS-CAR"]={1519.2,-1271.8,14.9,180, 1541.8,-1266.8,17.6},
            ["LS-AIR"]={1960.8,-2284.1,13.9,180, 1957.8,-2187.8,13.8},
        },
        Vehicles={
            ["LS-CAR"]={--id
                {481},{468},{466},{401},{581},{585},{549},{561},{470},{490},{526},{521},{461},{496},{20001},{542},
                {587},{565},{439},{560},{20002},{536},{567},{504},{426},{522},{20003},{562},{559},{580},{480},
                {20000},{402},{415},{451},{541},{411},
            },
            ["LS-AIR"]={--id
                {469},{488},{487},{30000},
            },
        },
        LimitedVehicles={
            [580]=1735729200,
            --[426]=1733050800,
        },
        Requirement={--Hideout upgrades
            [469]={Garage=4,Hideout=1,},--Sparrow
            [488]={Garage=4,Hideout=1,},--News Chopper
            [487]={Garage=4,Hideout=1,},--Maverick
            [30000]={Garage=4,Hideout=1,},--Buzzard
        },
    },
    Names={
        [549]="Declasse Tampa",[604]="Benefactor Glendale Damaged",
		[466]="Benefactor Glendale",[561]="Zirconium Stratum",
		[426]="Declasse Premier",[458]="Vapid Solair",[491]="Albany Virgo",
		[551]="Declasse Merit",[546]="Karin Intruder",[585]="Albany Emperor",
		[445]="Dundreary Admiral",[516]="Vulcar Nebula",[547]="Albany Primo",
		[405]="Übermacht Sentinel",[540]="Maibatsu Vincent",[436]="Karin Previon",
		[439]="Declasse Stallion",[410]="Albany Manana",[542]="Declasse Clover",
		[462]="Pegassi Faggio",[496]="Dinka Blista Compact",[404]="Dinka Perennial",
		[567]="Declasse Savanna",[536]="Vapid Blade",[412]="Declasse Voodoo",
		[575]="Classique Broadway",[474]="Albany Hermes",[517]="Willard Majestic",
		[576]="Declasse Tornado",[479]="Dundreary Regina",[527]="Declasse Cadrona",
		[526]="Vapid Fortune",[589]="BF Club",[565]="Vapid Flash",[559]="Karin Jester",
        [509]="City Bike",[481]="BMX",[510]="Mountain Bike",
        [401]="Imponte Bravura",[470]="Mammoth Patriot (A)",[566]="Declasse Tahoma",
        [434]="Vapid Hotknife",[535]="Vapid Slamvan",[558]="Vapid Uranus",
        [438]="Schyster Cabbie",[490]="FIB Rancher (A)",[504]="Bloodring Banger (A)",

		[506]="Dewbauchee Super GT",[402]="Bravado Buffalo",[429]="Bravado Banshee",
		[494]="Declasse Hotring 1",[562]="Annis Elegy",[559]="Dinka Jester",
		[602]="Albany Alpha",[560]="Karin Sultan",[603]="Imponte Phoenix",
		[480]="Pfister Comet",[415]="Grotti Cheetah",[541]="Vapid Bullet",
		[451]="Grotti Turismo",[411]="Pegassi Infernus",[477]="Annis ZR-350",
        [587]="Annis Euros",[580]="Enus Stafford",

        --Addon
        --Normal
        [20000]="Pfister Comet 918",[20001]="Karin Sultan RS",[20002]="Remington Convertible",
        [20003]="Armored Truck #1",[20004]="Armored Truck #2",

        --Helicopter
        [30000]="Esquilo H350BA",

        --Event
        [22000]="Candyvan",
    },
    RemoveSirens={
        [490]=true,--FBI Rancher
    },
    Speeds={
        [481]=72,--BMX
        [410]=129,--Manana
        [468]=145,--Sanchez
        [466]=146,--Glendale
        [401]=146,--Bravura
        [581]=150,--BF-400
        [585]=152,--Emperor
        [549]=153,--Tampa
        [561]=153,--Stratum
        [558]=155,--Uranus (Unique)
        [470]=156,--Patriot
        [490]=156,--FBI Rancher
        [526]=157,--Fortune
        [535]=157,--Slamvan (Unique)
        [521]=160,--FCR-900
        [461]=160,--PCJ-600
        [496]=162,--Blista Compact
        [20001]=163,--Sultan RS
        [542]=164,--Clover
        [587]=164,--Euros
        [565]=164,--Flash
        [439]=168,--Stallion
        [560]=168,--Sultan
        [20002]=168,--Remington Convertible
        [536]=172,--Blade
        [567]=172,--Savanna
        [504]=172,--Bloodring Banger
        [426]=173,--Premier
        [522]=176,--NRG-500
        [20003]=176,--Armored Truck #1
        [20004]=176,--Armored Truck #2
        [562]=177,--Elegy
        [559]=177,--Jester
        [580]=182,--Stafford
        [480]=184,--Comet
        [20000]=184,--Comet 918
        [402]=186,--Buffalo
        [415]=192,--Cheetah
        [451]=193,--Turismo
        [541]=202,--Bullet
        [494]=214,--Hotring 1
        [411]=221,--Infernus

        --AIR
        [469]=132,--Sparrow
        [488]=155,--News Chopper
        [487]=177,--Maverick
        [30000]=177,--Esquilo H350BA
    },
    Prices={--145kmh = 45k+40k/202kmh=102k+40k       (motorcycles +60k) (4 doors +40k) (sport cars/bikes +60k)
        [481]=20000,--BMX
        [410]=69000,--Manana
        [549]=93000,--Tampa
        [542]=104000,--Clover
        [466]=126000,--Glendale
        [401]=104000,--Bravura
        [585]=132000,--Emperor
        [581]=150000,--BF-400
        [536]=112000,--Blade
        [567]=112000,--Savanna
        [504]=500000,--Bloodring Banger
        [496]=102000,--Blista Compact
        [470]=450000,--Patriot
        [490]=450000,--FBI Rancher
        [526]=97000,--Fortune
        [587]=104000,--Euros
        [565]=104000,--Flash
        [439]=108000,--Stallion
        [468]=125000,--Sanchez
        [561]=133000,--Stratum
        [521]=160000,--FCR-900
        [426]=153000,--Premier
        [461]=160000,--PCJ-600
        [562]=177000,--Elegy
        [559]=177000,--Jester
        [20001]=203000,--Sultan RS
        [560]=208000,--Sultan
        [20002]=208000,--Remington Convertible
        [522]=236000,--NRG-500
        [20003]=600000,--Armored Truck #1
        [20004]=600000,--Armored Truck #2
        [480]=184000,--Comet
        [20000]=184000,--Comet 918
        [402]=146000,--Buffalo
        [415]=192000,--Cheetah
        [451]=193000,--Turismo
        [541]=202000,--Bullet
        [411]=221000,--Infernus
        [580]=162000,--Stafford

        --AIR
        [469]=900000,--Sparrow
        [488]=1500000,--News Chopper
        [487]=2000000,--Maverick
        [30000]=2100000,--Buzzard

        --SPECIAL
        [535]=50000,
        [603]=50000,
        [434]=50000,
        [442]=50000,
        [534]=50000,
        [474]=50000,
        [558]=50000,
        [438]=50000,--Cabbie

        [22000]=50000,
    },
    Types={
        ["Plane"]={
            [511]=true,[512]=true,[593]=true,[520]=true,[476]=true,[519]=true,
			[460]=true,[513]=true,[592]=true,[577]=true,[553]=true,
        },
        ["Helicopter"]={
            [548]=true,[425]=true,[417]=true,[487]=true,[488]=true,[497]=true,
			[563]=true,[447]=true,[469]=true,
            
            --Addon
            [30000]=true,
        },
        ["Bike"]={
            [581]=true,[509]=true,[481]=true,[462]=true,[521]=true,[463]=true,
			[510]=true,[522]=true,[461]=true,[448]=true,[468]=true,[586]=true,
        },
        ["Cars"]={
            [409]=true,[525]=true,[599]=true,[601]=true,[422]=true,[482]=true,
			[605]=true,[418]=true,[543]=true,[478]=true,[554]=true,[579]=true,
			[400]=true,[404]=true,[489]=true,[505]=true,[479]=true,[442]=true,
			[458]=true,[494]=true,[502]=true,[503]=true,[561]=true,[483]=true,
			[495]=true,[602]=true,[518]=true,[419]=true,[587]=true,[533]=true,
			[474]=true,[545]=true,[517]=true,[600]=true,[549]=true,[491]=true,
			[445]=true,[604]=true,[507]=true,[466]=true,[492]=true,[539]=true,
			[546]=true,[551]=true,[516]=true,[467]=true,[426]=true,[547]=true,
			[405]=true,[580]=true,[550]=true,[566]=true,[540]=true,[421]=true,
			[529]=true,[438]=true,[420]=true,[470]=true,[596]=true,[598]=true,
			[597]=true,[536]=true,[575]=true,[534]=true,[567]=true,[535]=true,
			[576]=true,[412]=true,[402]=true,[542]=true,[603]=true,[475]=true,
			[429]=true,[541]=true,[415]=true,[480]=true,[562]=true,[565]=true,
			[434]=true,[411]=true,[559]=true,[560]=true,[506]=true,[451]=true,
			[558]=true,[555]=true,[477]=true,[504]=true,[500]=true,[526]=true,
            [496]=true,[401]=true,[527]=true,[589]=true,[410]=true,[436]=true,
			[439]=true,[574]=true,[530]=true,[572]=true,[583]=true,[441]=true,
			[464]=true,[594]=true,[501]=true,[465]=true,[564]=true,[568]=true,
			[424]=true,[457]=true,[571]=true,[490]=true,

            --Addon
            [20000]=true,[20001]=true,[20002]=true,[20003]=true,[20004]=true,

            [22000]=true,
        },
    },


    Tuning={
        WindowTintColors={--r,g,b,a, darknessFactor
            [1]={0,0,0,150, 0.7},--smoked black
            [2]={0,0,0,200, 1},--dark black
            [3]={0,0,0,255, 1.5},--limo black
            [4]={200,200,200,150, 0.6},--light white
            [5]={220,220,220,200, 1},--bright white
            [6]={150,0,0,100, 0.6},--dark red
            [7]={210,0,0,150, 0.9},--bright red
            [8]={150,150,0,100, 0.6},--dark yellow
            [9]={210,210,0,150, 0.9},--bright yellow
            [10]={215,90,30,100, 0.6},--dark orange
            [11]={215,90,30,150, 0.9},--bright orange
            [12]={0,150,0,100, 0.6},--dark green
            [13]={0,210,0,150, 0.9},--bright green
            [14]={120,220,20,150, 1},--neon green
            [15]={0,0,150,100, 0.6},--dark blue
            [16]={0,0,210,150, 0.9},--bright blue
            [17]={0,150,150,100, 0.6},--dark cyan
            [18]={0,210,210,150, 0.9},--bright cyan
            [19]={115,40,190,100, 0.6},--dark purple
            [20]={150,60,240,150, 0.9},--bright purple
            [21]={180,30,170,100, 0.6},--dark pink
            [22]={220,60,220,150, 0.9},--bright pink
            [23]={250,0,115,150, 1},--hot pink
        },
        VehicleWheelSizeModded={--size
            [470]={0.9},--Patriot
            [580]={0.8},--Stafford
        },
        VehicleWheelSizeOriginal={--group,size
            --[[ [470]={"all_wheels",1}, ]]
        },

        DefaultVariants={
            [22000]=0,
        },
        ChipPerformance={
            [1]={0.2,0.1},
            [2]={0.28,0.15},
            [3]={0.42,0.21},
            [4]={0.55,0.22},
        },
        Armory={
            [1]=1250,
            [2]=1500,
            [3]=1800,
        },
        ["ShaderTexNames"]={--for paintjobs
            [560]="sultan1body",[426]="remap",[561]="stratum1body256",[415]="remap",[562]="elegy2body256",[559]="jester1body256",
            [536]="blade92body256a",[580]="remap",[20001]="@hite",[603]="remap",[567]="savanna92body256a",[402]="remap",
            [434]="remaphotknife92body256",[565]="#emapflash92body256",[411]="remap",[522]="remap",[494]="remap",
            [535]="#emapslamvan92body128",[558]="uranus1body256",[438]="remap",[20002]="@hite",
        },
        ["CategoryIcons"]={
            ["Bodycolor"]="fas fa-paint-roller",
            ["Lightcolor"]="fas fa-lightbulb",
            ["Paintjob"]="far fa-spray-can",
            ["Lightjob"]="far fa-spray-can",
            ["WindowTint"]="far fa-spray-can",
            ["Wheels"]="fas fa-tire",
            ["Spoiler"]="Spoiler.svg",
            ["Exhaust"]="Exhaust.svg",
            ["FrontBumper"]="FrontBumper.svg",
            ["RearBumper"]="RearBumper.svg",
            ["Roof"]="Roof.svg",
            ["Lamps"]="Lamps.svg",
            ["Sideskirt"]="fas fa-grip-lines",
            ["Hydraulics"]="fas fa-wine-bottle",
            ["Chip"]="fas fa-microchip",
            ["DriveType"]="fas fa-tire",
            ["Horn"]="fas fa-bullhorn",
            ["Variant"]="fas",
            ["Armory"]="fas",
            ["WingDoors"]="fas",
            ["WheelPositionFront"]="fas fat fa-tire",
            ["WheelPositionRear"]="fas fat fa-tire",
        },

        ["Categorys"]={
            [410]={"Bodycolor","Lightcolor","Lightjob","Wheels","Spoiler","Exhaust","Lamps","Chip","DriveType","Horn",},--Manana
            [549]={"Bodycolor","Lightcolor","Wheels","Spoiler","Exhaust","Chip","DriveType","Horn",},--Tampa
            [542]={"Bodycolor","Lightcolor","Wheels","Spoiler","Exhaust","Chip","DriveType","Horn",},--Clover
            [466]={"Bodycolor","Lightcolor","Wheels","Chip","DriveType","Horn",},--Glendale
            [401]={"Bodycolor","Lightcolor","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","Lamps","Roof","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Bravura
            [585]={"Bodycolor","Lightcolor","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","Lamps","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Emperor
            [536]={"Bodycolor","Lightcolor","Paintjob","Wheels","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Hydraulics","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Blade
            [567]={"Bodycolor","Lightcolor","Paintjob","Wheels","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Hydraulics","Chip","DriveType","Horn",},--Savanna
            [504]={"Bodycolor","Lightcolor","Wheels","Chip","DriveType","Horn","Armory","WheelPositionFront","WheelPositionRear",},--Bloodring Banger
            [496]={"Bodycolor","Lightcolor","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","Roof","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Blista Compact
            [470]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","Variant","Armory","WheelPositionFront","WheelPositionRear",},--Patriot
            [490]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","Armory","WheelPositionFront","WheelPositionRear",},--FBI Rancher
            [526]={"Bodycolor","Lightcolor","Wheels","Chip","DriveType","Horn","WingDoors",},--Fortune
            [587]={"Bodycolor","Lightcolor","Wheels","Spoiler","Chip","DriveType","Horn","WingDoors",},--Euros
            [565]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Flash
            [439]={"Bodycolor","Lightcolor","Wheels","Spoiler","Lamps","Chip","DriveType","Horn","Variant","WingDoors",},--Stallion
            [468]={"Bodycolor","Lightcolor","Horn",},--Sanchez
            [561]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Stratum
            [426]={"Bodycolor","Lightcolor","Paintjob","Wheels","Spoiler","Exhaust","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Premier
            [461]={"Bodycolor","Lightcolor","Horn",},--PCJ-600
            [562]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Spoiler","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Elegy
            [559]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Spoiler","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Jester
            [20001]={"Bodycolor","Lightcolor","Paintjob","Lightjob","Wheels","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Sultan RS
            [560]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Spoiler","Exhaust","FrontBumper","RearBumper","Roof","Sideskirt","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Sultan
            [20002]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Hydraulics","Chip","Wheels","DriveType","Horn","WingDoors",},--Remington Convertible
            [522]={"Bodycolor","Lightcolor","Paintjob","Horn","Variant",},--NRG-500
            [20003]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","Armory",},--Armored Truck #1
            [20004]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn"},--Armored Truck #2
            [480]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors",},--Comet
            [20000]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors",},--Comet 918
            [402]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Chip","DriveType","Horn","Variant","WingDoors","WheelPositionFront","WheelPositionRear",},--Buffalo
            [415]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Spoiler","Exhaust","Sideskirt","Chip","DriveType","Horn","Variant","WingDoors","WheelPositionFront","WheelPositionRear",},--Cheetah
            [451]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Turismo
            [494]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors",},--Hotring 1
            [541]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Bullet
            [411]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Infernus
            [580]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Stafford
            
            --helicopters
            [469]={"WindowTint",},--Sparrow
            [487]={"Bodycolor","WindowTint",},--Maverick
            [488]={"WindowTint",},--News Chopper

            --event
            [442]={"Bodycolor","Lightcolor","WindowTint","Wheels","Chip","DriveType","Horn","Variant",},--Romero
            [474]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Hydraulics","Chip","DriveType","Horn","WingDoors",},--Hermes
            [534]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Hydraulics","Chip","Wheels","DriveType","Horn","WingDoors",},--Remington
            [434]={"Bodycolor","Lightcolor","Paintjob","Chip","Wheels","DriveType","Horn",},--Hotknife
            [603]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Chip","Spoiler","Wheels","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Phoenix
            [438]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Chip","Wheels","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Cabbie
            [558]={"Bodycolor","Lightcolor","Paintjob","Lightjob","WindowTint","Wheels","Chip","DriveType","Horn","WheelPositionFront","WheelPositionRear",},--Uranus
            [535]={"Bodycolor","Lightcolor","Paintjob","WindowTint","Wheels","Exhaust","FrontBumper","RearBumper","Sideskirt","Chip","DriveType","Horn","WingDoors","WheelPositionFront","WheelPositionRear",},--Slamvan
            [22000]={"Bodycolor","Lightcolor","WindowTint","Chip","Wheels","DriveType","Horn","Variant","WheelPositionFront","WheelPositionRear",},--Candyvan
        },
        ["Parts"]={--whitelist parts to even appear
            ["Paintjob"]={
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_4","Paintjob_5","Paintjob_6","Paintjob_7","Paintjob_8","Paintjob_9",
                "Paintjob_10","Paintjob_11","Paintjob_12","Paintjob_13","Paintjob_14","Paintjob_15","Paintjob_16","Paintjob_17","Paintjob_18","Paintjob_19","Paintjob_20",
                "Paintjob_21","Paintjob_22","Paintjob_23","Paintjob_24","Paintjob_25","Paintjob_26","Paintjob_27","Paintjob_28","Paintjob_29","Paintjob_30","Paintjob_31",
                "Paintjob_32","Paintjob_33","Paintjob_34","Paintjob_35","Paintjob_36","Paintjob_37","Paintjob_38","Paintjob_39","Paintjob_40","Paintjob_41","Paintjob_42",
                "Paintjob_43","Paintjob_44","Paintjob_45","Paintjob_46","Paintjob_47","Paintjob_48","Paintjob_49","Paintjob_50","Paintjob_51","Paintjob_52","Paintjob_53",
                "Paintjob_54","Paintjob_55","Paintjob_56","Paintjob_57","Paintjob_58","Paintjob_59","Paintjob_60","Paintjob_61","Paintjob_62","Paintjob_63","Paintjob_64",
                "Paintjob_65","Paintjob_66","Paintjob_67","Paintjob_68","Paintjob_69","Paintjob_70","Paintjob_71","Paintjob_72","Paintjob_73","Paintjob_74","Paintjob_75",
                "Paintjob_76","Paintjob_77","Paintjob_78","Paintjob_79","Paintjob_80","Paintjob_81","Paintjob_82","Paintjob_83","Paintjob_84","Paintjob_85","Paintjob_86",
                "Paintjob_87","Paintjob_88","Paintjob_89","Paintjob_90","Paintjob_91","Paintjob_92","Paintjob_93","Paintjob_94","Paintjob_95","Paintjob_96","Paintjob_97",
                "Paintjob_98","Paintjob_99","Paintjob_100","Paintjob_101","Paintjob_102","Paintjob_103","Paintjob_104","Paintjob_105","Paintjob_106","Paintjob_107",
                "Paintjob_108","Paintjob_109","Paintjob_110","Paintjob_111","Paintjob_112","Paintjob_113","Paintjob_114","Paintjob_115","Paintjob_116","Paintjob_117",
                "Paintjob_118","Paintjob_119","Paintjob_120","Paintjob_121","Paintjob_122",
            },
            ["Lightjob"]={
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_5","Lightjob_6","Lightjob_7","Lightjob_8","Lightjob_9",
                "Lightjob_10","Lightjob_11","Lightjob_12","Lightjob_13","Lightjob_14","Lightjob_15","Lightjob_16","Lightjob_17","Lightjob_18",
            },
            ["WindowTint"]={
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7","WindowTint_8",
                "WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15","WindowTint_16","WindowTint_17",
                "WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
            },
            ["Wheels"]={
                --Default SA
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                --Pack #1
                "Wheels_2861","Wheels_2866","Wheels_2867","Wheels_2683","Wheels_2767","Wheels_2342","Wheels_2221","Wheels_2222","Wheels_2223","Wheels_1977",
                --Pack #2
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859","Wheels_1860",
                "Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            ["Spoiler"]={
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
            },
            ["Exhaust"]={
                "Exhaust_9999999","Exhaust_1018","Exhaust_1019","Exhaust_1020","Exhaust_1021","Exhaust_1022","Exhaust_1028","Exhaust_1029","Exhaust_1034",
                "Exhaust_1037","Exhaust_1043","Exhaust_1044","Exhaust_1045","Exhaust_1046","Exhaust_1059","Exhaust_1064","Exhaust_1065",
                "Exhaust_1066","Exhaust_1089","Exhaust_1092","Exhaust_1104","Exhaust_1105","Exhaust_1113","Exhaust_1114","Exhaust_1126",
                "Exhaust_1127","Exhaust_1129","Exhaust_1132","Exhaust_1135","Exhaust_1136",
            },
            ["FrontBumper"]={
                "FrontBumper_9999999","FrontBumper_1115","FrontBumper_1116","FrontBumper_1117","FrontBumper_1152","FrontBumper_1153",
                "FrontBumper_1155","FrontBumper_1157","FrontBumper_1160","FrontBumper_1165","FrontBumper_1166","FrontBumper_1169",
                "FrontBumper_1170","FrontBumper_1171","FrontBumper_1172","FrontBumper_1173","FrontBumper_1174","FrontBumper_1176",
                "FrontBumper_1179","FrontBumper_1181","FrontBumper_1182","FrontBumper_1179","FrontBumper_1185","FrontBumper_1188",
                "FrontBumper_1189","FrontBumper_1190","FrontBumper_1191",
            },
            ["RearBumper"]={
                "RearBumper_9999999","RearBumper_1109","RearBumper_1110","RearBumper_1140","RearBumper_1141","RearBumper_1148",
                "RearBumper_1149","RearBumper_1150","RearBumper_1151","RearBumper_1154","RearBumper_1156","RearBumper_1159",
                "RearBumper_1161","RearBumper_1167","RearBumper_1168","RearBumper_1175","RearBumper_1177","RearBumper_1178",
                "RearBumper_1180","RearBumper_1183","RearBumper_1184","RearBumper_1186","RearBumper_1187","RearBumper_1192","RearBumper_1193",
            },
            ["Roof"]={
                "Roof_9999999","Roof_1006","Roof_1032","Roof_1033","Roof_1035","Roof_1038","Roof_1053","Roof_1054","Roof_1055","Roof_1061",
                "Roof_1067","Roof_1068","Roof_1088","Roof_1091","Roof_1103","Roof_1128","Roof_1130","Roof_1131",
            },
            ["Lamps"]={
                "Lamps_9999999","Lamps_1013","Lamps_1024",
            },
            ["Sideskirt"]={
                "Sideskirt_9999999","Sideskirt_1007","Sideskirt_1017","Sideskirt_1026","Sideskirt_1027","Sideskirt_1030","Sideskirt_1031",
                "Sideskirt_1036","Sideskirt_1039","Sideskirt_1040","Sideskirt_1041","Sideskirt_1042","Sideskirt_1047","Sideskirt_1048",
                "Sideskirt_1051","Sideskirt_1052","Sideskirt_1056","Sideskirt_1057","Sideskirt_1062","Sideskirt_1063","Sideskirt_1069",
                "Sideskirt_1070","Sideskirt_1071","Sideskirt_1072","Sideskirt_1090","Sideskirt_1093","Sideskirt_1094","Sideskirt_1095",
                "Sideskirt_1099","Sideskirt_1101","Sideskirt_1102","Sideskirt_1106","Sideskirt_1107","Sideskirt_1108","Sideskirt_1118",
                "Sideskirt_1119","Sideskirt_1120","Sideskirt_1121","Sideskirt_1122","Sideskirt_1124","Sideskirt_1133","Sideskirt_1134",
                "Sideskirt_1137",
            },
            ["Hydraulics"]={
                "Hydraulics_9999999","Hydraulics_1087",
            },
            ["Chip"]={
                "Chip_1","Chip_2","Chip_3","Chip_4",
            },
            ["DriveType"]={
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
            },
            ["Horn"]={
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
            },
            ["Variant"]={
                "Variant_0","Variant_1","Variant_2","Variant_3","Variant_4","Variant_5",
            },
            ["Armory"]={
                "Armory_0","Armory_1","Armory_2","Armory_3",
            },
            ["WingDoors"]={
                "WingDoors_9999999","WingDoors_1",
            },
            ["WheelPositionFront"]={
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3","WheelPositionFront_4","WheelPositionFront_5",
            },
            ["WheelPositionRear"]={
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3","WheelPositionRear_4","WheelPositionRear_5",
            },
        },
        ["TuningNames"]={
            --paintjobs
            ["Paintjob_9999999"]="Remove",["Paintjob_500000"]="Clean",["Paintjob_0"]="Default Paintjob 1",["Paintjob_1"]="Default Paintjob 2",
            ["Paintjob_2"]="Default Paintjob 3",["Paintjob_4"]="Sultan #1",["Paintjob_5"]="Sultan #2",["Paintjob_6"]="Sultan #3",["Paintjob_7"]="Sultan #4",
            ["Paintjob_8"]="Premier #1",["Paintjob_9"]="Premier #2",["Paintjob_10"]="Premier #3",["Paintjob_11"]="Stratum #1",["Paintjob_12"]="Stratum #2",
            ["Paintjob_13"]="Stratum #3",["Paintjob_14"]="Stratum #4",["Paintjob_15"]="Stratum #5",["Paintjob_16"]="Sultan #5",["Paintjob_17"]="Sultan #6",
            ["Paintjob_18"]="Sultan #7",["Paintjob_19"]="Cheetah #1",["Paintjob_20"]="Cheetah #2",["Paintjob_21"]="Cheetah #3",["Paintjob_22"]="Elegy #1",
            ["Paintjob_23"]="Elegy #2",["Paintjob_24"]="Elegy #3",["Paintjob_25"]="Elegy #4",["Paintjob_26"]="Elegy #5",["Paintjob_27"]="Jester #1",
            ["Paintjob_28"]="Jester #2",["Paintjob_29"]="Jester #3",["Paintjob_30"]="Jester #4",["Paintjob_31"]="Jester #5",["Paintjob_32"]="Blade #1",
            ["Paintjob_33"]="Blade #2",["Paintjob_34"]="Stafford #1",["Paintjob_35"]="Stafford #2",["Paintjob_36"]="Stafford #3",["Paintjob_37"]="Stafford #4",
            ["Paintjob_38"]="Stafford #5",["Paintjob_39"]="Stafford #6",["Paintjob_40"]="Turismo #1",["Paintjob_41"]="Turismo #2",["Paintjob_42"]="Turismo #3",
            ["Paintjob_43"]="Elegy #6",["Paintjob_44"]="Elegy #7",["Paintjob_45"]="Elegy #8",["Paintjob_46"]="Infernus #1",["Paintjob_47"]="Infernus #2",
            ["Paintjob_48"]="Infernus #3",["Paintjob_49"]="Infernus #4",["Paintjob_50"]="Sultan #8",["Paintjob_51"]="Sultan #9",["Paintjob_52"]="Sultan #10",
            ["Paintjob_53"]="General #1",["Paintjob_54"]="General #2",["Paintjob_55"]="Blade #3",["Paintjob_56"]="Elegy #9",["Paintjob_57"]="Remington #1",
            ["Paintjob_58"]="Remington #2",["Paintjob_59"]="Phoenix #1",["Paintjob_60"]="Phoenix #2",["Paintjob_61"]="Phoenix #3",["Paintjob_62"]="Hermes #1",
            ["Paintjob_63"]="Hermes #2",["Paintjob_64"]="Hermes #3",["Paintjob_65"]="Hermes #4",["Paintjob_66"]="Hermes #5",["Paintjob_67"]="Savanna #1",
            ["Paintjob_68"]="Savanna #2",["Paintjob_69"]="Savanna #3",["Paintjob_70"]="Savanna #4",["Paintjob_71"]="Savanna #5",["Paintjob_72"]="Savanna #6",
            ["Paintjob_73"]="Savanna #7",["Paintjob_74"]="Savanna #8",["Paintjob_75"]="Savanna #9",["Paintjob_76"]="Savanna #10",["Paintjob_77"]="Savanna #11",
            ["Paintjob_78"]="Savanna #12",["Paintjob_79"]="Savanna #13",["Paintjob_80"]="Savanna #14",["Paintjob_81"]="Buffalo #1",["Paintjob_82"]="Buffalo #2",
            ["Paintjob_83"]="Buffalo #3",["Paintjob_84"]="Hotknife #1",["Paintjob_85"]="Hotknife #2",["Paintjob_86"]="Hotknife #3",["Paintjob_87"]="Flash #1",
            ["Paintjob_88"]="Flash #2",["Paintjob_89"]="Flash #3",["Paintjob_90"]="Flash #4",["Paintjob_91"]="Flash #5",["Paintjob_92"]="Elegy #10",
            ["Paintjob_93"]="Elegy #11",["Paintjob_94"]="Sultan #11",["Paintjob_95"]="Jester #6",["Paintjob_96"]="Infernus #5",["Paintjob_97"]="Infernus #6",
            ["Paintjob_98"]="Infernus #7",["Paintjob_99"]="NRG #1",["Paintjob_100"]="NRG #2",["Paintjob_101"]="NRG #3",["Paintjob_102"]="Hotring 1 #1",
            ["Paintjob_103"]="Hotring 1 #2",["Paintjob_104"]="Hotring 1 #3",["Paintjob_105"]="Slamvan #1",["Paintjob_106"]="Slamvan #2",["Paintjob_107"]="Slamvan #3",
            ["Paintjob_108"]="Hotknife #4",["Paintjob_109"]="Hotknife #5",["Paintjob_110"]="Hotknife #6",["Paintjob_111"]="Hotknife #7",["Paintjob_112"]="Hotknife #8",
            ["Paintjob_113"]="Hotknife #9",["Paintjob_114"]="Uranus #1",["Paintjob_115"]="Uranus #2",["Paintjob_116"]="Cabbie #1",["Paintjob_117"]="Cabbie #2",
            ["Paintjob_118"]="Cabbie #3",["Paintjob_119"]="Uranus #3",["Paintjob_120"]="Remington #3",["Paintjob_121"]="Remington #4",["Paintjob_122"]="Remington #5",
            --lightjobs
            ["Lightjob_9999999"]="Remove",["Lightjob_0"]="Audi A7 (Red)",["Lightjob_1"]="Audi A7 (Blue)",["Lightjob_2"]="Audi A7 (Cyan)",
            ["Lightjob_3"]="Audi A7 (White)",["Lightjob_4"]="Audi A7 (Yellow)",["Lightjob_5"]="Mustang (Red)",["Lightjob_6"]="Mustang (Cyan)",
            ["Lightjob_7"]="LED (Cyan)",["Lightjob_8"]="LED (Green)",["Lightjob_9"]="LED (Yellow)",["Lightjob_10"]="Stripes 1",
            ["Lightjob_11"]="Stripes 2",["Lightjob_12"]="Doom",["Lightjob_13"]="LMB (Orange)",["Lightjob_14"]="Turqoise (B1)",["Lightjob_15"]="Turqoise (B2)",
            ["Lightjob_16"]="Turqoise (B3)",["Lightjob_17"]="BMW M5",["Lightjob_18"]="Mazda 6",
            --window tints
            ["WindowTint_9999999"]="Remove",["WindowTint_1"]="Smoked Black",["WindowTint_2"]="Dark Black",["WindowTint_3"]="Limo Black",
            ["WindowTint_4"]="Light White",["WindowTint_5"]="Bright White",["WindowTint_6"]="Dark Red",["WindowTint_7"]="Bright Red",
            ["WindowTint_8"]="Dark Yellow",["WindowTint_9"]="Bright Yellow",["WindowTint_10"]="Dark Orange",["WindowTint_11"]="Bright Orange",
            ["WindowTint_12"]="Dark Green",["WindowTint_13"]="Bright Green",["WindowTint_14"]="Neon Green",["WindowTint_15"]="Dark Blue",
            ["WindowTint_16"]="Bright Blue",["WindowTint_17"]="Dark Cyan",["WindowTint_18"]="Bright Cyan",["WindowTint_19"]="Dark Purple",
            ["WindowTint_20"]="Bright Purple",["WindowTint_21"]="Dark Pink",["WindowTint_22"]="Bright Pink",["WindowTint_23"]="Hot Pink",
            
            --wheels
            ["Wheels_1025"]="Offroad",["Wheels_1073"]="Shadow",["Wheels_1074"]="Mega",["Wheels_1075"]="Rimshine",["Wheels_1076"]="Wires",
            ["Wheels_1077"]="Classic",["Wheels_1078"]="Twist",["Wheels_1079"]="Cutter",["Wheels_1080"]="Switch",["Wheels_1081"]="Grove",
            ["Wheels_1082"]="Import",["Wheels_1083"]="Dollar",["Wheels_1084"]="Trance",["Wheels_1085"]="Atomic",["Wheels_1096"]="Ahab",
            ["Wheels_1097"]="Virtual",["Wheels_1098"]="Acces",
            --wheels(Pack #1)
            ["Wheels_2861"]="",["Wheels_2866"]="",["Wheels_2867"]="",["Wheels_2683"]="",["Wheels_2767"]="",
            ["Wheels_2342"]="",["Wheels_2221"]="",["Wheels_2222"]="",["Wheels_2223"]="",["Wheels_1977"]="",
            --wheels(Pack #2)
            ["Wheels_1941"]="Minerva",["Wheels_1855"]="Rotiform",["Wheels_1947"]="Cerberus",["Wheels_1853"]="Cerberus 2",
            ["Wheels_1854"]="Rotiform 2",["Wheels_1856"]="VS",["Wheels_1857"]="",["Wheels_1858"]="Oasis",["Wheels_1859"]="",
            ["Wheels_1860"]="HRE Performance",["Wheels_1861"]="Krätze",["Wheels_1862"]="",["Wheels_1863"]="Rays",
            ["Wheels_1864"]="Vossen 2",["Wheels_1871"]="Vossen",["Wheels_1872"]="Volk Racing",
            --spoilers
            ["Spoiler_9999999"]="Remove",["Spoiler_1000"]="Pro",["Spoiler_1001"]="Win",["Spoiler_1002"]="Drag",["Spoiler_1003"]="Alpha",["Spoiler_1014"]="Champ",
            ["Spoiler_1015"]="Race",["Spoiler_1016"]="Worx",["Spoiler_1023"]="Fury",["Spoiler_1138"]="Alien",["Spoiler_1139"]="X-Flow",["Spoiler_1146"]="X-Flow",
            ["Spoiler_1147"]="Alien",["Spoiler_1049"]="Alien",["Spoiler_1050"]="X-Flow",["Spoiler_1058"]="Alien",["Spoiler_1060"]="X-Flow",["Spoiler_1158"]="X-Flow",
            ["Spoiler_1162"]="Alien",["Spoiler_1163"]="X-Flow",
            --exhausts
            ["Exhaust_9999999"]="Remove",["Exhaust_1018"]="Upswept",["Exhaust_1019"]="Twin",["Exhaust_1020"]="Large",["Exhaust_1021"]="Medium",["Exhaust_1022"]="Small",
            ["Exhaust_1028"]="Alien",["Exhaust_1029"]="X-Flow",["Exhaust_1034"]="Alien",["Exhaust_1037"]="X-Flow",["Exhaust_1043"]="Slamin",["Exhaust_1044"]="Chrome",
            ["Exhaust_1045"]="X-Flow",["Exhaust_1046"]="Alien",["Exhaust_1059"]="X-Flow",["Exhaust_1064"]="Alien",["Exhaust_1065"]="Alien",["Exhaust_1066"]="X-Flow",
            ["Exhaust_1089"]="X-Flow",["Exhaust_1092"]="Alien",["Exhaust_1104"]="Chrome",["Exhaust_1105"]="Slamin",["Exhaust_1113"]="Chrome",["Exhaust_1114"]="Slamin",
            ["Exhaust_1126"]="Chrome",["Exhaust_1127"]="Slamin",["Exhaust_1129"]="Chrome",["Exhaust_1132"]="Slamin",["Exhaust_1135"]="Slamin",["Exhaust_1136"]="Chrome",
            --front bumpers
            ["FrontBumper_9999999"]="Remove",["FrontBumper_1115"]="Chrome",["FrontBumper_1116"]="Slamin",["FrontBumper_1117"]="Chrome",["FrontBumper_1152"]="X-Flow",
            ["FrontBumper_1153"]="Alien",["FrontBumper_1155"]="Alien",["FrontBumper_1157"]="X-Flow",["FrontBumper_1160"]="Alien",["FrontBumper_1165"]="X-Flow",
            ["FrontBumper_1166"]="Alien",["FrontBumper_1169"]="Alien",["FrontBumper_1170"]="X-Flow",["FrontBumper_1171"]="Alien",["FrontBumper_1172"]="X-Flow",
            ["FrontBumper_1173"]="X-Flow",["FrontBumper_1174"]="Chrome",["FrontBumper_1176"]="Chrome",["FrontBumper_1179"]="Chrome",["FrontBumper_1181"]="Slamin",
            ["FrontBumper_1182"]="Chrome",["FrontBumper_1185"]="Slamin",["FrontBumper_1188"]="Slamin",["FrontBumper_1189"]="Chrome",["FrontBumper_1190"]="Slamin",
            ["FrontBumper_1191"]="Chrome",
            --rear bumpers
            ["RearBumper_9999999"]="Remove",["RearBumper_1109"]="Chrome",["RearBumper_1110"]="Slamin",["RearBumper_1140"]="X-Flow",["RearBumper_1141"]="Alien",
            ["RearBumper_1148"]="X-Flow",["RearBumper_1149"]="Alien",["RearBumper_1150"]="Alien",["RearBumper_1151"]="X-Flow",["RearBumper_1154"]="Alien",
            ["RearBumper_1156"]="X-Flow",["RearBumper_1159"]="Alien",["RearBumper_1161"]="X-Flow",["RearBumper_1167"]="X-Flow",["RearBumper_1168"]="Alien",
            ["RearBumper_1175"]="Slamin",["RearBumper_1177"]="Slamin",["RearBumper_1178"]="Slamin",["RearBumper_1180"]="Chrome",["RearBumper_1183"]="Slamin",
            ["RearBumper_1184"]="Chrome",["RearBumper_1186"]="Slamin",["RearBumper_1187"]="Chrome",["RearBumper_1192"]="Chrome",["RearBumper_1193"]="Slamin",
            --roofs
            ["Roof_9999999"]="Remove",["Roof_1006"]="Roof Scoop",["Roof_1032"]="Alien Roof Vent",["Roof_1033"]="X-Flow Roof Vent",
            ["Roof_1035"]="X-Flow Roof Vent",["Roof_1038"]="Alien Roof Vent",["Roof_1053"]="X-Flow",["Roof_1054"]="Alien",
            ["Roof_1055"]="Alien",["Roof_1061"]="X-Flow",["Roof_1067"]="Alien",["Roof_1068"]="X-Flow",["Roof_1088"]="Alien",
            ["Roof_1091"]="X-Flow",["Roof_1103"]="Covertible",["Roof_1128"]="Vinyl Hardtop",["Roof_1130"]="Hardtop",
            ["Roof_1131"]="Softtop",
            --lamps
            ["Lamps_9999999"]="Remove",["Lamps_1013"]="Round Fog",["Lamps_1024"]="Square Fog",
            --sideskirt
            ["Sideskirt_9999999"]="Remove",["Sideskirt_1007"]="Right Sideskirt",["Sideskirt_1017"]="Left Sideskirt",["Sideskirt_1026"]="Right Alien Sideskirt",
            ["Sideskirt_1027"]="Left Alien Sideskirt",["Sideskirt_1030"]="Left X-Flow Sideskirt",["Sideskirt_1031"]="Right X-Flow Sideskirt",
            ["Sideskirt_1036"]="Right Alien Sideskirt",["Sideskirt_1039"]="Left X-Flow Sideskirt",["Sideskirt_1040"]="Left Alien Sideskirt",
            ["Sideskirt_1041"]="Right X-Flow Sideskirt",["Sideskirt_1042"]="Right Chrome Sideskirt",["Sideskirt_1047"]="Right Alien Sideskirt",
            ["Sideskirt_1048"]="Right X-Flow Sideskirt",["Sideskirt_1051"]="Left Alien Sideskirt",["Sideskirt_1052"]="Left X-Flow Sideskirt",
            ["Sideskirt_1056"]="Right Alien Sideskirt",["Sideskirt_1057"]="Right X-Flow Sideskirt",["Sideskirt_1062"]="Left Alien Sideskirt",
            ["Sideskirt_1063"]="Left X-Flow Sideskirt",["Sideskirt_1069"]="Right Alien Sideskirt",["Sideskirt_1070"]="Right X-Flow Sideskirt",
            ["Sideskirt_1071"]="Left Alien Sideskirt",["Sideskirt_1072"]="Left X-Flow Sideskirt",["Sideskirt_1090"]="Right Alien Sideskirt",
            ["Sideskirt_1093"]="Right X-Flow Sideskirt",["Sideskirt_1094"]="Left Alien Sideskirt",["Sideskirt_1095"]="Right X-Flow Sideskirt",
            ["Sideskirt_1099"]="Left Chrome Sideskirt",["Sideskirt_1101"]="Left `Chrome Flames` Sideskirt",["Sideskirt_1102"]="Left `Chrome Strip` Sideskirt",
            ["Sideskirt_1106"]="Right `Chrome Arches`",["Sideskirt_1107"]="Left `Chrome Strip` Sideskirt",["Sideskirt_1108"]="Right `Chrome Strip` Sideskirt",
            ["Sideskirt_1118"]="Right `Chrome Trim` Sideskirt",["Sideskirt_1119"]="Right `Wheelcovers` Sideskirt",["Sideskirt_1120"]="Left `Chrome Trim` Sideskirt",
            ["Sideskirt_1121"]="Left `Wheelcovers` Sideskirt",["Sideskirt_1122"]="Right `Chrome Flames` Sideskirt",["Sideskirt_1124"]="Left `Chrome Arches` Sideskirt",
            ["Sideskirt_1133"]="Right `Chrome Strip` Sideskirt",["Sideskirt_1134"]="Right `Chrome Strip` Sideskirt",["Sideskirt_1137"]="Left `Chrome Strip` Sideskirt",
            --hydraulics
            ["Hydraulics_9999999"]="Remove",["Hydraulics_1087"]="Hydraulics",
            --chip
            ["Chip_1"]="Stage 1 (0.2%)",["Chip_2"]="Stage 2 (0.28%)",["Chip_3"]="Stage 3 (0.42%)",["Chip_4"]="Stage 4 (0.55%)",
            --drive type
            ["DriveType_awd"]="All-wheel drive",["DriveType_fwd"]="Front drive",["DriveType_rwd"]="Rear drive",
            --horns
            ["Horn_9999999"]="Remove",["Horn_1"]="Horn #1",["Horn_2"]="Horn #2",["Horn_3"]="Horn #3",["Horn_4"]="Horn #4",["Horn_5"]="Horn #5",
            ["Horn_6"]="Horn #6",["Horn_7"]="Horn #7",["Horn_8"]="Horn #8",["Horn_9"]="Horn #9",
            --variants
            ["Variant_0"]="Variant #1",["Variant_1"]="Variant #2",["Variant_2"]="Variant #3",["Variant_3"]="Variant #4",["Variant_4"]="Variant #5",
            ["Variant_5"]="Variant #6",
            --armory
            ["Armory_0"]="Armory (Remove)",["Armory_1"]="Armory (25%)",["Armory_2"]="Armory (50%)",["Armory_3"]="Armory (80%)",
            --wing doors
            ["WingDoors_9999999"]="Remove",["WingDoors_1"]="Wing doors",
            --wheel position
            ["WheelPositionFront_9999999"]="Remove",["WheelPositionFront_1"]="Stage 1",["WheelPositionFront_2"]="Stage 2",["WheelPositionFront_3"]="Stage 3",
            ["WheelPositionFront_4"]="Stage 4",["WheelPositionFront_5"]="Stage 5",

            ["WheelPositionRear_9999999"]="Remove",["WheelPositionRear_1"]="Stage 1",["WheelPositionRear_2"]="Stage 2",["WheelPositionRear_3"]="Stage 3",
            ["WheelPositionRear_4"]="Stage 4",["WheelPositionRear_5"]="Stage 5",
        },
        ["TuningPrices"]={
            ["Bodycolor"]=15000,
		    ["Lightcolor"]=5000,

            --paintjobs
            ["Paintjob_9999999"]=0,["Paintjob_500000"]=10,["Paintjob_0"]=50,["Paintjob_1"]=50,["Paintjob_2"]=50,
            ["Paintjob_4"]=100,["Paintjob_5"]=100,["Paintjob_6"]=100,["Paintjob_7"]=100,["Paintjob_8"]=100,
            ["Paintjob_9"]=100,["Paintjob_10"]=100,["Paintjob_11"]=100,["Paintjob_12"]=100,["Paintjob_13"]=100,
            ["Paintjob_14"]=100,["Paintjob_15"]=100,["Paintjob_16"]=100,["Paintjob_17"]=100,["Paintjob_18"]=100,
            ["Paintjob_19"]=100,["Paintjob_20"]=100,["Paintjob_21"]=100,["Paintjob_22"]=100,["Paintjob_23"]=100,
            ["Paintjob_24"]=100,["Paintjob_25"]=100,["Paintjob_26"]=100,["Paintjob_27"]=100,["Paintjob_28"]=100,
            ["Paintjob_29"]=100,["Paintjob_30"]=100,["Paintjob_31"]=100,["Paintjob_32"]=100,["Paintjob_33"]=100,
            ["Paintjob_34"]=100,["Paintjob_35"]=100,["Paintjob_36"]=100,["Paintjob_37"]=100,["Paintjob_38"]=100,
            ["Paintjob_39"]=100,["Paintjob_40"]=100,["Paintjob_41"]=100,["Paintjob_42"]=100,["Paintjob_43"]=100,
            ["Paintjob_44"]=100,["Paintjob_45"]=100,["Paintjob_46"]=100,["Paintjob_47"]=100,["Paintjob_48"]=100,
            ["Paintjob_49"]=100,["Paintjob_50"]=100,["Paintjob_51"]=100,["Paintjob_52"]=100,["Paintjob_53"]=100,
            ["Paintjob_54"]=100,["Paintjob_55"]=100,["Paintjob_56"]=100,["Paintjob_57"]=100,["Paintjob_58"]=100,
            ["Paintjob_59"]=100,["Paintjob_60"]=100,["Paintjob_61"]=100,["Paintjob_62"]=100,["Paintjob_63"]=100,
            ["Paintjob_64"]=100,["Paintjob_65"]=100,["Paintjob_66"]=100,["Paintjob_67"]=100,["Paintjob_68"]=100,
            ["Paintjob_69"]=100,["Paintjob_70"]=100,["Paintjob_71"]=100,["Paintjob_72"]=100,["Paintjob_73"]=100,
            ["Paintjob_74"]=100,["Paintjob_75"]=100,["Paintjob_76"]=100,["Paintjob_77"]=100,["Paintjob_78"]=100,
            ["Paintjob_79"]=100,["Paintjob_80"]=100,["Paintjob_81"]=100,["Paintjob_82"]=100,["Paintjob_83"]=100,
            ["Paintjob_84"]=100,["Paintjob_85"]=100,["Paintjob_86"]=100,["Paintjob_87"]=100,["Paintjob_88"]=100,
            ["Paintjob_89"]=100,["Paintjob_90"]=100,["Paintjob_91"]=100,["Paintjob_92"]=100,["Paintjob_93"]=100,
            ["Paintjob_94"]=100,["Paintjob_95"]=100,["Paintjob_96"]=100,["Paintjob_97"]=100,["Paintjob_98"]=100,
            ["Paintjob_99"]=100,["Paintjob_100"]=100,["Paintjob_101"]=100,["Paintjob_102"]=100,["Paintjob_103"]=100,
            ["Paintjob_104"]=100,["Paintjob_105"]=100,["Paintjob_106"]=100,["Paintjob_107"]=100,["Paintjob_108"]=100,
            ["Paintjob_109"]=100,["Paintjob_110"]=100,["Paintjob_111"]=100,["Paintjob_112"]=100,["Paintjob_113"]=100,
            ["Paintjob_114"]=100,["Paintjob_115"]=100,["Paintjob_116"]=100,["Paintjob_117"]=100,["Paintjob_118"]=100,
            ["Paintjob_119"]=100,["Paintjob_120"]=100,["Paintjob_121"]=100,["Paintjob_122"]=100,["Paintjob_123"]=100,
            --lightjobs
            ["Lightjob_9999999"]=0,["Lightjob_0"]=85,["Lightjob_1"]=85,["Lightjob_2"]=85,["Lightjob_3"]=85,["Lightjob_4"]=85,
            ["Lightjob_5"]=85,["Lightjob_6"]=85,["Lightjob_7"]=85,["Lightjob_8"]=85,["Lightjob_9"]=85,
            ["Lightjob_10"]=85,["Lightjob_11"]=85,["Lightjob_12"]=85,["Lightjob_13"]=85,["Lightjob_14"]=85,
            ["Lightjob_15"]=85,["Lightjob_16"]=85,["Lightjob_17"]=85,["Lightjob_18"]=85,
            --window tints
            ["WindowTint_9999999"]=0,["WindowTint_1"]=95,["WindowTint_2"]=95,["WindowTint_3"]=95,["WindowTint_4"]=95,
            ["WindowTint_5"]=95,["WindowTint_6"]=95,["WindowTint_7"]=95,["WindowTint_8"]=95,["WindowTint_8"]=95,
            ["WindowTint_9"]=95,["WindowTint_10"]=95,["WindowTint_11"]=95,["WindowTint_12"]=95,["WindowTint_13"]=95,
            ["WindowTint_14"]=95,["WindowTint_15"]=95,["WindowTint_16"]=95,["WindowTint_17"]=95,["WindowTint_18"]=95,
            ["WindowTint_19"]=95,["WindowTint_20"]=95,["WindowTint_21"]=95,["WindowTint_22"]=95,["WindowTint_23"]=95,            
            --wheels
            ["Wheels_1025"]=25,["Wheels_1073"]=25,["Wheels_1074"]=25,["Wheels_1075"]=25,["Wheels_1076"]=25,
            ["Wheels_1077"]=25,["Wheels_1078"]=25,["Wheels_1079"]=25,["Wheels_1080"]=25,["Wheels_1081"]=25,
            ["Wheels_1082"]=25,["Wheels_1083"]=25,["Wheels_1084"]=25,["Wheels_1085"]=25,["Wheels_1096"]=25,
            ["Wheels_1097"]=25,["Wheels_1098"]=25,
            --wheels(Pack #1)
            ["Wheels_2861"]=50,["Wheels_2866"]=50,["Wheels_2867"]=50,["Wheels_2683"]=50,["Wheels_2767"]=50,
            ["Wheels_2342"]=50,["Wheels_2221"]=50,["Wheels_2222"]=50,["Wheels_2223"]=50,["Wheels_1977"]=50,
            --wheels(Pack #2)
            ["Wheels_1941"]=50,["Wheels_1947"]=50,["Wheels_1853"]=50,["Wheels_1854"]=50,["Wheels_1855"]=50,
            ["Wheels_1856"]=50,["Wheels_1857"]=50,["Wheels_1858"]=50,["Wheels_1859"]=50,["Wheels_1860"]=50,
            ["Wheels_1861"]=50,["Wheels_1862"]=50,["Wheels_1863"]=50,["Wheels_1864"]=50,["Wheels_1871"]=50,
            ["Wheels_1872"]=50,
            --spoilers
            ["Spoiler_9999999"]=0,["Spoiler_1000"]=10,["Spoiler_1001"]=10,["Spoiler_1002"]=10,["Spoiler_1003"]=10,["Spoiler_1014"]=10,
            ["Spoiler_1015"]=10,["Spoiler_1016"]=10,["Spoiler_1023"]=10,["Spoiler_1138"]=10,["Spoiler_1139"]=10,["Spoiler_1146"]=10,
            ["Spoiler_1147"]=10,["Spoiler_1049"]=10,["Spoiler_1050"]=10,["Spoiler_1058"]=10,["Spoiler_1060"]=10,["Spoiler_1158"]=10,
            ["Spoiler_1162"]=10,["Spoiler_1163"]=10,
            --exhausts
            ["Exhaust_9999999"]=0,["Exhaust_1018"]=9,["Exhaust_1019"]=9,["Exhaust_1020"]=9,["Exhaust_1021"]=9,["Exhaust_1022"]=9,
            ["Exhaust_1028"]=9,["Exhaust_1029"]=9,["Exhaust_1034"]=9,["Exhaust_1037"]=9,["Exhaust_1043"]=9,["Exhaust_1044"]=9,
            ["Exhaust_1045"]=9,["Exhaust_1046"]=9,["Exhaust_1059"]=9,["Exhaust_1064"]=9,["Exhaust_1065"]=9,["Exhaust_1066"]=9,
            ["Exhaust_1089"]=9,["Exhaust_1092"]=9,["Exhaust_1104"]=9,["Exhaust_1105"]=9,["Exhaust_1113"]=9,["Exhaust_1114"]=9,
            ["Exhaust_1126"]=9,["Exhaust_1127"]=9,["Exhaust_1129"]=9,["Exhaust_1132"]=9,["Exhaust_1135"]=9,["Exhaust_1136"]=9,
            --front bumpers
            ["FrontBumper_9999999"]=0,["FrontBumper_1115"]=8,["FrontBumper_1116"]=8,["FrontBumper_1117"]=8,["FrontBumper_1152"]=8,
            ["FrontBumper_1153"]=8,["FrontBumper_1155"]=8,["FrontBumper_1157"]=8,["FrontBumper_1160"]=8,["FrontBumper_1165"]=8,
            ["FrontBumper_1166"]=8,["FrontBumper_1169"]=8,["FrontBumper_1170"]=8,["FrontBumper_1171"]=8,["FrontBumper_1172"]=8,
            ["FrontBumper_1173"]=8,["FrontBumper_1174"]=8,["FrontBumper_1176"]=8,["FrontBumper_1179"]=8,["FrontBumper_1181"]=8,
            ["FrontBumper_1182"]=8,["FrontBumper_1185"]=8,["FrontBumper_1188"]=8,["FrontBumper_1189"]=8,["FrontBumper_1190"]=8,
            ["FrontBumper_1191"]=8,
            --rear bumpers
            ["RearBumper_9999999"]=0,["RearBumper_1109"]=8,["RearBumper_1110"]=8,["RearBumper_1140"]=8,["RearBumper_1141"]=8,
            ["RearBumper_1148"]=8,["RearBumper_1149"]=8,["RearBumper_1150"]=8,["RearBumper_1151"]=8,["RearBumper_1154"]=8,
            ["RearBumper_1156"]=8,["RearBumper_1159"]=8,["RearBumper_1161"]=8,["RearBumper_1167"]=8,["RearBumper_1168"]=8,
            ["RearBumper_1175"]=8,["RearBumper_1177"]=8,["RearBumper_1178"]=8,["RearBumper_1180"]=8,["RearBumper_1183"]=8,
            ["RearBumper_1184"]=8,["RearBumper_1186"]=8,["RearBumper_1187"]=8,["RearBumper_1192"]=8,["RearBumper_1193"]=8,
            --roofs
            ["Roof_9999999"]=0,["Roof_1006"]=8,["Roof_1032"]=8,["Roof_1033"]=8,["Roof_1035"]=8,["Roof_1038"]=8,
            ["Roof_1053"]=8,["Roof_1054"]=8,["Roof_1055"]=8,["Roof_1061"]=8,["Roof_1067"]=8,["Roof_1068"]=8,
            ["Roof_1088"]=8,["Roof_1091"]=8,["Roof_1103"]=8,["Roof_1128"]=8,["Roof_1130"]=8,["Roof_1131"]=8,
            --lamps
            ["Lamps_9999999"]=0,["Lamps_1013"]=5,["Lamps_1024"]=5,
            --sideskirt
            ["Sideskirt_9999999"]=0,["Sideskirt_1007"]=5,["Sideskirt_1017"]=5,["Sideskirt_1026"]=5,["Sideskirt_1027"]=5,
            ["Sideskirt_1030"]=5,["Sideskirt_1031"]=5,["Sideskirt_1036"]=5,["Sideskirt_1039"]=5,["Sideskirt_1040"]=5,
            ["Sideskirt_1041"]=5,["Sideskirt_1042"]=5,["Sideskirt_1047"]=5,["Sideskirt_1048"]=5,["Sideskirt_1051"]=5,
            ["Sideskirt_1052"]=5,["Sideskirt_1056"]=5,["Sideskirt_1057"]=5,["Sideskirt_1062"]=5,["Sideskirt_1063"]=5,
            ["Sideskirt_1069"]=5,["Sideskirt_1070"]=5,["Sideskirt_1071"]=5,["Sideskirt_1072"]=5,["Sideskirt_1090"]=5,
            ["Sideskirt_1093"]=5,["Sideskirt_1094"]=5,["Sideskirt_1095"]=5,["Sideskirt_1099"]=5,["Sideskirt_1101"]=5,
            ["Sideskirt_1102"]=5,["Sideskirt_1106"]=5,["Sideskirt_1107"]=5,["Sideskirt_1108"]=5,["Sideskirt_1118"]=5,
            ["Sideskirt_1119"]=5,["Sideskirt_1120"]=5,["Sideskirt_1121"]=5,["Sideskirt_1122"]=5,["Sideskirt_1124"]=5,
            ["Sideskirt_1133"]=5,["Sideskirt_1134"]=5,["Sideskirt_1137"]=5,
            --hydraulics
            ["Hydraulics_9999999"]=0,["Hydraulics_1087"]=25,
            --chip
            ["Chip_1"]=125,["Chip_2"]=175,["Chip_3"]=225,["Chip_4"]=275,
            --drive type
            ["DriveType_awd"]=80,["DriveType_fwd"]=55,["DriveType_rwd"]=55,
            --horns
            ["Horn_9999999"]=0,["Horn_1"]=15,["Horn_2"]=15,["Horn_3"]=15,["Horn_4"]=15,["Horn_5"]=15,
            ["Horn_6"]=15,["Horn_7"]=15,["Horn_8"]=15,["Horn_9"]=15,
            --variants
            ["Variant_0"]=25,["Variant_1"]=25,["Variant_2"]=25,["Variant_3"]=25,["Variant_4"]=25,["Variant_5"]=25,
            --armory
            ["Armory_0"]=0,["Armory_1"]=250,["Armory_2"]=350,["Armory_3"]=500,
            --wing doors
            ["WingDoors_9999999"]=0,["WingDoors_1"]=70,
            --wheel position
            --f
            ["WheelPositionFront_9999999"]=0,["WheelPositionFront_1"]=20,["WheelPositionFront_2"]=25,["WheelPositionFront_3"]=30,["WheelPositionFront_4"]=35,
            ["WheelPositionFront_5"]=40,
            --r
            ["WheelPositionRear_9999999"]=0,["WheelPositionRear_1"]=20,["WheelPositionRear_2"]=25,["WheelPositionRear_3"]=30,["WheelPositionRear_4"]=35,
            ["WheelPositionRear_5"]=40,
        },

        ["TuningAvailable"]={
            [410]={--Manana
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_12","Lightjob_14","Lightjob_15","Lightjob_16",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1158","Spoiler_1162",
                --exhausts
                "Exhaust_9999999","Exhaust_1019","Exhaust_1020","Exhaust_1021",
                --lamps
                "Lamps_9999999","Lamps_1013","Lamps_1024",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [549]={--Tampa
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1158","Spoiler_1162",
                --exhausts
                "Exhaust_9999999","Exhaust_1018","Exhaust_1019","Exhaust_1020",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [542]={--Clover
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1158","Spoiler_1162",
                --exhausts
                "Exhaust_9999999","Exhaust_1018","Exhaust_1019","Exhaust_1020","Exhaust_1021",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [466]={--Glendale
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [401]={--Bravura
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_12","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1019","Exhaust_1020",
                --lamps
                "Lamps_9999999","Lamps_1013",
                --roofs
                "Roof_9999999","Roof_1006",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1007","Sideskirt_1017",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [585]={--Emperor
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_14","Lightjob_15",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1018","Exhaust_1019","Exhaust_1020",
                --lamps
                "Lamps_9999999","Lamps_1013",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [536]={--Blade
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_32","Paintjob_33","Paintjob_55",
                --exhausts
                "Exhaust_9999999","Exhaust_1104","Exhaust_1105",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1181","FrontBumper_1182",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1183","RearBumper_1184",
                --roofs
                "Roof_9999999","Roof_1103","Roof_1128",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1107","Sideskirt_1108",
                --hydraulics
                "Hydraulics_9999999","Hydraulics_1087",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [567]={--Savanna
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_67","Paintjob_68","Paintjob_69",
                "Paintjob_70","Paintjob_71","Paintjob_72","Paintjob_73","Paintjob_74","Paintjob_75","Paintjob_76","Paintjob_77",
                "Paintjob_78","Paintjob_79","Paintjob_80",
                --exhausts
                "Exhaust_9999999","Exhaust_1129","Exhaust_1132",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1188","FrontBumper_1189",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1186","RearBumper_1187",
                --roofs
                "Roof_9999999","Roof_1130","Roof_1131",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1102",
                --hydraulics
                "Hydraulics_9999999","Hydraulics_1087",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [504]={--Bloodring Banger
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
                --armory
                "Armory_0","Armory_1","Armory_2",
            },
            [496]={--Blista Compact
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_14","Lightjob_15",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1019","Exhaust_1020",
                --roofs
                "Roof_9999999","Roof_1006",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1007","Sideskirt_1017",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [470]={--Patriot
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --variants
                "Variant_0","Variant_1","Variant_2","Variant_3",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
                --armory
                "Armory_0","Armory_1","Armory_2","Armory_3",
            },
            [490]={--FBI Rancher
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --variants
                "Variant_0","Variant_1","Variant_2","Variant_3",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
                --armory
                "Armory_0","Armory_1","Armory_2","Armory_3",
            },
            [526]={--Fortune
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [587]={--Euros
                --spoilers
                "Spoiler_9999999","Spoiler_1001","Spoiler_1003","Spoiler_1023","Spoiler_1138","Spoiler_1146","Spoiler_1158",
                "Spoiler_1162",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [565]={--Flash
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_87","Paintjob_88","Paintjob_89","Paintjob_90",
                "Paintjob_91",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1058","Spoiler_1060","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1045","Exhaust_1046",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1152","FrontBumper_1153",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1150","RearBumper_1151",
                --roofs
                "Roof_9999999","Roof_1053","Roof_1054",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1051","Sideskirt_1052",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [439]={--Stallion
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058","Spoiler_1060",
                "Spoiler_1163",
                --lamps
                "Lamps_9999999","Lamps_1013",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --variants
                "Variant_0","Variant_1","Variant_2",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [468]={--Sanchez
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
            },
            [561]={--Stratum
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_11","Paintjob_12","Paintjob_13","Paintjob_14","Paintjob_15",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_12","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1058","Spoiler_1060","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1059","Exhaust_1064",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1155","FrontBumper_1157",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1154","RearBumper_1156",
                --roofs
                "Roof_9999999","Roof_1055","Roof_1061",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1056","Sideskirt_1057",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [521]={--FCR-900
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
            },
            [426]={--Premier
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_8","Paintjob_9","Paintjob_10",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1019","Exhaust_1021",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [461]={--PCJ-600
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
            },
            [562]={--Elegy
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_22","Paintjob_23","Paintjob_24","Paintjob_25",
                "Paintjob_26","Paintjob_43","Paintjob_44","Paintjob_45","Paintjob_53","Paintjob_54","Paintjob_56","Paintjob_92","Paintjob_93",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1146","Spoiler_1147","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1034","Exhaust_1037",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1171","FrontBumper_1172",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1148","RearBumper_1149",
                --roofs
                "Roof_9999999","Roof_1035","Roof_1038",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1036","Sideskirt_1039","Sideskirt_1040","Sideskirt_1041",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [559]={--Jester
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_27","Paintjob_28","Paintjob_29","Paintjob_30",
                "Paintjob_31","Paintjob_53","Paintjob_54","Paintjob_95",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1065","Exhaust_1066",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1160","FrontBumper_1173",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1159","RearBumper_1161",
                --roofs
                "Roof_9999999","Roof_1067","Roof_1068",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1069","Sideskirt_1070","Sideskirt_1071","Sideskirt_1072",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [20001]={--Sultan RS
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_4","Paintjob_5","Paintjob_6","Paintjob_7","Paintjob_16",
                "Paintjob_17","Paintjob_18","Paintjob_50","Paintjob_51","Paintjob_52","Paintjob_94",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_14","Lightjob_15","Lightjob_16",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [560]={--Sultan
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_4","Paintjob_5","Paintjob_6","Paintjob_7",
                "Paintjob_16","Paintjob_17","Paintjob_18","Paintjob_50","Paintjob_51","Paintjob_52","Paintjob_94",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1147","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1028","Exhaust_1029",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1169","FrontBumper_1170",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1140","RearBumper_1141",
                --roofs
                "Roof_9999999","Roof_1032","Roof_1033",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1026","Sideskirt_1030",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [20002]={--Remington Convertible
                --paintjobs
                "Paintjob_9999999","Paintjob_122",
                --lightjobs
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_12","Lightjob_13","Lightjob_14",
                "Lightjob_15","Lightjob_16","Lightjob_18",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --hydraulics
                "Hydraulics_9999999","Hydraulics_1087",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [522]={--NRG-500
                --paintjobs
                "Paintjob_9999999","Paintjob_99","Paintjob_100","Paintjob_101",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --variants
                "Variant_0","Variant_1","Variant_2","Variant_3","Variant_4",
            },
            [20003]={--Armored Truck #1
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --armory
                "Armory_0","Armory_1",
            },
            [20004]={--Armored Truck #2
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [480]={--Comet
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [20000]={--Comet 918
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [402]={--Buffalo
                --paintjobs
                "Paintjob_9999999","Paintjob_81","Paintjob_82","Paintjob_83",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_11","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --variants
                "Variant_0","Variant_1",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [415]={--Cheetah
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_19","Paintjob_20","Paintjob_21",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1000","Spoiler_1001","Spoiler_1002","Spoiler_1003","Spoiler_1014","Spoiler_1015","Spoiler_1016",
                "Spoiler_1023","Spoiler_1138","Spoiler_1139","Spoiler_1146","Spoiler_1049","Spoiler_1050","Spoiler_1058",
                "Spoiler_1060","Spoiler_1158","Spoiler_1162","Spoiler_1163",
                --exhausts
                "Exhaust_9999999","Exhaust_1018","Exhaust_1019",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1007","Sideskirt_1017",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --variants
                "Variant_0","Variant_1",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [451]={--Turismo
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_40","Paintjob_41","Paintjob_42",
                --lightjobs
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_5","Lightjob_6","Lightjob_12",
                "Lightjob_13","Lightjob_14","Lightjob_15","Lightjob_16","Lightjob_17","Lightjob_18",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [494]={--Hotring 1
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_102","Paintjob_103","Paintjob_104",
                --lightjobs
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_5","Lightjob_6","Lightjob_12",
                "Lightjob_13","Lightjob_14","Lightjob_15","Lightjob_16","Lightjob_17","Lightjob_18",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [541]={--Bullet
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [411]={--Infernus
                --paintjobs
                "Paintjob_9999999","Paintjob_46","Paintjob_47","Paintjob_48","Paintjob_49","Paintjob_96","Paintjob_97","Paintjob_98",
                --lightjobs
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_5","Lightjob_6","Lightjob_12",
                "Lightjob_13","Lightjob_14","Lightjob_15","Lightjob_16","Lightjob_17","Lightjob_18",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [580]={--Stafford
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_34","Paintjob_35","Paintjob_36","Paintjob_37","Paintjob_38","Paintjob_39",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },

            --helicopters
            [469]={--Sparrow
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
            },
            [487]={--Maverick
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
            },
            [488]={--News Chopper
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
            },

            --event
            [442]={--Romero
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --variants
                "Variant_0","Variant_1","Variant_2",
            },
            [474]={--Hermes
                --paintjobs
                "Paintjob_9999999","Paintjob_62","Paintjob_63","Paintjob_64","Paintjob_65","Paintjob_66",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --hydraulics
                "Hydraulics_9999999","Hydraulics_1087",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [534]={--Remington
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_57","Paintjob_58","Paintjob_120",
                "Paintjob_121","Paintjob_122",
                --lightjobs
                "Lightjob_9999999","Lightjob_0","Lightjob_1","Lightjob_2","Lightjob_3","Lightjob_4","Lightjob_12","Lightjob_13","Lightjob_14",
                "Lightjob_15","Lightjob_16","Lightjob_18",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --hydraulics
                "Hydraulics_9999999","Hydraulics_1087",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
            },
            [434]={--Hotknife
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_84","Paintjob_85","Paintjob_86","Paintjob_108","Paintjob_109","Paintjob_110",
                "Paintjob_111","Paintjob_112","Paintjob_113",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
            },
            [438]={--Cabbie
                --paintjobs
                "Paintjob_9999999","Paintjob_116","Paintjob_117","Paintjob_118",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_2","WheelPositionRear_3",
            },
            [535]={--Slamvan
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_105","Paintjob_106","Paintjob_107",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --exhausts
                "Exhaust_9999999","Exhaust_1113","Exhaust_1114",
                --front bumpers
                "FrontBumper_9999999","FrontBumper_1115","FrontBumper_1116",
                --rear bumpers
                "RearBumper_9999999","RearBumper_1109","RearBumper_1110",
                --sideskirts
                "Sideskirt_9999999","Sideskirt_1118","Sideskirt_1119",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859","Wheels_1860",
                "Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2","WheelPositionFront_3",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2","WheelPositionRear_3",
            },
            [558]={--Uranus
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_0","Paintjob_1","Paintjob_2","Paintjob_114","Paintjob_115","Paintjob_119",
                --lightjobs
                "Lightjob_9999999","Lightjob_7","Lightjob_8","Lightjob_9","Lightjob_10","Lightjob_14","Lightjob_15","Lightjob_16",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
            [603]={--Phoenix
                --paintjobs
                "Paintjob_9999999","Paintjob_500000","Paintjob_59","Paintjob_60","Paintjob_61",
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --spoilers
                "Spoiler_9999999","Spoiler_1001","Spoiler_1003","Spoiler_1023","Spoiler_1139",
                --chip
                "Chip_1","Chip_2","Chip_3","Chip_4",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --wing doors
                "WingDoors_9999999","WingDoors_1",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_3","WheelPositionFront_4","WheelPositionFront_5",
                "WheelPositionRear_9999999","WheelPositionRear_3","WheelPositionRear_4","WheelPositionRear_5",
            },
            [22000]={--Candyvan
                --window tints
                "WindowTint_9999999","WindowTint_1","WindowTint_2","WindowTint_3","WindowTint_4","WindowTint_5","WindowTint_6","WindowTint_7",
                "WindowTint_8","WindowTint_9","WindowTint_10","WindowTint_11","WindowTint_12","WindowTint_13","WindowTint_14","WindowTint_15",
                "WindowTint_16","WindowTint_17","WindowTint_18","WindowTint_19","WindowTint_20","WindowTint_21","WindowTint_22","WindowTint_23",
                --chip
                "Chip_1","Chip_2",
                --drivetype
                "DriveType_awd","DriveType_fwd","DriveType_rwd",
                --horns
                "Horn_9999999","Horn_1","Horn_2","Horn_3","Horn_4","Horn_5","Horn_6","Horn_7","Horn_8","Horn_9",
                --wheels
                "Wheels_1025","Wheels_1073","Wheels_1074","Wheels_1075","Wheels_1076","Wheels_1077","Wheels_1078","Wheels_1079","Wheels_1080",
                "Wheels_1081","Wheels_1082","Wheels_1083","Wheels_1084","Wheels_1085","Wheels_1096","Wheels_1097","Wheels_1098",
                "Wheels_1941","Wheels_1855","Wheels_1947","Wheels_1853","Wheels_1854","Wheels_1856","Wheels_1857","Wheels_1858","Wheels_1859",
                "Wheels_1860","Wheels_1861","Wheels_1862","Wheels_1863","Wheels_1864","Wheels_1871","Wheels_1872",
                --variants
                "Variant_0","Variant_1","Variant_2","Variant_3","Variant_4","Variant_5",
                --wheel positions
                "WheelPositionFront_9999999","WheelPositionFront_1","WheelPositionFront_2",
                "WheelPositionRear_9999999","WheelPositionRear_1","WheelPositionRear_2",
            },
        },

        ModdedWheels={
            --Pack #1
            [2861]=true,[2866]=true,[2867]=true,[2683]=true,[2767]=true,[2342]=true,[2221]=true,
            [2222]=true,[2223]=true,[1977]=true,
            --Pack #2
            [1853]=true,[1854]=true,[1855]=true,[1856]=true,[1857]=true,[1858]=true,[1859]=true,
            [1860]=true,[1861]=true,[1862]=true,[1863]=true,[1864]=true,[1871]=true,[1872]=true,
            [1941]=true,[1947]=true,
            --Atomic
            [1877]=true,[1878]=true,[1879]=true,[1880]=true,[1881]=true,[1882]=true,[1901]=true,
            [1902]=true,[1903]=true,[1904]=true,[1911]=true,[1921]=true,[1930]=true,[1931]=true,
            [1932]=true,[1933]=true,[1940]=true,
        },
    },



    CustomVehicleHandlings={
        --[[ [580]={--Stafford
            ["maxVelocity"]=240.0,
		    ["engineAcceleration"]=13.5,
        }, ]]
        [20000]={--Comet 918
            ["modelFlags"]=0x00002000,--double exhaust smoke
        },
    }
}




function returnVehicleName(id)
    local name=nil;
    if(Vehicle.Names[tonumber(id)])then
        name=Vehicle.Names[tonumber(id)];
    else
        name=getVehicleNameFromModel(tonumber(id));
    end

    return name or "N/A";
end


function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end
function setElementSpeed(element, unit, speed)
    local unit = unit or 0;
    local speed = tonumber(speed) or 0;
    local acSpeed = getElementSpeed(element, unit);
    if (acSpeed) then
        local diff = speed / acSpeed;
        if diff ~= diff then
            return false;
        end
        local x, y, z = getElementVelocity(element);
        return setElementVelocity(element, x * diff, y * diff, z * diff);
    end

    return false;
end





function getVehicleCustomHandlingPart(veh,vehid,part)
	local aaaaa=nil;
	if(veh and isElement(veh)and vehid and part)then
		if(CustomVehicleHandlings[tonumber(vehid)]and CustomVehicleHandlings[tonumber(vehid)][part])then
			for handling,v in pairs(CustomVehicleHandlings[tonumber(vehid)])do
				if(handling==part)then
					aaaaa=v;
					break;
				end
			end
			return aaaaa;
		else
			return getVehicleHandling(veh)[part];
		end
	end
	return nil;
end