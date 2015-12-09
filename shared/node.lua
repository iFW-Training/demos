

-- Coerce a node value into a string.
--
function node:S()
   return tostring(self)
end
function node:V()
   return self:nodeValue()
end
  -- round node real number value to count of decimal places function       
function node.round(self, p)        
   local o = 10^(p or 0)       
   return math.floor(self*o+0.5)/o    
end  
function node.childIndex(Node, Name)
   for i=1, #Node do
      if Node[i]:nodeName() == Name then 
         return i 
      end
   end  
   return nil
end
