function isActive()
  return not entity.isInboundNodeConnected(0) or entity.getInboundNodeLevel(0) and #pipeUtil.getOutputIds()>0
end 

function getCategory(itemDescriptor)
  if itemDescriptor.parameters and itemDescriptor.parameters.itemName == "generatedgun" then
    return itemDescriptor.parameters.weaponType
  end

  local inRootConfig = pipeUtil.itemConfig(itemDescriptor)
  if inRootConfig then
    return inRootConfig.config.category  
  end 
  
  return nil
end

function canReceiveItem(itemDescriptor)
  if isActive() and itemDescriptor ~= nil then
    local itemCategory = getCategory(itemDescriptor)
    
    if itemCategory then
      for _,item in pairs(world.containerItems(entity.id())) do
        if getCategory(item)==itemCategory then 
          return true
        end 
      end
    end

  end  

  return false
end

function canReceiveLiquid(liquidId, liquidLevel)
  local itemDescriptor = pipeUtil.liquidToItemDescriptor(liquidId, liquidLevel)
  return canReceiveItem(itemDescriptor)
end

function receiveItem(itemDesc)
  return pipeUtil.sendItem(itemDesc)
end

function receiveLiquid(liquidId, liquidLevel)
  return pipeUtil.sendLiquid(liquidId, liquidLevel)
end