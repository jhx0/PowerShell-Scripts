Add-Type -AssemblyName PresentationFramework

##
# Hide PowerShell Console
##
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0)
###

##
# WPF GUI
##
[xml]$xaml = @"
<Window 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"

        Title="NIC Team Generator" ResizeMode="NoResize" Height="300" Width="335">
    <Grid>
		<TextBox x:Name="txtBoxNIC" FontWeight="Bold" FontSize="14" IsReadOnly="True" HorizontalAlignment="Left" Margin="10,51,0,0" TextWrapping="Wrap" VerticalAlignment="Top" Width="300" Height="100"/>
		<Button x:Name="btnGet" Content="Get" HorizontalAlignment="Left" Margin="10,10,0,0" VerticalAlignment="Top" Height="24" Width="90"/>
		<Label x:Name="lblCMD" Content="PowerShell Befehl:" HorizontalAlignment="Left" Margin="5,150,0,0" VerticalAlignment="Top"/>
		<TextBox x:Name="txtBoxCMD" IsReadOnly="True" HorizontalAlignment="Left" Margin="10,178,0,0" TextWrapping="Wrap" Text="" VerticalAlignment="Top" Width="300" Height="70"/>
    </Grid>
</Window>
"@

##
# Functions
##
function Get-NetAdapters {
	return (Get-NetAdapter -Name "*" -Physical).Name
}

function Generate-NICCommand {
	$NICS = (Get-NetAdapter -Name "*" -Physical).Name
	
	$CMD = "New-VMSwitch -Name `"SET Team`" -NetAdapterName "
	foreach ($nic in $NICS) {
		$CMD += "`"" + $nic + "`","
	}
	
	return $CMD.TrimEnd(",")
}

##
# Main
##
$reader = (New-Object System.Xml.XmlNodeReader $xaml)
$window = [Windows.Markup.XamlReader]::Load($reader)

$btnGet = $window.FindName("btnGet")
$txtBoxNIC = $window.FindName("txtBoxNIC")
$txtBoxCMD = $window.FindName("txtBoxCMD")

$btnGet.add_Click({
	$txtBoxNIC.Text = ""
	$txtBoxNIC.Text = Get-NetAdapters
	
	$txtBoxCMD.Text = ""
	$txtBoxCMD.Text = Generate-NICCommand
})

$window.ShowDialog() | Out-Null