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



function generateRedeemCode()
    local randomLength=(math.random(6,7));

    local run=1;
    while true do
        if(run>=20)then
            break;
        else
            run=run+1;
        end

        local rdmCode=string.upper(GetRandomLetterCode(8))..string.upper(GetRandomNumberCode(randomLength));
        local result=dbPoll(dbQuery(Database.Connection,"SELECT ?? FROM ?? WHERE ??=?","Code","Codes","Code",rdmCode),-1);
        if(not result or not result[1])then
            ResultCode=rdmCode;
            break;
        end
    end
	if(ResultCode==nil)then
        return generateRedeemCode();
    else
        return ResultCode;
	end
end

GetRandomLetterCode=function(length)
	if(length>0)then
		return GetRandomLetterCode(length-1)..Charset[math.random(1,#Charset)];
	else
		return "";
	end
end
GetRandomNumberCode=function(length)
	return length>0 and GetRandomNumberCode(length-1)..NumberCharsetPlate[math.random(1,#NumberCharsetPlate)]or "";
end