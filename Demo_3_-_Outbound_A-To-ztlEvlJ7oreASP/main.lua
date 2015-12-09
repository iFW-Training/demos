-- The main function is the first function called from Iguana.
-- The Data argument will contain the message to be processed.
function main(Data)
   API = 'http://localhost:6550/demo/' .. 'AcmeMed'
   
   headers = {}
   headers['Content-Type'] = 'application/json'
   local response, errors, headers = net.http.post{url=API,body=Data,headers=headers,live=true}
   
   iguana.logInfo(response)
end