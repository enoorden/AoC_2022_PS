# AoC2022 Day10 - PowerShell

$data = Get-Content ./day10.input

#part1

$x = 1
$cycles = 0

function check ($x, $c) {
    if ($c -in (20, 60, 100, 140, 180, 220)) { ($x * $c) }
}

$(
    foreach ($d in $data) {
        $cmd, [int]$value = $d -Split ' '
        $cycles++
        check $x $cycles
        if ($cmd -eq 'addx') {
            $cycles++
            check $x $cycles
            $x += $value
        }
    }
) | Measure-Object -Sum