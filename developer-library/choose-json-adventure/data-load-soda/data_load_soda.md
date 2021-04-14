# Loading JSON into the Autonomous Database Part 1: JSON Documents and SODA


> curl -u "gary:WElcome11##11" -i -X PUT https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelays

curl -u "gary:WElcome11##11" -i -X PUT https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelayscollection


HTTP/1.1 201 Created
Date: Wed, 14 Apr 2021 17:09:04 GMT
Content-Length: 0
Connection: keep-alive
X-Frame-Options: SAMEORIGIN
Cache-Control: private,must-revalidate,max-age=0
Location: https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/planeDelays/


curl -i -X POST -u "gary:WElcome11##11" -d @airportDelays.json -H "Content-Type: application/json" "https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/planeDelays?action=insert"

curl -i -X POST -u "gary:WElcome11##11" -d @airportDelays.json -H "Content-Type: application/json" "https://bqj5jpf7pvxppq5-adb21.adb.eu-frankfurt-1.oraclecloudapps.com/ords/gary/soda/latest/airportdelayscollection?action=insert"


HTTP/1.1 100 Continue

HTTP/1.1 200 OK
Date: Wed, 14 Apr 2021 17:15:38 GMT
Content-Type: application/json
Content-Length: 736197
Connection: keep-alive
X-Frame-Options: SAMEORIGIN
Cache-Control: private,must-revalidate,max-age=0

{
  "Statistics.# of Delays.Weather": {
    "$gt": 15
  }
}