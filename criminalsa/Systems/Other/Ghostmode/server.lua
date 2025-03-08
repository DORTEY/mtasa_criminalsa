addRemoteEvents{"toggleGhostMode"};--addEvents


local ghostModes={};

function toggleGhostMode(element,bool,time)
	if(isElement(element))then
		if(bool==true and type(time)=="number" and tonumber(time)>=50)then
			triggerClientEvent(root,"toggleGhostModeClient",root,element,false)
			setElementData(element,"GhostMode",false)
			setElementAlpha(element,135)
			
			if(isElement(element))then
				setTimer(function(element)
					if(isElement(element))then
						setTimer(function(element)
							if(isElement(element))then
								local new=getElementAlpha(element)+5
								if(new>255)then
									new=255
								end
								setElementAlpha(element,new)
							end
						end,90,24,element)
						if(isElement(element))then
							setTimer(function(element)
								if(isElement(element))then
									setElementAlpha(element,255)
									triggerClientEvent(root,"toggleGhostModeClient",root,element,true)
									setElementData(element,"GhostMode",true)
								end
							end,90*24+50,1,element)
						end
					end
				end,time,1,element)
			end
			
		else
			triggerClientEvent(root,"toggleGhostModeClient",root,element,(not bool))
			
			setElementData(element,"GhostMode",(not bool))
			
			local a=135
			if(bool==false)then
				a=255
			end
			setElementAlpha(element,a)
		end
	end
end
addEventHandler("toggleGhostMode",root,toggleGhostMode)