$url = 'https://github.com/Securepoint/openvpn-client/releases/download/2.0.40/openvpn-client-installer-2.0.40.msi'

try {
	Invoke-WebRequest -Uri $url -OutFile "vpn.msi"
} catch {
	Write-Host $_
}

Start-Process msiexec.exe -Wait -ArgumentList '/qn /i vpn.msi CWINVERSION=10'
