<#
    .SYNOPSIS
        Updates a file with the total deaths in Undertale.
    .DESCRIPTION
        On Windows system, this script will parse the undertale.ini and update a file with the
        total death count. This can be used by OBS as a text source to display the current 
        death count you have taken in Undertale.
    .PARAMETER IniFile
        The full paul to the undertale.ini file. defaults to %LOCALAPPDATA%\UNDERTALE\undertale.ini
    .PARAMETER OutFile
        The output file that the death count in which the death count will be stored. This
        file can be used as a text source in OBS. Defaults to 
        %LOCALAPPDATA%\UndertaleDeathCount.txt
    .PARAMETER Message
        The message that will be set in the OutFile. Use '{0}' to represent the death count.
        Defaults to 'Undertale Deaths: {0}'.
    .PARAMETER Offset
        Number of deaths to offset the count by. This will be added to the death count. Use a negative number
        to decrease the death count. For example, if you are starting a new Undertale run and currently 
        have 167 total deaths, you can use an offset of -167 to track just the number of deaths in the current run.
    .EXAMPLE
        & ./Measure-UndertaleDeaths.ps1
    .EXAMPLE
        & ./Measure-UndertaleDeaths.ps1 -Message 'Deaths: {0}'
    .EXAMPLE
        & ./Measure-UndertaleDeaths.ps1 -OutFile c:\DeathCount.txt
    .EXAMPLE
        & ./Measure-UndertaleDeaths.ps1 -IniFile 'C:\Users\Mark\AppData\Local\UNDERTALE\undertale.ini'
    .NOTES
        This currently only supports Undertale on Windows.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [String]
    $IniFile = (Join-Path $env:LOCALAPPDATA "UNDERTALE\undertale.ini"),

    [Parameter()]
    [String]
    $OutFile = (Join-Path $env:LOCALAPPDATA "UndertaleDeathCount.txt"),

    [Parameter()]
    [String]
    $Message = 'Undertale Deaths: {0}',

    [Parameter()]
    [Int]
    $Offset = 0
)

while ($true) {
    try {
        $Result = Get-Content $IniFile -ErrorAction Stop | Select-String "gameover"
        [int]$Count = ($Result.Line -split '=')[1] -replace '"'
        $Content = $Message -f ($Count + $Offset)
        Clear-Host
        Write-Host $Content
        $Content | Set-Content $OutFile -ErrorAction Stop
        Start-Sleep -Milliseconds 500
    } catch {}
}