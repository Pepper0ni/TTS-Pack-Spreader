function onLoad()
 curColumn=9
 local selfScale=self.getScale()
 local params={
 function_owner=self,
 label='Spread Compact',
 tooltip="Spreads the contained objects close together",
 font_size=180,
 width=1500,
 height=220,
 scale={1/selfScale.x,1/selfScale.y,1/selfScale.z},
 position={0,1,2.5},
 click_function='SpreadCompact'
 }
 self.createButton(params)

 params.position[3]=3
 params.label='Spread Wide'
 params.tooltip="Spreads the packs wide enough to not collide when opening."
 params.click_function='SpreadWide'
 self.createButton(params)

 params.position[3]=3.5
 params.tooltip="The number of packs per column"
 params.value=tostring(curColumn)
 params.alignment=3
 params.input_function="SetColumn"
 params.font_color={0,0,0}
 self.createInput(params)
end

function SetColumn(obj,color,value,selected)
 if not selected then
  curColumn=checkIfNum(value,1000,curColumn,color)
  return tostring(curColumn)
 end
end

function checkIfNum(value,max,current,color)
 local numValue=tonumber(value)
 if numValue!=nil then
  numValue=math.floor(numValue)
  if numValue>0 then
   if numValue<=max then return numValue else broadcastToColor("Enter a lower number.",color,{1,0,0})end
  else broadcastToColor("Enter a number above 0.",color,{1,0,0})end
 else broadcastToColor("Enter a number.",color,{1,0,0})end
 return current
end

function SpreadCompact()
 Spread(-4)
end

function SpreadWide()
 Spread(-32)
end

function Spread(width)
 for c,pack in pairs(self.getObjects())do
  self.takeObject({position=self.positionToWorld({width*math.floor((c-1)/curColumn),1,7+6*((c-1)%curColumn)}),smooth=true})
 end
end
