$URL = "icanhazip.com"

Invoke-WebRequest $URL | Select-Object -ExpandProperty Content