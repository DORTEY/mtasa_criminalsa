local Charset={};
local NumberCharsetPlate={};

for i=65,90 do
	table.insert(Charset,string.char(i));
end
for i=97,122 do
	table.insert(Charset,string.char(i));
end

for i=48,57 do
	table.insert(NumberCharsetPlate,string.char(i));
end



function generateVehiclePlate()
    local randomLength=(math.random(3,4));

    local run=1;
    while true do
        if(run>=20)then
            break;
        else
            run=run+1;
        end

        local rdmPlate=string.upper(GetRandomLetter(3)).." "..string.upper(GetRandomNumber(randomLength));
        local result=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE ??=?","Plate","Vehicles","Plate",rdmPlate),-1);
        if(not result or not result[1])then
            ResultPlate=rdmPlate;
            break;
        end
    end
	if(ResultPlate==nil)then
        return generateVehiclePlate();
    else
        return ResultPlate;
	end
end

GetRandomLetter=function(length)
	if(length>0)then
		return GetRandomLetter(length-1)..Charset[math.random(1,#Charset)];
	else
		return "";
	end
end
GetRandomNumber=function(length)
	return length>0 and GetRandomNumber(length-1)..NumberCharsetPlate[math.random(1,#NumberCharsetPlate)]or "";
end