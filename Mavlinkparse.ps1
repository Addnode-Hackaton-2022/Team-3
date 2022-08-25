<#

10.150.2.141 : 14550
10.150.2.141 : 5760

Kompass
Gyro
Accellerometer
Det inte kan skickar in i gyroflow är gimbal-kompensationen.

#>

function Quaternion-ToYawPitchRoll([System.Numerics.Quaternion]$q) {
    $yaw = [Math]::Atan2([float]2.0 * ($q.Y * $q.W + $q.X * $q.Z), [float]1.0 - [float]2.0 * ($q.X * $q.X + $q.Y * $q.Y));
    $pitch = [Math]::Asin([float]2.0 * ($q.X * $q.W - $q.Y * $q.Z));
    $roll = [Math]::Atan2([float]2.0 * ($q.X * $qY + $qZ * $qW), [float]1.0 - [float]2.0 * ($q.X * $q.X + $q.Z * $q.Z));
    return @{
        "roll" = $roll;
        "pitch" = $pitch;
        "yaw" = $yaw;
    };
}

Add-Type -Path C:\Projects\Hackathon\Team-3\newtonsoft\lib\netstandard2.0\Newtonsoft.Json.dll;
Add-Type -Path C:\Projects\Hackathon\Team-3\mavlink\lib\net461\MAVLink.dll;
$ErrorActionPreference = "Stop";
$parser = [MAVLink+MavlinkParse]::new();

$FTPServer = "10.150.2.141";
$FTPPort = "5760";

$tcpConnection = New-Object System.Net.Sockets.TcpClient($FTPServer, $FTPPort);
$tcpStream = $tcpConnection.GetStream();

$mavlinkMessage = $parser.ReadPacket($tcpStream);

for($i = 0;$i -lt 1000;$i++) {
    #[System.Threading.Thread]::Sleep(1);
    $mavlinkMessage = $parser.ReadPacket($tcpStream);
    #$mavlinkMessage.ToString();
    #if($mavlinkMessage.msgtypename -eq "POSITION_TARGET_GLOBAL_INT") {
    #    $mavlinkMessage.ToString(); # YAW/PITCH/ROLL ???
    #    [MAVLink+mavlink_position_target_global_int_t]$planeRotation = $mavlinkMessage.data;
    #    $planeRotation;
    #}
    if($mavlinkMessage.msgtypename -eq "ATTITUDE") {
        #$mavlinkMessage.ToString(); # Gyro (x/y/z) ???

        <#
            Från servot får vi PITCH och YAW
            Mocka detta data: Yaw = 0.5rad, pitch = -0.25rad        
        #>
        $gimbalYaw = 0;
        $gimbalPitch = -[Math]::Round([Math]::PI/4, 2);

        # Data från planet (attitude)
        [MAVLink+mavlink_attitude_t]$attitude = $mavlinkMessage.data;
        $planeYaw = [Math]::Round($attitude.yaw, 2);
        $planePitch = $([Math]::Round($attitude.pitch, 2));
        $planeRoll = $([Math]::Round($attitude.roll, 2));

        Write-Host "Plane:`t`tyaw: $planeYaw,`tpitch: $planePitch, roll: $planeRoll" -ForegroundColor Green;
        Write-Host "Gimbal`t`tyaw: $gimbalYaw, Gimbalpitch: $gimbalPitch" -ForegroundColor Green;

        $gimbalQuaternion = [System.Numerics.Quaternion]::CreateFromYawPitchRoll($gimbalYaw, $gimbalPitch, 0);
        $planeQuaternion = [System.Numerics.Quaternion]::CreateFromYawPitchRoll($planeYaw, $planePitch, $planeRoll);

        # Kombinera dessa två Quaternions
        [System.Numerics.Quaternion]$combinedQuaternion = [System.Numerics.Quaternion]::Multiply($planeQuaternion, $gimbalQuaternion);
        Write-Host "Resultquaternion: X: $([Math]::Round($combinedQuaternion.X, 2)), Y: $([Math]::Round($combinedQuaternion.Y, 2)), Z: $([Math]::Round($combinedQuaternion.Z, 2)), W: $([Math]::Round($combinedQuaternion.W, 2))" -ForegroundColor Cyan;

        # Ta fram slutgiltig roll/pitch/yaw
        $result = Quaternion-ToYawPitchRoll $combinedQuaternion;

        $resultYaw = $([Math]::Round($result.yaw, 2));
        $resultPitch = $([Math]::Round($result.pitch, 2));
        $resultRoll = $([Math]::Round($result.roll, 2));

        Write-Host "Resultyaw: $resultYaw, Resultpitch: $resultPitch, Resultroll: $resultRoll" -ForegroundColor Yellow;

    }

    <#
    if($mavlinkMessage.msgtypename -eq "SCALED_IMU2") {
        #$mavlinkMessage.ToString(); # Gyro (x/y/z) ???
        echo "SCALED IMU2";
        [MAVLink+mavlink_scaled_imu2_t]$scaledImu2 = $mavlinkMessage.data;
        $scaledImu2;
    }
    echo "=====";
    #>
}
