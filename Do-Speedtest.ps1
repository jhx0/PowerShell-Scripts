$ProgressPreference = 'SilentlyContinue'
$ConfirmPreference = 'None'

function Get-SpeedTestDownloadLink {
    $url = "https://www.speedtest.net/apps/cli"
    $webContent = Invoke-WebRequest -Uri $url -UseBasicParsing
    if ($webContent.Content -match 'href="(https://install\.speedtest\.net/app/cli/ookla-speedtest-[\d\.]+-win64\.zip)"') {
        return $matches[1]
    } else {
        Write-Output "Unable to find the win64 zip download link."
        return $null
    }
}

function Download-SpeedTestZip {
    param (
        [string]$downloadLink,
        [string]$destination
    )
    Invoke-WebRequest -Uri $downloadLink -OutFile $destination -UseBasicParsing
}

function Extract-Zip {
    param (
        [string]$zipPath,
        [string]$destination
    )
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $destination)
}

function Run-SpeedTest {
    param (
        [string]$executablePath
    )

    $ret = & $executablePath -p no -f json --accept-gdpr --accept-license yes
	
	return $ret | ConvertFrom-Json
}

function Remove-File {
    param (
        [string]$Path
    )
    try {
        if (Test-Path -Path $Path) {
            Remove-Item -Path $Path -Recurse -ErrorAction Stop
        }
    } catch {
        Write-Debug "Unable to remove item: $_"
    }
}

function Remove-Files {
    param(
        [string]$zipPath,
        [string]$folderPath
    )
    Remove-File -Path $zipPath
    Remove-File -Path $folderPath
}

try {
    $tempFolder = $env:TEMP
    $zipFilePath = Join-Path $tempFolder "speedtest-win64.zip"
    $extractFolderPath = Join-Path $tempFolder "speedtest-win64"

    Remove-Files -zipPath $zipFilePath -folderPath $extractFolderPath

    $downloadLink = Get-SpeedTestDownloadLink
    Download-SpeedTestZip -downloadLink $downloadLink -destination $zipFilePath

    Extract-Zip -zipPath $zipFilePath -destination $extractFolderPath

    $executablePath = Join-Path $extractFolderPath "speedtest.exe"
    $output = Run-SpeedTest -executablePath $executablePath
	
	[PSCustomObject]$SpeedObject = @{
		downloadspeed = [math]::Floor($output.download.bandwidth / 1000000 * 8)
		uploadspeed   = [math]::Floor($output.upload.bandwidth / 1000000 * 8)
		isp           = $output.isp
		ExternalIP    = $output.interface.externalIp
	}

	$SpeedTestOutString = "Download Speed: $($SpeedObject.downloadspeed) Mbps", 
						  "Upload Speed: $($SpeedObject.uploadspeed) Mbps",
						  "Public IP Address: $($SpeedObject.ExternalIP)",
						  "ISP: $($SpeedObject.isp)" | Out-String

	Write-Host $SpeedTestOutString

    Remove-Files -zipPath $zipFilePath -folderPath $extractFolderPath
} catch {
    Write-Error "An error occurred: $_"
}