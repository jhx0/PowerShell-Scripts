$VBox = $Env:Programfiles + "\Oracle\VirtualBox\VBoxManage.exe"

$VMs = "VM-1", "VM-2", "VM-3"

foreach($VM in $VMS) {
    & $vbox startvm $VM
}
