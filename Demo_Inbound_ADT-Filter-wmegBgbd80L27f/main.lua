-- ## The main function is the first function called from Iguana.
-- ## The Data argument will contain the message to be processed.
function main(Data)
   
   -- ## Parse incoming message into predefined message grammar
   -- ## We are turning strings into tables here
   Msg, MsgName, Warnings = hl7.parse{vmd="demo.vmd",data=Data}
   
   -- ## Build outgoing message
   MsgOut = hl7.message{vmd="demo.vmd", name="ADT"}
   -- ## Map over values (original is read-only)
   MsgOut:mapTree(Msg)
   
   -- ## Set filter flag
   local filter = false
   
   -- ## Filter messages based on errors and log warnings
   for i=1, #Warnings do
      if Warnings[i].important == true then
         iguana.logError(Warnings[i].description)
         --filter = true
      else
         iguana.logWarning(Warnings[i].description) 
      end      
   end
   
   if filter == true then
      return;
   else
	queue.push{data=MsgOut:S()}
   end
   
   
end