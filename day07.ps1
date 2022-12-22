# AoC2022 Day7 - PowerShell
Remove-Variable data
$data = Get-Content ./day07.input

$dirs = @{}
$currentDir = [System.Collections.Generic.List[string]]@()

foreach ($d in $data) {
    $a, $b, $c = $d -split ' '
    if ($b -eq 'cd') {
        switch ($c) {
            '..' { $currentDir.RemoveAt($currentDir.count - 1) }
            default {
                $currentDir.Add($c)
                $dirs.Add(($currentDir -join '/'), 0)
            }
        }
    }
    elseif ($a -ne '$' -and $a -ne 'dir') {
        for ($i = 0; $i -lt $currentDir.Count; $i++) {
            $dirs[($currentDir[0..$i] -join '/')] += [int]$a
        }
    }
}

($dirs.GetEnumerator() | Where-Object { $_.value -lt 100000 } | Measure-Object Value -Sum).Sum

#Part2
$freeSpace = 70000000 - $dirs['/']
($dirs.GetEnumerator() | Where-Object { ($freeSpace + $_.value) -ge 30000000 } | Sort-Object Value | Select-Object -First 1).Value