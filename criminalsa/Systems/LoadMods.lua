addRemoteEvents{"Vehicle:Preview:Wheels"};--addEvent


local ModTable={
	--Weapons
	{model=348,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/348.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/348.dff",col=nil},--Deagle
	{model=349,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/349.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/349.dff",col=nil},--Shotgun
	{model=353,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/353.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/353.dff",col=nil},--MP5
	{model=355,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/355.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/355.dff",col=nil},--AK
	{model=356,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/356.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/356.dff",col=nil},--M4
	{model=358,txd=":"..RESOURCE_NAME.."/Files/Models/Weapons/358.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Weapons/358.dff",col=nil},--Sniper

	--Buildings
	{
		model=2926,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Bunker.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Bunker.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Bunker.col",
	},
	{
		model=2925,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent.col",
	},
	{
		model=2908,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent2.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent2.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Tent2.col",
	},
	{
		model=17636,
		txd=nil,
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Hideout.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Hideout.col",
	},
	{
		model=5142,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/6thStreet.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/6thStreet.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/6thStreet.col",
	},
	{
		model=2035,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Logistic.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Logistic.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Logistic.col",
		lodDistance=200,
	},
	{
		model=2034,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Warehouse.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Warehouse.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Warehouse.col",
		lodDistance=200,
	},
	{
		model=5463,
		txd=nil,
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/ConstructionLS.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/ConstructionLS.col",
	},
	{
		model=4563,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/CarhouseLS.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/CarhouseLS.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/CarhouseLS.col",
	},
	{
		model=3105,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Suburban.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Suburban.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Suburban.col",removeWorld=true,
	},
	{
		model=4193,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/PublicGarage.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/PublicGarage.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/PublicGarage.col",
	},

	{
		model=2042,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/1.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/1.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/1.col",
	},
	{
		model=2044,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/2.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/2.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/2.col",
	},
	{
		model=2043,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/3.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/3.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/3.col",
	},
	{
		model=2045,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/4.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/4.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Garages/4.col",
	},

	{
		model=6334,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Jeweler/Model.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Jeweler/Model.zaw",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Jeweler/Model.col",
	},
	{
		model=6165,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS.col",
		lodDistance=150,
	},
	{
		model=5741,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS2.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS2.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Burgershot/LS2.col",
		lodDistance=150,
	},
	{
		model=5853,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Mulholland.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Mulholland.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Mulholland.col",
	},
	{
		model=12853,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Dillimore.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Dillimore.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Dillimore.col",
	},
	{
		model=5409,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Idlewood.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Idlewood.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Tankstations/Idlewood.col",
	},
	{
		model=5168,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/CluckinBell/Willowfield.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/CluckinBell/Willowfield.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/CluckinBell/Willowfield.col",
	},
	{
		model=5040,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/69c.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/69c.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/69c.col",
	},
	{
		model=4683,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/BettingOffice.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/BettingOffice.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/BettingOffice.col",
	},
	{
		model=17521,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Pawn.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Pawn.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Pawn.col",
	},
	{
		model=5267,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bar.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bar.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bar.col",
	},
	{
		model=4005,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Agencia.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Agencia.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Agencia.col",
	},
	{
		model=16475,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bowling.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bowling.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Regular/Bowling.col",
	},
	{
		model=17517,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Ganton.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Ganton.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Ganton.col",
	},
	{
		model=6373,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Rodeo.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Rodeo.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Robs/Binco/Rodeo.col",
	},



	

	{
		model=1516,
		txd=":"..RESOURCE_NAME.."/Files/Models/Generators/1.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Generators/1.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Generators/1.col",
		lodDistance=20,
	},
	{
		model=2040,
		txd=":"..RESOURCE_NAME.."/Files/Models/Generators/2.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Generators/2.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Generators/2.col",
		lodDistance=20,
	},

	{
		model=14795,
		txd=":"..RESOURCE_NAME.."/Files/Models/Buildings/Hideouts/1.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Buildings/Hideouts/1.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Buildings/Hideouts/1.col",
		removeWorld=true,
	},

	{
		model=3193,
		txd=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Open.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Open.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Open.col",
		removeWorld=true,lodDistance=300,
	},
	{
		model=3106,
		txd=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Closed.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Closed.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Containers/1_Closed.col",
		removeWorld=true,lodDistance=300,
	},

	{
		model=10983,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF.col",
	},
	{
		model=11340,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF_2.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/ConstructionSF_2.col",
	},
	{
		model=3100,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/EasterEgg.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/EasterEgg.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/EasterEgg.col",
	},
	{
		model=3101,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/Pumpkin.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/Pumpkin.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/Pumpkin.col",
	},
	{
		model=3102,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/XmasBox.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/XmasBox.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/XmasBox.col",
		lodDistance=45,
	},
	{
		model=1900,
		txd=":"..RESOURCE_NAME.."/Files/Models/Other/ATM.txd",
		dff=":"..RESOURCE_NAME.."/Files/Models/Other/ATM.dff",
		col=":"..RESOURCE_NAME.."/Files/Models/Other/ATM.col",
		lodDistance=120,
	},

	--Wearable
	{--Pickaxe
		model=2107,txd=":"..RESOURCE_NAME.."/Files/Models/Wearable/Pickaxe.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wearable/Pickaxe.dff",col=nil,
		removeWorld=true,lodDistance=10,
	},
	{--Dufflebag
		model=3915,txd=":"..RESOURCE_NAME.."/Files/Models/Wearable/Dufflebag.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wearable/Dufflebag.dff",col=nil,
		removeWorld=true,lodDistance=50,
	},

	--Wheels
	--[[ {
		model=2861,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_1.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2866,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_2.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2867,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_3.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2683,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_4.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2767,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_5.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2342,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_6.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2221,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_7.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2222,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_8.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=2223,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_9.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1977,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack1_10.dff",col=nil,
		removeWorld=true,lodDistance=40,
	}, ]]
	--
	{
		model=1941,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_1.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1947,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_2.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1853,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_3.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1854,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_4.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1855,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_5.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1856,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_6.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1857,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_7.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1858,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_8.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1859,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_9.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1860,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_10.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1861,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_11.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1862,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_12.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1863,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_13.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1864,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_14.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1871,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_15.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1872,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Pack2_16.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	--
	{
		model=1877,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic1.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic1.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1878,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic2.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic2.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1879,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic3.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic3.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1880,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic4.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic4.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1881,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic5.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic5.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1882,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic6.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic6.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1901,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic7.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic7.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1902,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic8.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic8.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1903,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic9.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic9.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1904,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic10.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic10.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1911,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic11.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic11.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1921,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic12.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic12.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1930,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic13.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic13.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1931,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic14.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic14.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1932,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic15.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic15.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1933,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic16.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic16.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},
	{
		model=1940,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic17.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/Atomic17.dff",col=nil,
		removeWorld=true,lodDistance=40,
	},

	--[[ 
	{model=1873,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/koks.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/koks.dff",col=nil,removeWorld=true,},

	--Limited Wheels
	{model=1874,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableHamann.dff",col=nil,removeWorld=true,},
	{model=1875,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableVolk.dff",col=nil,removeWorld=true,},
	{model=1876,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableGram.dff",col=nil,removeWorld=true,},
	{model=1899,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableEnKei.dff",col=nil,removeWorld=true,},
	{model=1909,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableRacing.dff",col=nil,removeWorld=true,},
	{model=1910,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableRGII.dff",col=nil,removeWorld=true,},
	{model=1912,txd=":"..RESOURCE_NAME.."/Files/Models/Wheels/Paintable.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Wheels/PaintableWedsSport.dff",col=nil,removeWorld=true,}, ]]

	--Vehicles
	{model=402,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/402.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/402.dff",col=nil,},
	{model=411,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/411.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/411.dff",col=nil,},
	{model=415,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/415.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/415.dff",col=nil,},
	{model=426,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/426.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/426.dff",col=nil,},
	{model=434,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/434.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/434.dff",col=nil,},
	{model=438,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/438.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/438.dff",col=nil,},
	{model=470,txd=nil,dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/470.dff",col=nil,},
	{model=474,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/474.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/474.dff",col=nil,},
	{model=494,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/494.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/494.dff",col=nil,},
	{model=522,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/522.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/522.dff",col=nil,},
	{model=580,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/580.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/580.dff",col=nil,},
	{model=451,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/451.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/451.dff",col=nil,},
	{model=603,txd=":"..RESOURCE_NAME.."/Files/Models/Vehicles/603.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Vehicles/603.dff",col=nil,},


	{model=1010,txd=":"..RESOURCE_NAME.."/Files/Models/Other/Nitro.txd",dff=":"..RESOURCE_NAME.."/Files/Models/Other/Nitro.dff",col=nil,lodDistance=40,},
};

addEventHandler("onClientResourceStart_Custom",resourceRoot,function()
	for i=1,#ModTable do
		if(ModTable[i].txd)then
			if(fileExists(ModTable[i].txd))then
				txdd=engineLoadTXD(ModTable[i].txd);
				engineImportTXD(txdd,ModTable[i].model);
			else
				triggerServerEvent("ModFailKick:S",localPlayer,"txd");
			end
		end
		if(ModTable[i].dff)then
			if(fileExists(ModTable[i].dff))then
				dfff=engineLoadDFF(ModTable[i].dff,ModTable[i].model);
				engineReplaceModel(dfff,ModTable[i].model);
			else
				triggerServerEvent("ModFailKick:S",localPlayer,"dff");
			end
		end
		if(ModTable[i].col)then
			if(fileExists(ModTable[i].col))then
				coll=engineLoadCOL(ModTable[i].col,ModTable[i].model);
				engineReplaceCOL(coll,ModTable[i].model);
			else
				triggerServerEvent("ModFailKick:S",localPlayer,"col");
			end
		end
		if(ModTable[i].removeWorld)then
			removeWorldModel(ModTable[i].model,999999,0,0,0);
		end
		if(ModTable[i].lodDistance)then
			engineSetModelLODDistance(ModTable[i].model,ModTable[i].lodDistance);
		end
	end
end)
addEventHandler("onClientResourceStop",resourceRoot,function()
	for i=1,#ModTable do
		engineFreeModel(ModTable[i].model);
	end
end)

addEventHandler("onClientResourceStart",resourceRoot,function()
	engineSetModelLODDistance(898,150);--searock02 (898)
	engineSetModelLODDistance(899,150);--searock03 (899)
	engineSetModelLODDistance(1775,100);--Sprunk ATM(Active)
	engineSetModelLODDistance(955,100);--Sprunk ATM(Unactive)

	removeWorldModel(4003,15,1481,-1750.7,31.3);--BHF Flags
	removeWorldModel(12854,100,664.1,-570,15.3,0);--Tankstation Dillimore



	local Objects={
		1284,1315,1283,1350,1351,3516,--Trafficlights
		1290,1226,1297,1294,3460,3463,1231,--Lights
		955,1775,--Sprunk ATM
	}
	for _,v in pairs(Objects)do
		removeWorldModel(v,99999,0,0,0);
	end

	--restoreAllWorldModels()
end)


--[[ local function changeVehicleWheelSize(veh)
	if(veh)then
		local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or getElementModel(veh);
		if(VehicleWheelSize[VehicleID])then
			setVehicleModelWheelSize(VehicleID,VehicleWheelSize[VehicleID][1],VehicleWheelSize[VehicleID][2]);
		end
	end
end
addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:VehID"))then
		changeVehicleWheelSize(source);
	end
end) ]]



--Custom Wheels
local function showCustomWheels(veh,bool)
	if(bool)then
		addCustomWheel(veh,bool);
	else
		addCustomWheel(veh);
	end
end
addEventHandler("Vehicle:Preview:Wheels",root,showCustomWheels)

local customWheels={};

local function toggleCustomWheels(veh,id)
	if(id)then
        if(Vehicle.Tuning.ModdedWheels[tonumber(id)])then
			addCustomWheel(veh,tonumber(id));
		else
			setVehicleComponentVisible(veh,"wheel_lf_dummy",true);
			setVehicleComponentVisible(veh,"wheel_rf_dummy",true);
			setVehicleComponentVisible(veh,"wheel_lb_dummy",true);
			setVehicleComponentVisible(veh,"wheel_rb_dummy",true);

			if(customWheels[veh]and isElement(customWheels[veh]["wheel_lf_dummy"]))then
				destroyElement(customWheels[veh]["wheel_lf_dummy"]);
			end
			if(customWheels[veh]and isElement(customWheels[veh]["wheel_rf_dummy"]))then
				destroyElement(customWheels[veh]["wheel_rf_dummy"]);
			end
			if(customWheels[veh]and isElement(customWheels[veh]["wheel_lb_dummy"]))then
				destroyElement(customWheels[veh]["wheel_lb_dummy"]);
			end
			if(customWheels[veh]and isElement(customWheels[veh]["wheel_rb_dummy"]))then
				destroyElement(customWheels[veh]["wheel_rb_dummy"]);
			end

			local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or getElementModel(veh);
			if(Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2])then
				setVehicleModelWheelSize(VehicleID,Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1],Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2]);
			end
	
			customWheels[veh]={};
		end
	else
		setVehicleComponentVisible(veh,"wheel_lf_dummy",true);
		setVehicleComponentVisible(veh,"wheel_rf_dummy",true);
		setVehicleComponentVisible(veh,"wheel_lb_dummy",true);
		setVehicleComponentVisible(veh,"wheel_rb_dummy",true);

		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lb_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rb_dummy"]);
		end

		local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or getElementModel(veh);
		if(Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2])then
			setVehicleModelWheelSize(VehicleID,Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1],Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2]);
		end

		customWheels[veh]={};
	end
end

addEventHandler("onClientElementStreamIn",root,function()
	if(getElementType(source)=="vehicle" and getElementData(source,"Vehicle:Data:Type"))then
		local Wheels=getVehicleJsonValue(source,"Tunings","Wheels")or nil;
		if(Wheels and Wheels~=0 and Wheels~=nil and Vehicle.Tuning.ModdedWheels[tonumber(Wheels)])then
			toggleCustomWheels(source,Wheels);
		else
			toggleCustomWheels(source);
		end
	end
end)
addEventHandler("onClientElementStreamOut",root,function()
	if(getElementType(source)=="vehicle")then
		toggleCustomWheels(source);
	end
end)
addEventHandler("onClientElementDestroy",root,function()
	if(getElementType(source)=="vehicle")then
		toggleCustomWheels(source);
	end
end)






addEventHandler("onClientPreRender",root,function()
	for veh,v in pairs(customWheels)do
		if(veh and isElement(veh)and isElementStreamedIn(veh))then
			local vehicleX,vehicleY,vehicleZ=getElementPosition(veh);
			if(v["wheel_lf_dummy"])then
				local componentX,componentY,componentZ=getVehicleComponentPosition(veh,"wheel_lf_dummy");
				local componentRX,componentRY,componentRZ=getVehicleComponentRotation(veh,"wheel_lf_dummy");
				attachElements(v["wheel_lf_dummy"],veh,componentX,componentY,componentZ,componentRX,componentRY,componentRZ);
			end
			if(v["wheel_rf_dummy"])then
				local componentX,componentY,componentZ=getVehicleComponentPosition(veh,"wheel_rf_dummy");
				local componentRX,componentRY,componentRZ=getVehicleComponentRotation(veh,"wheel_rf_dummy");
				
				attachElements(v["wheel_rf_dummy"],veh,componentX,componentY,componentZ,componentRX,componentRY,componentRZ);
			end

			if(v["wheel_lb_dummy"])then
				local componentX,componentY,componentZ=getVehicleComponentPosition(veh,"wheel_lb_dummy");
				local componentRX,componentRY,componentRZ=getVehicleComponentRotation(veh,"wheel_lb_dummy");
				attachElements(v["wheel_lb_dummy"],veh,componentX,componentY,componentZ,componentRX,componentRY,componentRZ);
			end
			if(v["wheel_rb_dummy"])then
				local componentX,componentY,componentZ=getVehicleComponentPosition(veh,"wheel_rb_dummy");
				local componentRX,componentRY,componentRZ=getVehicleComponentRotation(veh,"wheel_rb_dummy");
				
				attachElements(v["wheel_rb_dummy"],veh,componentX,componentY,componentZ,componentRX,componentRY,componentRZ);
			end
		end
	end
end)

function addCustomWheel(veh,wheels)
	if veh and wheels then
		local vehicleX,vehicleY,vehicleZ=getElementPosition(veh);
		
		local lfX,lfY,lfZ=getVehicleComponentPosition(veh,"wheel_lf_dummy");
		local rfX,rfY,rfZ=getVehicleComponentPosition(veh,"wheel_rf_dummy");
		local lrX,lrY,lrZ=getVehicleComponentPosition(veh,"wheel_lb_dummy");
		local rrX,rrY,rrZ=getVehicleComponentPosition(veh,"wheel_rb_dummy");
		
		setVehicleComponentVisible(veh,"wheel_lf_dummy",false);
		setVehicleComponentVisible(veh,"wheel_rf_dummy",false);
		setVehicleComponentVisible(veh,"wheel_lb_dummy",false);
		setVehicleComponentVisible(veh,"wheel_rb_dummy",false);
		
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lb_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rb_dummy"]);
		end

		customWheels[veh]={};
		
		customWheels[veh]["wheel_lf_dummy"]=createObject(wheels,vehicleX,vehicleY,vehicleZ);
		customWheels[veh]["wheel_rf_dummy"]=createObject(wheels,vehicleX,vehicleY,vehicleZ);
		customWheels[veh]["wheel_lb_dummy"]=createObject(wheels,vehicleX,vehicleY,vehicleZ);
		customWheels[veh]["wheel_rb_dummy"]=createObject(wheels,vehicleX,vehicleY,vehicleZ);

		setElementCollidableWith(customWheels[veh]["wheel_lf_dummy"],veh,false);
		setElementCollidableWith(customWheels[veh]["wheel_rf_dummy"],veh,false);
		setElementCollidableWith(customWheels[veh]["wheel_lb_dummy"],veh,false);
		setElementCollidableWith(customWheels[veh]["wheel_rb_dummy"],veh,false);

		setElementDimension(customWheels[veh]["wheel_lf_dummy"],getElementDimension(veh));
		setElementDimension(customWheels[veh]["wheel_rf_dummy"],getElementDimension(veh));
		setElementDimension(customWheels[veh]["wheel_lb_dummy"],getElementDimension(veh));
		setElementDimension(customWheels[veh]["wheel_rb_dummy"],getElementDimension(veh));
		
		local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or getElementModel(veh);
		if(Vehicle.Tuning.VehicleWheelSizeModded[VehicleID]and Vehicle.Tuning.VehicleWheelSizeModded[VehicleID][1])then
			setObjectScale(customWheels[veh]["wheel_lf_dummy"],Vehicle.Tuning.VehicleWheelSizeModded[VehicleID][1]);
			setObjectScale(customWheels[veh]["wheel_rf_dummy"],Vehicle.Tuning.VehicleWheelSizeModded[VehicleID][1]);
			setObjectScale(customWheels[veh]["wheel_lb_dummy"],Vehicle.Tuning.VehicleWheelSizeModded[VehicleID][1]);
			setObjectScale(customWheels[veh]["wheel_rb_dummy"],Vehicle.Tuning.VehicleWheelSizeModded[VehicleID][1]);
		else
			setObjectScale(customWheels[veh]["wheel_lf_dummy"],0.7);
			setObjectScale(customWheels[veh]["wheel_rf_dummy"],0.7);
			setObjectScale(customWheels[veh]["wheel_lb_dummy"],0.7);
			setObjectScale(customWheels[veh]["wheel_rb_dummy"],0.7);
		end
		
		attachElements(customWheels[veh]["wheel_lf_dummy"],veh,lfX,lfY,lfZ,0,0,0);
		attachElements(customWheels[veh]["wheel_rf_dummy"],veh,rfX,rfY,rfZ,0,0,0);
		attachElements(customWheels[veh]["wheel_lb_dummy"],veh,lrX,lrY,lrZ,0,0,0);
		attachElements(customWheels[veh]["wheel_rb_dummy"],veh,rrX,rrY,rrZ,0,0,0);
	elseif(veh and not wheels)then
		setVehicleComponentVisible(veh,"wheel_lf_dummy",true);
		setVehicleComponentVisible(veh,"wheel_rf_dummy",true);
		setVehicleComponentVisible(veh,"wheel_lb_dummy",true);
		setVehicleComponentVisible(veh,"wheel_rb_dummy",true);

		local VehicleID=tonumber(getElementData(veh,"Vehicle:Data:VehID"))or getElementModel(veh);
		if(Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1]and Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2])then
			setVehicleModelWheelSize(VehicleID,Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][1],Vehicle.Tuning.VehicleWheelSizeOriginal[VehicleID][2]);
		end

		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rf_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rf_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_lb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_lb_dummy"]);
		end
		if(customWheels[veh]and isElement(customWheels[veh]["wheel_rb_dummy"]))then
			destroyElement(customWheels[veh]["wheel_rb_dummy"]);
		end

		customWheels[veh]={};
	end
end