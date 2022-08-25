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

$ErrorActionPreference = "Stop";

$gimbalYaw = 0;
$gimbalPitch = -[Math]::Round([Math]::PI/4, 2);

# Data från planet (attitude)
$planeYaw = 0;
$planePitch = 0;
$planeRoll = [Math]::Round([Math]::PI/4, 2);

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

