-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   local r = net.http.parseRequest{data=Data}
   trace (r)
   net.http.respond{body="Success!"}
   
   iguana.logInfo(Data)
   return
end