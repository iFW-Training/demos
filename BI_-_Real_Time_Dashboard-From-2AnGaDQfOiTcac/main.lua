require 'iguanaServer'
require 'node'
-- The main function is the first function called from Iguana.
function main()
   
   
   -- api_query
   local LOGS = 'http://localhost:6543/api_query'
   
   -- only queries the last hour
   local Time = os.ts.date("%Y/%m/%d %X", os.ts.time() - 60 * 60)
   local Before = os.ts.date("%Y/%m/%d %X", os.ts.time())

   local AUTH = {}
   AUTH.username = 'admin'
   AUTH.password = 'password'

   local LogList = net.http.post{
      url=LOGS,
      auth=AUTH, 
      parameters={type='message', after=Time, before=Before, filter='MSH', source='BI - ADT Generator'},
      live=true
   }
   
   -- Dashboarding: log_api
   local LogTree = xml.parse{data=LogList}
   local dr = {}
   local location = {}
   local lcation_tbl = {}
   local counter_tbl = {}
   local counter_tbl2 = {}
   local tbl = {}
   local cityTotal = {}
   
   dr.komorov = 0
   dr.lupul = 0
   dr.kessel = 0
   dr.gardiner = 0
   dr.reilly = 0
   
   location.toronto = 0
   location.chicago = 0
   location.la = 0
   location.stlouis = 0
   
   for x=1, LogTree.export:childCount("message") do 
      local Msg = hl7.parse{vmd='ran/demo.vmd', data=LogTree.export:child('message', x).data:nodeValue()}      
      
      if Msg.PV1[8][1]:S() == '^Komorov^Leo^^^DR' then
         dr.komorov = dr.komorov + 1
      elseif Msg.PV1[8][1]:S() == '^Lupul^Amy^^^DR' then
         dr.lupul = dr.lupul + 1
      elseif Msg.PV1[8][1]:S() == '^Kessel^Phil^^^DR' then
         dr.kessel = dr.kessel + 1
      elseif Msg.PV1[8][1]:S() == '^Gardiner^Jenny^^^DR' then
         dr.gardiner = dr.gardiner + 1
      elseif Msg.PV1[8][1]:S() == '^Reilly^Morgan^^^DR' then
         dr.reilly = dr.reilly + 1
      end
      
      if Msg.PID[11][1][3]:S() == 'Chicago' then
         location.chicago = location.chicago + 1
      elseif Msg.PID[11][1][3]:S() == 'Toronto' then
         location.toronto = location.toronto + 1
      elseif Msg.PID[11][1][3]:S() == 'LA' then
         location.la = location.la + 1
      elseif Msg.PID[11][1][3]:S() == 'ST. LOUIS' then
         location.stlouis = location.stlouis + 1         
      end
   end
   
   -- Location Map
   -- Chicago
   lcation_tbl.value = {}
   lcation_tbl.value.ip = '184.154.83.119'
   lcation_tbl.value.value = location.chicago
   lcation_tbl.value.info = 'Chicago, IL'
   data = lcation_tbl
   url = 'https://push.ducksboard.com/v/579602'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   -- Toronto
   lcation_tbl.value = {}
   lcation_tbl.value.ip = '192.206.151.131'
   lcation_tbl.value.value = location.toronto
   lcation_tbl.value.info = 'Toronto, ON'
   data = lcation_tbl
   url = 'https://push.ducksboard.com/v/579602'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   -- LA
   lcation_tbl.value = {}
   lcation_tbl.value.ip = '134.201.250.155'
   lcation_tbl.value.value = location.la
   lcation_tbl.value.info = 'LA, CA'
   data = lcation_tbl
   url = 'https://push.ducksboard.com/v/579602'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   -- St. Louis
   lcation_tbl.value = {}
   lcation_tbl.value.ip = '173.224.119.188'
   lcation_tbl.value.value = location.stlouis
   lcation_tbl.value.info = 'ST. LOUIS, MO'
   data = lcation_tbl
   url = 'https://push.ducksboard.com/v/579602'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   -- Message Count
   counter_tbl.value = LogTree.export:childCount("message")
   data = counter_tbl
   url = 'https://push.ducksboard.com/v/579643'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   -- Doctor Bars
   tbl.value = dr.komorov
   data = tbl
   url = 'https://push.ducksboard.com/v/579658'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   tbl.value = dr.lupul
   data = tbl
   url = 'https://push.ducksboard.com/v/579659'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   tbl.value = dr.kessel
   data = tbl
   url = 'https://push.ducksboard.com/v/579660'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   tbl.value = dr.gardiner
   data = tbl
   url = 'https://push.ducksboard.com/v/579661'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   tbl.value = dr.reilly
   data = tbl
   url = 'https://push.ducksboard.com/v/579662'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   
   -- Total by city
   cityTotal.value = location.la
   cityTotal.info = 'LA'
   data = cityTotal
   url = 'https://push.ducksboard.com/v/715027'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}

   cityTotal.value = location.stlouis
   cityTotal.info = 'STL'
   data = cityTotal
   url = 'https://push.ducksboard.com/v/715028'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
    
   cityTotal.value = location.chicago
   cityTotal.info = 'CHI'
   data = cityTotal
   url = 'https://push.ducksboard.com/v/715029'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
    
   cityTotal.value = location.toronto
   cityTotal.info = 'TOR'
   data = cityTotal
   url = 'https://push.ducksboard.com/v/715030'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}
   
   counter_tbl2.value = LogTree.export:childCount("message") * 2
   trace(counter_tbl2)
   data = counter_tbl2
   url = 'https://push.ducksboard.com/v/699061'
   AUTH.username = 'KVRo9Z34oGeR58JKf5rEP0d8CMWdCMZY9qaeltW71jdfCRa53L:unused'
   net.http.post{url=url,auth=AUTH,body=json.serialize{data=data},live=true}

end