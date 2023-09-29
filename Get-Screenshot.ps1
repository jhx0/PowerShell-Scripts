param (
    [switch]$All = $false
)

Add-Type -AssemblyName System.Windows.Forms
Add-type -AssemblyName System.Drawing

$SavePath = $HOME + "\"
$FileName = "Screenshot_" + (Get-Date -Format "MM-dd-yyyy_HH-mm-ss").ToString() + ".png"

if($All) {
    $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen
} else {
    $Screen = [System.Windows.Forms.SystemInformation]::PrimaryMonitorSize
}

$Width = $Screen.Width
$Height = $Screen.Height
$Left = $Screen.Left
$Top = $Screen.Top

$Bitmap = New-Object System.Drawing.Bitmap $Width, $Height
$Graphic = [System.Drawing.Graphics]::FromImage($Bitmap)
$Graphic.CopyFromScreen($Left, $Top, 0, 0, $Bitmap.Size)

$Bitmap.Save($SavePath + $FileName) 