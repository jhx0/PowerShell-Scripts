Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

##
# Window
##

$window = New-Object System.Windows.Forms.Form
$window.Text = "DNS Resolver"
$window.Width = 240
$window.Height = 210
$window.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::FixedSingle
$window.MaximizeBox = $False
$window.MinimizeBox = $True
$window.StartPosition = "CenterScreen"

##
# Icon
##

$IconBase64 = "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"
$iconBytes = [Convert]::FromBase64String($iconBase64)
$stream = [System.IO.MemoryStream]::new($iconBytes, 0, $iconBytes.Length)
$window.Icon = [System.Drawing.Icon]::FromHandle(([System.Drawing.Bitmap]::new($stream).GetHIcon()))


##
# GUI Elements
##

$lblDomain = New-Object System.Windows.Forms.Label
$lblDomain.Location = New-Object System.Drawing.Size(10,10)
$lblDomain.Text = "Domain Name:"
$lblDomain.AutoSize = $True

$txtBoxDomain = New-Object System.Windows.Forms.TextBox
$txtBoxDomain.Location = New-Object System.Drawing.Size(10,30)
$txtBoxDomain.Size = New-Object System.Drawing.Size(150,50)

$txtBoxResult = New-Object System.Windows.Forms.TextBox
$txtBoxResult.Location = New-Object System.Drawing.Size(10,60)
$txtBoxResult.Size = New-Object System.Drawing.Size(205,60)
$txtBoxResult.Multiline = $True
$txtBoxResult.Scrollbars = "Vertical"
$txtBoxResult.ReadOnly = $True

$windowBtnResolve = New-Object System.Windows.Forms.Button
$windowBtnResolve.Location = New-Object System.Drawing.Size(10,130)
$windowBtnResolve.Size = New-Object System.Drawing.Size(60,30)
$windowBtnResolve.Text = "Resolve"

$windowBtnExit = New-Object System.Windows.Forms.Button
$windowBtnExit.Location = New-Object System.Drawing.Size(155,130)
$windowBtnExit.Size = New-Object System.Drawing.Size(60,30)
$windowBtnExit.Text = "Exit"

##
# Functions
##

function Get-IPAddress {
  param (
    [string]$Name
  )

  return (Resolve-DnsName -Name $Name).IPAddress
}

$windowBtnResolve.Add_Click({
  $txtBoxResult.Text = ""

  $ResolvedIPs = Get-IPAddress($txtBoxDomain.Text)

  foreach($IP in $ResolvedIPs) {
    $txtBoxResult.Text += $IP
    $txtBoxResult.Text += [Environment]::NewLine
  }
})

$windowBtnExit.Add_Click({
  $window.Close()
})

##
# Add controls
##

$window.Controls.Add($lblDomain)
$window.Controls.Add($txtBoxDomain)
$window.Controls.Add($txtBoxResult)
$window.Controls.Add($windowBtnResolve)
$window.Controls.Add($windowBtnExit)

$window.AcceptButton = $windowBtnResolve

##
# Show Form
##

$window.ShowDialog()