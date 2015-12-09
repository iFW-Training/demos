-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
require ('config')
require ('demoJSON')

function main(Data)
   local MsgIn, MsgName = hl7.parse{vmd="demo.vmd",data=Data}
   
   -- Send through messages only from a given facility
   trace(SendingFacility)
   
   -- This interface is going to process only messages
   -- that match our SendingFacility value.
   if MsgIn.MSH[3][1]:nodeValue() == SendingFacility then
      
      trace (demoJSON)
      
      -- Put JSON string into a table we can work with
      local MsgOut = json.parse{data=demoJSON}
      trace (MsgOut)
      
      -- Start mapping values to JSON message
      MsgOut.facility = MsgIn.MSH[3][1]:nodeValue()
      MsgOut.patient.firstname = MsgIn.PID[5][1][2]:nodeValue()
      MsgOut.patient.lastname = MsgIn.PID[5][1][1][1]:nodeValue()
      MsgOut.patient.gender = MsgIn.PID[8]:nodeValue()
      
      trace (MsgOut)
      
      MsgOut = json.serialize{data=MsgOut}

      -- Send to next stage
      queue.push{data=MsgOut}
      
   else
      -- Ignore and move on to next message
      return
   end
   
end