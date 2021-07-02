# Parameters
param ($paramUsername, $paramPassword, $paramFileShareLetter, $paramFileShareUNC)

# Set file share credentials
$username = "$paramUsername"
$password = ConvertTo-SecureString "$paramPassword" -AsPlainText -Force

# Create Powershell credentials object
$cred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

# Mount drive
New-PSDrive -Name "$paramFileShareLetter" -Root "$paramFileShareUNC" -PSProvider "FileSystem" -Credential $cred

# Debug
dir

# Copy files
Copy-Item "scripts" -Destination "$paramFileShareLetter:\ci_demo" -Recurse

# Disconnect drive
Remove-PSDrive -Name $paramFileShareLetter
