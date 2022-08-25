# Sätt aktuell sökväg till scriptets hemfolder så att relativa sökvägar fungerar som det är tänkt
cls;
$scriptpath = $PSScriptRoot
Set-Location $scriptpath;
$error.Clear();
$ErrorActionPreference = "Stop";



# Yaw = Z, Pitch = Y, Roll = X
function To-Quaternion ([double]$yaw, [double]$pitch, [double]$roll) {
    return [System.Numerics.Quaternion]::CreateFromYawPitchRoll($yaw, $pitch, $roll);
}
function Combine-Quaternions ([System.Numerics.Quaternion]$q1, [System.Numerics.Quaternion]$q2) {
    return [System.Numerics.Quaternion]::Multiply($q1, $q2);
}

#Combine-Quaternions -q1 @{"x"=0.5;"y"=0;"z"=0;"w"=1;} -q2 @{"x"=0;"y"=0;"z"=0;"w"=1;}

function Read-TlogBinary([string]$fileName) {

    $stream = [System.IO.File]::Open("$scriptpath\$fileName", [System.IO.FileMode]::Open)
    $reader = New-Object System.IO.BinaryReader ($stream, [System.Text.Encoding]::UTF8, $false);
    $byteArray = @();
    for($i = 0;$i -lt 102;$i++) {

        $byte = $reader.ReadByte();
        #Write-Host $([System.Text.Encoding]::ASCII.GetString($byte)) -NoNewline;
        $byteArray += $byte;
        [System.Convert]::ToChar($reader.ReadByte())

    }
    [System.Text.Encoding]::UTF8.GetString($byteArray);
    $byteArray.Length
}