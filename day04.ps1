# AoC2022 Day4 - PowerShell

$data = Get-Content ./day04.input

#part1
$total = 0
foreach ($d in $data) {
    [int]$r1s, [int]$r1e, [int]$r2s, [int]$r2e = $d -split ',|-'
    if ((($r1s -ge $r2s) -and ($r1e -le $r2e)) -or (($r2s -ge $r1s) -and ($r2e -le $r1e))) {
        $total++
    }
}
$total

#part2
$total = 0
foreach ($d in $data) {
    [int]$r1s, [int]$r1e, [int]$r2s, [int]$r2e = $d -split ',|-'
    if ($r1s -in $r2s..$r2e -or $r1e -in $r2s..$r2e -or $r2s -in $r1s..$r1e) { $total++ }
}
$total