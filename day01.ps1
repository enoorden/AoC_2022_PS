# AoC2022 Day1 - PowerShell

$data = Get-Content ./day01.input

$elves = @()
$total = 0

foreach ($d in $data) {
    if ([int]::TryParse($d, [ref]$null)) {
        $total += [int]$d
    }
    else {
        $elves += $total
        $total = 0
    }
}

#part1
$elves | Sort-Object -Descending -Top 1

#part2
($elves | Sort-Object -Descending -Top 3 | Measure-Object -Sum).Sum