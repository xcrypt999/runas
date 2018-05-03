以其他用户的权限执行命令，并回显

powershell -ep bypass . ./runas.ps1;Invoke-RunAs -username administrator -password "123456" -cmd 'type c:\windows\win.ini'
