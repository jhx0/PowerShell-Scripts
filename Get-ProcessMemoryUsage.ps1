Get-Process | Select-Object ID,CPU,WorkingSet,Name | Where-Object {$_.WorkingSet -gt 200MB}