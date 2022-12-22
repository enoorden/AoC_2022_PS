# AoC2022 Day5 - PowerShell

$data = Get-Content ./day05.input

#process input into stacks
function getStack ($data) {
    $stacks = @{}

    $t = $data.IndexOf(($data | Where-Object { $_ -like ' 1   2*' } ))
    $nrOfStacks = ($data[$t] -replace '\s').Length

    1..$nrOfStacks | ForEach-Object {
        $stack = $_
        $stacks[$stack] = [System.Collections.Generic.List[object]]@()
        0..($t - 1) | ForEach-Object {
            $crate = $data[$_].subString(1 + (($stack - 1) * 4), 1)
            if (-not [string]::IsNullOrWhiteSpace($crate)) {
                $stacks[$stack].Add($crate)
            }
        }
    }
    $stacks
}

#part1
$stacks = getStack $data
foreach ($d in $data | Where-Object { $_ -like 'Move*' }) {
    [int]$times, [int]$from, [int]$to = $d.split()[1, 3, 5]
    1..$times | ForEach-Object {
        $crate = $stacks[$from][0]
        $stacks[$from].RemoveAt(0)
        $stacks[$to].Insert(0, $crate)
    }
}

$($stacks.GetEnumerator() | Sort-Object Name | ForEach-Object {
        $_.value[0]
    }) -join ''

#part2
#process input into stacks
$stacks = getStack $data

foreach ($d in $data | Where-Object { $_ -like 'Move*' }) {
    [int]$times, [int]$from, [int]$to = $d.split()[1, 3, 5]
    $crates = $stacks[$from][0..($times - 1)]
    1..$times | ForEach-Object { $stacks[$from].RemoveAt(0) }
    $stacks[$to].InsertRange(0, $crates)
}

$($stacks.GetEnumerator() | Sort-Object Name | ForEach-Object {
        $_.value[0]
    }) -join ''