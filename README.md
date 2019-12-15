# Measure Undertale Deaths

This script will create a file that can be used in OBS to display the current total death count.
The count will be automatically updated each time you get a Game Over screen in Undertale.

## Usage

In a PowerShell console, run the following from the folder where you have stored the script.

```powershell
& ./Measure-UndertaleDeathes.ps1
```

In OBS add a Text source for the file `%LOCALAPPDATA%\UndertaleDeathCount.txt`.
The file path can be changed by specifying `OutFile`.

```powershell
& ./Measure-UndertaleDeathes.ps1 -OutFile 'c:\DeathCount.txt'
```

You can also customize the text using the `-Message` Parameter.

```powershell
& ./Measure-UndertaleDeathes.ps1 -OutFile 'c:\DeathCount.txt' -Message '{0} Deaths'
```
