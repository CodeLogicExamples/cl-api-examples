# VARIABLES
# CodeLogic user name.
$USERNAME = 'YOUR_USERNAME_HERE'
# CodeLogic password.
$PASSWORD = 'YOUR_PASSWORD_HERE'
# URL encode the USERNAME.
$USERENCODED = [System.Uri]::EscapeDataString($USERNAME)
# URL encode the PASSWORD.
$PASSENCODED = [System.Uri]::EscapeDataString($PASSWORD)
# The url/ip address of your CodeLogic instance. Example: http://192.168.0.74, or https://codelogichost.com.
$CODELOGICURL = 'YOUR_CODELOGIC_HOST'

# Get Bearer token.
$tokenResponse = Invoke-RestMethod -Method Post -Uri ("{0}/codelogic/server/authenticate" -f $CODELOGICURL) -Headers @{"accept" = "application/json"; "Content-Type" = "application/x-www-form-urlencoded"} -Body ("password={0}&username={1}" -f $PASSENCODED, $USERENCODED)
$TOKEN = $tokenResponse.access_token

# Get all endpoints, and output to CSV.
$endpointCsvPath = "endpoint.csv"
Invoke-RestMethod -Method Get -Uri ("{0}/codelogic/server/tabular/nodes/csv?itemTypes=Endpoint" -f $CODELOGICURL) -Headers @{"accept" = "text/csv"; "Authorization" = "Bearer $TOKEN"} -OutFile $endpointCsvPath
