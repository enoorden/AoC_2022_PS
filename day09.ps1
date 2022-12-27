# AoC2022 Day9 - PowerShell

$data = Get-Content ./day09.input

$stopwatch = [system.diagnostics.stopwatch]::StartNew()

$h = @(0, 0)
$t = @(0, 0)

$visited = @{}
foreach ($d in $data) {
    $dir, $steps = $d.split(' ')
    1..$steps | ForEach-Object {
        switch ($dir) {
            'U' { $h[0]++ }
            'D' { $h[0]-- }
            'L' { $h[1]-- }
            'R' { $h[1]++ }
        }

        if (([math]::abs($t[0] - $h[0]) -le 1) -and ([math]::abs($t[1] - $h[1]) -le 1)) { }
        elseif ($t[0] -eq $h[0]) {
            $t[1] += ($h[1] - $t[1]) / 2
        }
        elseif ($t[1] -eq $h[1]) {
            $t[0] += ($h[0] - $t[0]) / 2
        }
        else {
            $step0 = ($h[0] - $t[0]) / 2
            $step1 = ($h[1] - $t[1]) / 2

            $t[0] += $step0 -gt 0 ? [math]::Ceiling($step0) : [math]::Floor($step0)
            $t[1] += $step1 -gt 0 ? [math]::Ceiling($step1) : [math]::Floor($step1)
        }
        $visited[($t -join ';')] = 1
    }
}

$visited.count
$stopwatch.Elapsed.TotalSeconds


#part2
$knots = @(@(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0), @(0, 0))

$visited = @{}
foreach ($d in $data) {
    $dir, $steps = $d.split(' ')
    1..$steps | ForEach-Object {
        switch ($dir) {
            'U' { $knots[0][0]++ }
            'D' { $knots[0][0]-- }
            'L' { $knots[0][1]-- }
            'R' { $knots[0][1]++ }
        }

        1..9 | ForEach-Object {
            $knot = $_
            if (([math]::abs($knots[$knot][0] - $knots[($knot - 1)][0]) -le 1) -and ([math]::abs($knots[$knot][1] - $knots[($knot - 1)][1]) -le 1)) { }
            elseif ($knots[$knot][0] -eq $knots[($knot - 1)][0]) {
                $knots[$knot][1] += ($knots[($knot - 1)][1] - $knots[$knot][1]) / 2
            }
            elseif ($knots[$knot][1] -eq $knots[($knot - 1)][1]) {
                $knots[$knot][0] += ($knots[($knot - 1)][0] - $knots[$knot][0]) / 2
            }
            else {
                $step0 = ($knots[($knot - 1)][0] - $knots[$knot][0]) / 2
                $step1 = ($knots[($knot - 1)][1] - $knots[$knot][1]) / 2

                $knots[$knot][0] += $step0 -gt 0 ? [math]::Ceiling($step0) : [math]::Floor($step0)
                $knots[$knot][1] += $step1 -gt 0 ? [math]::Ceiling($step1) : [math]::Floor($step1)
            }
            if ($knot -eq 9) {
                $visited[($knots[$knot] -join ';')] = 1
            }
        }
    }
}

$visited.count
$stopwatch.Elapsed.TotalSeconds