Robs={
    DeliverPositions={--x,y,z
        {2337.4,-1248.3,21.5},
        {1085.6,-1226.5,14.8},
    },
    PlayerRequired=1,--
    
    ["Jewelery"]={
        RewardAmount={2100,2400},
        BountyPercentage=2,
        Timers={
            TillOpen=800,
            Reset=15*60*1000,
        },

        Zones={
            ["Jewelery_LS"]={
                Blip={465.4,-1498.6,20.5,5, 0,240,255, "Jewelery (LS)"},--x,y,z,icon, r,g,b, tooltip
                Zone={457.0,-1509.5,18,25},
                Ped={461.2,-1498.7,20.5,270, 11,"Rose_Scholz"},--Ped[x,y,z,rot, ID,Name]
                OutPos={475.1,-1516.7,20.4},
            },
        },
        Cases={--x,y,z,rotZ, colRange
            ["Jewelery_LS"]={--Pos[x,y,z,rot] Marker[size]
                {Pos={461.5,-1489.6,19.5,0},Marker={1.07}},
                {Pos={463.1,-1489.6,19.5,0},Marker={1.07}},
                {Pos={464.7,-1489.6,19.5,0},Marker={1.07}},
                {Pos={466.3,-1489.6,19.5,0},Marker={1.07}},
                {Pos={467.9,-1489.6,19.5,0},Marker={1.07}},
                {Pos={469.5,-1489.6,19.5,0},Marker={1.07}},
                {Pos={471.1,-1489.6,19.5,0},Marker={1.07}},

                {Pos={468.6,-1492.4,22.9,180},Marker={1.07}},
                {Pos={466.6,-1492.4,22.9,180},Marker={1.07}},
                {Pos={468.6,-1494.8,22.9,0},Marker={1.07}},
                {Pos={466.6,-1494.8,22.9,0},Marker={1.07}},

                {Pos={468.6,-1500.0,22.9,180},Marker={1.07}},
                {Pos={466.6,-1500.0,22.9,180},Marker={1.07}},
                {Pos={468.6,-1502.3,22.9,0},Marker={1.07}},
                {Pos={466.6,-1502.3,22.9,0},Marker={1.07}},

                {Pos={459.7,-1507.1,22.9,90},Marker={1.07}},
                {Pos={459.7,-1505.5,22.9,90},Marker={1.07}},
                {Pos={459.7,-1500.9,22.9,90},Marker={1.07}},
                {Pos={459.7,-1499.3,22.9,90},Marker={1.07}},
                {Pos={459.7,-1497.7,22.9,90},Marker={1.07}},
            },
        },


        NPCs={
            ["Jewelery_LS"]={--Pos[x,y,z,rot] Ped[ID,Title]
                {Pos={473.5,-1501.9,20.5,270},Ped={166,"Elite Security"},Weapon=24,Range=30,Type="Security:Elite",},
                {Pos={473.5,-1495.9,20.5,270},Ped={166,"Elite Security"},Weapon=31,Range=30,Type="Security:Elite",},

                {Pos={468.2,-1498.1,20.5,270},Ped={163,"Regular Security"},Weapon=29,Range=20,Type="Security:Regular",},
                {Pos={460.0,-1488.8,20.5,180},Ped={165,"Regular Security"},Weapon=31,Range=20,Type="Security:Regular",},
                {Pos={470.3,-1508.6,20.5,0},Ped={164,"Regular Security"},Weapon=29,Range=20,Type="Security:Regular",},

                {Pos={466.0,-1505.2,23.9,180},Ped={164,"Regular Security"},Weapon=29,Range=20,Type="Security:Regular",},
                {Pos={471.9,-1505.8,23.9,90},Ped={163,"Regular Security"},Weapon=29,Range=20,Type="Security:Regular",},
                {Pos={459.9,-1494.5,23.9,224},Ped={165,"Regular Security"},Weapon=29,Range=20,Type="Security:Regular",},
            },
        },
    },
    ["ATM"]={
        BountyPercentage=0.5,
        Timers={
            TillOpen=650,
            Reset=10*60*1000,
        },

        PickupAmount={4,6},

        ATMs={--Pos[x,y,z,rot] Object[objectID,objectID2] Col[Size,Distance] RequiredItem[Item,Amount] RewardAmount[min,max]
            --// LS \\
            {Pos={1928.6,-1779.6,13.5,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Tankstation Idlewood
            {Pos={1000.9,-923.2,42.3,279},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Tankstation Mulholland
            {Pos={2406.0,-1455.0,24.0,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Hideout #1
            {Pos={2415.1,-1511.6,24.0,0},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Cluckin Bell
            {Pos={2091.6,-1349.8,24.0,270},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--
            {Pos={1802.8,-1572.3,13.4,41},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--
            {Pos={1940.0,-2113.7,13.7,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--XXX
            {Pos={2126.5,-1154.6,23.9,206},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Vehicleshop
            {Pos={563.5,-1258.4,17.2,284},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Vehicleshop
            {Pos={2415.7,-1219.5,25.5,0},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Pen
            {Pos={2229.2,-1180.6,25.9,175},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Motel
            {Pos={1680.1,-2335.5,13.5,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Airport
            {Pos={1619.3,-1171.6,24.1,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Betting office
            {Pos={1367.3,-1290.2,13.5,270},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Ammunation
            {Pos={2707.4,-1095.6,69.5,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Market
            {Pos={2389.3,-1914.9,13.5,0},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Cluckin Bell
            {Pos={2105.4,-1809.6,13.5,270},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Pizza Stack
            {Pos={2021.2,-1404.5,17.2,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Ambulance
            {Pos={1135.2,-1524.7,15.8,202},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Mall
            {Pos={2708.1,-1699.7,11.9,204},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Stadion
            {Pos={303.2,-1422.0,14.1,303},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--
            {Pos={1971.0,-1283.5,24.0,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--
            {Pos={1162.3,-1776.7,13.7,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Center
            {Pos={689.2,-470.1,16.6,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Dillimore bar
            {Pos={165.3,-202.2,1.7,0},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--
            {Pos={1496.1,-1749.9,15.4,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Townhall
            {Pos={1466.2,-1749.9,15.4,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Townhall
            {Pos={437.4,-1733.4,9.5,178},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Beach
            {Pos={1326.6,-896.4,39.6,90},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Mulholland

            -- (z+0.5 from floor)
            {Pos={1384.3,-1094.2,28.0,270},Object={1900,1900},Col={0.5,1.2},RequiredItem={"CrowbarExtended",1},RewardAmount={2000,3500},},--Bank
            {Pos={1491.9,-1011.9,27.5,270},Object={1900,1900},Col={0.5,1.2},RequiredItem={"CrowbarExtended",1},RewardAmount={2000,3500},},--Bank
            {Pos={1722.4,-1625.3,14.3,180},Object={1900,1900},Col={0.5,1.2},RequiredItem={"CrowbarExtended",1},RewardAmount={2000,3500},},--Commerce
            {Pos={1748.8,-1863.8,14.2,180},Object={1900,1900},Col={0.5,1.2},RequiredItem={"CrowbarExtended",1},RewardAmount={2000,3500},},--El Corona

            --// LV \\
            {Pos={2108.9,896.8,11.2,180},Object={2942,2943},Col={0.5,1.2},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--LV LV
            -- (z+0.5 from floor)
            {Pos={2021.3,1016.9,11.4,0},Object={1900,1900},Col={0.5,1.2},RequiredItem={"CrowbarExtended",1},RewardAmount={2000,3500},},--Dragon Casino
        },
    },
    ["SprunkATM"]={
        BountyPercentage=0.5,
        Timers={
            TillOpen=650,
            Reset=10*60*1000,
        },

        PickupAmount={4,6},

        ATMs={--Pos[x,y,z,rot] Object[objectID,objectID2] Col[Size,Distance] RequiredItem[Item,Amount] RewardAmount[min,max]
            --// LS \\
            {Pos={1065.2,-1026.6,32.1,0},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},
            {Pos={926.9,-1344.8,13.4,270},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},
            {Pos={1509.1,-1582.4,13.5,0},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},
            {Pos={1836.9,-1696.0,13.3,270},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},
            {Pos={1810.2,-2137.1,13.5,90},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},
            {Pos={1174.3,-1329.7,13.9,0},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Hospital
            {Pos={2043.8,-1411.0,17.1,270},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Hospital
            {Pos={2236.1,-1150.4,25.9,180},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Motel
            {Pos={1029.1,-1384.9,13.5,90},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Market
            {Pos={305.3,-1554.5,36.0,74},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Rodeo
            {Pos={672.6,-1861.1,5.4,180},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Beach
            {Pos={2327.3,-1643.3,14.8,90},Object={1775,955},Col={0.6,1.0},RequiredItem={"Crowbar",1},RewardAmount={900,1000},},--Grove Street
        },
    },
    ["Container"]={
        RewardAmount={800,850},
        BountyPercentage=0.5,
        Timers={
            TillOpen=800,
            Reset=15*60*1000,
        },

        PickupAmount={5,8},

        Zones={
            ["Container_LS"]={
                Blip={2837.9,-2438.1,12.9,8, 0,240,255, "Containers (LS Docks)"},--x,y,z,icon, r,g,b, tooltip
                Zone={2819.4,-2549.8,40,225},
                OutPos={2791.1,-2437.1,13.6},
            },
            ["Container_SF"]={
                Blip={-2405.6,1549.8,17.3,8, 0,240,255, "Containers (SF Ship)"},--x,y,z,icon, r,g,b, tooltip
                Zone={-2529.5,1522.9,230,40},
                OutPos={-2403.4,1402.9,7.3},
            },
        },
        Containers={
            ["Container_LS"]={--Pos[x,y,z,rot] Col[Range]
                {Pos={2832.5,-2383.4,12.9,90},Col={0.9},},
                {Pos={2837.9,-2383.4,12.9,90},Col={0.9},},
                {Pos={2843.5,-2383.4,12.9,90},Col={0.9},},
    
                {Pos={2832.5,-2438.1,12.9,270},Col={0.9},},
                {Pos={2837.9,-2438.1,12.9,270},Col={0.9},},
                {Pos={2843.5,-2438.1,12.9,270},Col={0.9},},
    
                {Pos={2832.5,-2457.6,12.9,90},Col={0.9},},
                {Pos={2837.9,-2457.6,12.9,90},Col={0.9},},
                {Pos={2843.5,-2457.6,12.9,90},Col={0.9},},
    
                {Pos={2832.5,-2514.2,12.8,270},Col={0.9},},
                {Pos={2837.9,-2514.2,12.8,270},Col={0.9},},
                {Pos={2843.5,-2514.2,12.8,270},Col={0.9},},
            },
            ["Container_SF"]={--Pos[x,y,z,rot] Col[Range]
                {Pos={-2336.3,1556.7,18.25,180},Col={0.9},},
                {Pos={-2349.0,1546.7,18.25,90},Col={0.9},},
                {Pos={-2361.3,1549.7,18.25,180},Col={0.9},},
                {Pos={-2375.6,1546.9,18.25,90},Col={0.9},},
                {Pos={-2385.0,1546.9,21.15,90},Col={0.9},},

                {Pos={-2415.7,1540.1,11.72,0},Col={0.9},},
                {Pos={-2371.6,1552.8,3.05,0},Col={0.9},},
            },
        },


        NPCs={
            ["Container_LS"]={--Pos[x,y,z,rot] Ped[ID,Title]
                {Pos={2821.9,-2433.0,12.1,100},Ped={166,"Regular Security"},Weapon=24,Range=28,Type="Security:Regular",},
                {Pos={2822.5,-2441.2,12.1,100},Ped={165,"Regular Security"},Weapon=31,Range=28,Type="Security:Regular",},

                {Pos={2835.2,-2410.0,12.1,100},Ped={165,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},
                {Pos={2841.4,-2409.7,12.1,100},Ped={164,"Regular Security"},Weapon=29,Range=30,Type="Security:Regular",},
                {Pos={2853.6,-2475.3,12.1,100},Ped={165,"Regular Security"},Weapon=24,Range=35,Type="Security:Regular",},
                {Pos={2822.6,-2496.5,12.1,100},Ped={166,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},
                {Pos={2854.1,-2435.9,12.1,90},Ped={164,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},

                {Pos={2838.2,-2413.9,24.5,185},Ped={163,"Elite Security"},Weapon=34,Range=50,Type="Security:Elite",},
                {Pos={2838.0,-2517.2,21.2,12},Ped={163,"Elite Security"},Weapon=34,Range=65,Type="Security:Elite",},
            },
            ["Container_SF"]={--Pos[x,y,z,rot] Ped[ID,Title]
                {Pos={-2382.7,1528.3,17.3,0},Ped={166,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},
                {Pos={-2348.3,1528.5,17.3,0},Ped={166,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},

                {Pos={-2411.4,1534.1,17.3,180},Ped={166,"Regular Security"},Weapon=24,Range=35,Type="Security:Regular",},
                {Pos={-2428.3,1534.1,17.3,180},Ped={166,"Regular Security"},Weapon=31,Range=35,Type="Security:Regular",},

                {Pos={-2372.2,1547.3,23.1,180},Ped={163,"Elite Security"},Weapon=34,Range=50,Type="Security:Elite",},

                --bottom
                {Pos={-2423.2,1545.8,7.9,65},Ped={164,"Elite Security"},Weapon=34,Range=50,Type="Security:Elite",},
                {Pos={-2376.7,1534.1,2.1,54},Ped={164,"Regular Security"},Weapon=31,Range=40,Type="Security:Regular",},
            },
        },
    },
    ["Shops"]={
        RewardAmount={550,590},
        MaxRewards={10,14},
        BountyPercentage=0.8,
        Timers={
            Reset=10*60*1000,
        },

        Shop={--Zone[x,y,width,height] Ped[ID,Title,x,y,z,rot] Blip[ID,Name]
            {Zone={243.0,-61.5,14,9,},Ped={201,"Rosie_McMillan", 252.1,-54.8,1.6,180},Blip={6,"Liquor (Blueberry)"},Range=8,},--Liquor Blueberry
            {Zone={1833.7,-1851.0,23,16.5,},Ped={128,"Harry_Smith", 1835.8,-1835.1,13.6,180},Blip={6,"69c (Idlewood)"},Range=8,},--69c Idlewood
            {Zone={1621.4,-1191.5,20,18,},Ped={150,"Paola_Gunn", 1633.7,-1188.7,24.1,0},Blip={6,"Betting Office (Downtown)"},Range=8,},--Betting Office

            {Zone={2231.1,-1687.1,23,23,},Ped={217,"Philip_Best", 2241.5,-1677.1,15.5,343},Blip={6,"Binco (Ganton)"},Range=8,},--Binco Ganton
            {Zone={273.2,-1464.5,26,28,},Ped={216,"Kimberly_Santos", 290.8,-1456.9,17,26},Blip={6,"Binco (Rodeo)"},Range=8,},--Binco Rodeo

            {Zone={2382.9,-1914.0,17.5,14,},Ped={167,"Brent_Vogel", 2390.8,-1910.4,13.5,0},Blip={11,"Cluckin Bell (Willowfield)"},Range=8,},--CluckinBell Willowfield

            {Zone={792.1,-1626.5,18,15,},Ped={155,"David_Fox", 806.9,-1623.1,13.5,0},Blip={9,"Burgershot (Marina)"},Range=8,},--Burgershot Marina
            {Zone={1189.5,-916.4,19,21,},Ped={205,"Emma_Pitts", 1203.3,-902.7,43.3,99},Blip={9,"Burgershot (Temple)"},Range=8,},--Burgershot Temple

            {Zone={999.3,-930.2,19,22,},Ped={223,"Scot_Lewis", 1014.3,-925.9,42.3,99},Blip={6,"Gasstation (Mulholland)"},Range=8,},--Gasstation Mulholland
            {Zone={1914.5,-1786.3,13.5,20,},Ped={233,"Mary_Brown", 1915.3,-1768.6,13.5,270},Blip={6,"Gasstation (Idlewood)"},Range=8,},--Gasstation Idlewood
            {Zone={662.0,-577.3,9.5,24.5,},Ped={217,"David_Bell", 663.4,-566.6,16.3,180},Blip={6,"Gasstation (Dillimore)"},Range=8,},--Gasstation Dillimore

            {Zone={1385.6,-1705.9,30,50.5,},Ped={6,"Karen_Bond", 1390.8,-1692.1,13.6,270},Blip={6,"Agencia (Commerce)"},Range=10,},--Agencia
            {Zone={-105.3,1158.6,24,29.5,},Ped={5,"Dennis_Akin", -95.3,1167.2,19.7,0},Blip={16,"Bowling (Fort Carson)"},Range=8,},--Bowling
        },
    },
    ["Oilrig"]={
        RewardAmount=1000,
        BountyPercentage=1,
        Timers={
            Reset=30*60*1000,
        },

        Zones={
            ["Oilrig_LS"]={
                Blip={731.1,-2846.8,22.4,12, 0,240,255, "Oilrig (LS)"},--x,y,z,icon, r,g,b, tooltip
                Zone={679.0,-2910.0,95,115},
                OutPos={742.1,-2793.5,2.4},
            },
        },
        Rigs={
            ["Oilrig_LS"]={--Pos[x,y,z] Amount[min,max]
                {Pos={731.1,-2871.7,22.4},Marker={2.5},Amount={10000,25000},},
                {Pos={731.1,-2846.8,22.4},Marker={2.5},Amount={10000,25000},},
                {Pos={731.1,-2822.6,22.4},Marker={2.5},Amount={10000,25000},},
            },
        },
    },
    ["Warehouse"]={
        Timers={
            TillOpen=550,
            TillOpen2=10*1000,
            TillOpen3=5*1000,
            Reset=30*60*1000,
        },

        Zones={
            ["Docks_LS"]={
                Blip={2787.4,-2417.6,13.6,20, 0,240,255, "Warehouse (LS Docks)"},--x,y,z,icon, r,g,b, tooltip
                Zone={2773.8,-2430.5,28,25},
                OutPos={2761.7,-2394.1,13.9},
                Gate={3037, 2774.3,-2417.8,14.8,14.0,0, 1.1},--id, x,y,z,colZ,rot, colSize
                RequiredItemAmount=1,
            },
            ["Blueberry"]={
                Blip={149.0,-322.5,8.5,20, 0,240,255, "Warehouse (Blueberry)"},--x,y,z,icon, r,g,b, tooltip
                Zone={114.5,-341.0,70,38.7},--184.5,-341.2
                OutPos={2761.7,-2394.1,13.9},
                Gate={16775, 183.7,-320.8,4.0,2.3,90, 1.1},--id, x,y,z,colZ,rot, colSize
                RequiredItemAmount=4,
            },
        },
        Boxes={
            ["Docks_LS"]={--Pos[x,y,z,rot] Marker[size]
                {Pos={2782.1,-2408.2,12.6,270},Marker={1.07},},
                {Pos={2782.1,-2410.2,12.6,270},Marker={1.07},},
                {Pos={2785.5,-2408.2,12.6,90},Marker={1.07},},
                {Pos={2785.5,-2410.2,12.6,90},Marker={1.07},},

                {Pos={2790.2,-2408.2,12.6,270},Marker={1.07},},
                {Pos={2790.2,-2410.2,12.6,270},Marker={1.07},},
                {Pos={2793.6,-2408.2,12.6,90},Marker={1.07},},
                {Pos={2793.6,-2410.2,12.6,90},Marker={1.07},},

                {Pos={2795.7,-2408.2,12.6,270},Marker={1.07},},
                {Pos={2795.7,-2410.2,12.6,270},Marker={1.07},},
                {Pos={2799.2,-2408.2,12.6,90},Marker={1.07},},
                {Pos={2799.2,-2410.2,12.6,90},Marker={1.07},},
                --
                {Pos={2782.1,-2425.4,12.6,270},Marker={1.07},},
                {Pos={2782.1,-2427.4,12.6,270},Marker={1.07},},
                {Pos={2785.5,-2425.4,12.6,90},Marker={1.07},},
                {Pos={2785.5,-2427.4,12.6,90},Marker={1.07},},
            },
            ["Blueberry"]={--Pos[x,y,z,rot] Marker[size]
                {Pos={180.0,-328.4,0.6,90},Marker={1.07},},
                {Pos={180.0,-331.0,0.6,90},Marker={1.07},},
                {Pos={180.0,-335.4,0.6,90},Marker={1.07},},
                {Pos={180.0,-338.1,0.6,90},Marker={1.07},},
                {Pos={176.2,-328.4,0.6,270},Marker={1.07},},
                {Pos={176.2,-331.0,0.6,270},Marker={1.07},},
                {Pos={176.2,-335.4,0.6,270},Marker={1.07},},
                {Pos={176.2,-338.1,0.6,270},Marker={1.07},},

                {Pos={168.0,-328.4,0.6,90},Marker={1.07},},
                {Pos={168.0,-331.0,0.6,90},Marker={1.07},},
                {Pos={168.0,-335.4,0.6,90},Marker={1.07},},
                {Pos={168.0,-338.1,0.6,90},Marker={1.07},},
                {Pos={164.2,-328.4,0.6,270},Marker={1.07},},
                {Pos={164.2,-331.0,0.6,270},Marker={1.07},},
                {Pos={164.2,-335.4,0.6,270},Marker={1.07},},
                {Pos={164.2,-338.1,0.6,270},Marker={1.07},},

                {Pos={156.0,-328.4,0.6,90},Marker={1.07},},
                {Pos={156.0,-331.0,0.6,90},Marker={1.07},},
                {Pos={156.0,-335.4,0.6,90},Marker={1.07},},
                {Pos={156.0,-338.1,0.6,90},Marker={1.07},},
                {Pos={152.2,-328.4,0.6,270},Marker={1.07},},
                {Pos={152.2,-331.0,0.6,270},Marker={1.07},},
                {Pos={152.2,-335.4,0.6,270},Marker={1.07},},
                {Pos={152.2,-338.1,0.6,270},Marker={1.07},},

                {Pos={144.0,-328.4,0.6,90},Marker={1.07},},
                {Pos={144.0,-331.0,0.6,90},Marker={1.07},},
                {Pos={144.0,-335.4,0.6,90},Marker={1.07},},
                {Pos={144.0,-338.1,0.6,90},Marker={1.07},},
                {Pos={140.2,-328.4,0.6,270},Marker={1.07},},
                {Pos={140.2,-331.0,0.6,270},Marker={1.07},},
                {Pos={140.2,-335.4,0.6,270},Marker={1.07},},
                {Pos={140.2,-338.1,0.6,270},Marker={1.07},},

                {Pos={132.0,-328.4,0.6,90},Marker={1.07},},
                {Pos={132.0,-331.0,0.6,90},Marker={1.07},},
                {Pos={132.0,-335.4,0.6,90},Marker={1.07},},
                {Pos={132.0,-338.1,0.6,90},Marker={1.07},},
                {Pos={128.2,-328.4,0.6,270},Marker={1.07},},
                {Pos={128.2,-331.0,0.6,270},Marker={1.07},},
                {Pos={128.2,-335.4,0.6,270},Marker={1.07},},
                {Pos={128.2,-338.1,0.6,270},Marker={1.07},},
            },
        },

        Loot={
            {Item="Nitro",Amount={100,300},Chance=250,},
            {Item="Cash",Amount={100,180},Chance=220,},
            {Item="Stone",Amount={10,50},Chance=190,},
            {Item="Crowbar",Amount={1,3},Chance=150,},
            {Item="Medikit",Amount={1,3},Chance=115,},
            {Item="IronIngot",Amount={2,7},Chance=95,},
            {Item="GoldIngot",Amount={2,5},Chance=70,},
            {Item="Cannabis",Amount={2,10},Chance=50,},
            {Item="Diamond",Amount={1,2},Chance=35,},
            {Item="Emerald",Amount={1,1},Chance=20,},
            {Item="ItemBooster1",Amount={1,1},Chance=8,},
            {Item="MoneyBooster1",Amount={1,1},Chance=4,},
            {Item="ItemBooster3",Amount={1,1},Chance=1,},
        },
    },

    RandomDeliverItemReward={
        {
            Item="Weapon_30_2",
            Amount={1,1},
            Chance=2,
        },
        {
            Item="Weapon_31_2",
            Amount={1,1},
            Chance=2,
        },
        {
            Item="Nitro",
            Amount={10,25},
            Chance=50,
        },
        {
            Item="Medikit",
            Amount={1,2},
            Chance=35,
        },
        {
            Item="Repairkit",
            Amount={1,2},
            Chance=35,
        },
        {
            Item="GoldIngot",
            Amount={1,4},
            Chance=30,
        },
        {
            Item="IronIngot",
            Amount={2,5},
            Chance=30,
        },
        {
            Item="Crowbar",
            Amount={1,2},
            Chance=20,
        },
    },
}