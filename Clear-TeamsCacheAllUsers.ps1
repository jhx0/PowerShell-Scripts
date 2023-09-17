Get-ChildItem "C:\Users\*\AppData\Roaming\Microsoft\Teams\*" -directory | 
    Where name -in ('application cache','blob storage','databases','GPUcache','IndexedDB','Local Storage','tmp') | 
    ForEach {
        Remove-Item $_.FullName -Recurse -Force
    }
