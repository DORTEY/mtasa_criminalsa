addRemoteEvents{"Sound:Sync:3D","Sound:Destroy:3D"};--addEvent


local Sounds={};


addEventHandler("Sound:Sync:3D",root,function(element,attach,sound,stack,distance,coords)
    if(element and isElement(element))then
        if(fileExists(":"..RESOURCE_NAME.."/Files/Audio/"..sound))then
            if(not(stack))then
                if(Sounds[element]and isElement(Sounds[element]))then
                    destroyElement(Sounds[element]);
                    Sounds[element]=nil;
                end
            end

            Sounds[element]=playSound3D(":"..RESOURCE_NAME.."/Files/Audio/"..sound,coords[1],coords[2],coords[3]);
            if(attach)then
                attachElements(Sounds[element],element);
            end
            setElementDimension(Sounds[element],getElementDimension(element));
            setElementInterior(Sounds[element],getElementInterior(element));
            setSoundMaxDistance(Sounds[element],distance);
        end
    end
end)

addEventHandler("Sound:Destroy:3D",root,function(element)
    if(element and isElement(Sounds[element]))then
        if(Sounds[element]and isElement(Sounds[element]))then
            destroyElement(Sounds[element]);
            Sounds[element]=nil;
        end
    end
end)