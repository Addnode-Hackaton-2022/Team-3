<#

10.150.2.141 : 14550
10.150.2.141 : 5760

Kompass
Gyro
Accellerometer
Det inte kan skickar in i gyroflow är gimbal-kompensationen.

#>

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
    if($mavlinkMessage.msgtypename -eq "RAW_IMU") {
        #$mavlinkMessage.ToString(); # Gyro (x/y/z) ???
        echo "RAW IMU";
        [MAVLink+mavlink_raw_imu_t]$planeImu = $mavlinkMessage.data;
        $planeImu;
    }
    if($mavlinkMessage.msgtypename -eq "SCALED_IMU2") {
        #$mavlinkMessage.ToString(); # Gyro (x/y/z) ???
        echo "SCALED IMU2";
        [MAVLink+mavlink_scaled_imu2_t]$scaledImu2 = $mavlinkMessage.data;
        $scaledImu2;
    }
    echo "=====";
}
