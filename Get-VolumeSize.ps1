 Get-Volume | Select-Object DriveLetter,
    @{
        Name = 'SizeRemaining'
        Expression = {[math]::round($_.SizeRemaining / 1GB)}
    },
    @{
        Name = 'Size'
        Expression = {[math]::round($_.Size / 1GB)}
    }