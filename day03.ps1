# AoC2022 Day3 - PowerShell

$data = Get-Content ./day03.input

#part1
$total = 0
foreach ($d in $data) {
    $l = $d.Length / 2
    $r1 = $d.Substring(0, $l)
    $r2 = $d.Substring($l, $l)
    $matching = ([char[]]$r1).foreach({ if ($r2.Contains($_)) { $_ } }) | Select-Object -First 1
    $total += [int]$matching - ([int]$matching -gt 90 ? 96 : 38)
}
$total

#part2
$total = 0
for ($i = 0; $i -lt $data.Count; $i += 3) {
    $matching = ([char[]]$data[$i]).foreach({ if ($data[$i + 1].Contains($_) -and $data[$i + 2].Contains($_)) { $_ } }) | Select-Object -First 1
    $total += [int]$matching - ([int]$matching -gt 90 ? 96 : 38)
}
$total