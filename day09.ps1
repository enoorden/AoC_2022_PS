# AoC2022 Day9 - PowerShell

$data = Get-Content ./day09.input

$stopwatch = [system.diagnostics.stopwatch]::StartNew()

$h = @(0, 0)
$t = @(0, 0)

foreach ($d in $data) {
    $dir, $steps = $d.split(' ')
    1..$steps | ForEach-Object {
        switch ($dir) {
            'U' { $h[0]++ }
            'D' { $h[0]-- }
            'L' { $h[1]-- }
            'R' { $h[1]++ }
        }

        if (([math]::abs($t[0] - $h[0]) -le 1) -and ([math]::abs($t[1] - $h[1]) -le 1)) {
            write-host '.'

        }
        elseif ($t[0] -eq $h[0]) {
            $t[1] += ($h[1] - $t[1])/2
        }
        elseif ($t[1] -eq $h[1]) {
            $t[0] += ($h[0] - $t[0])/2
        }
        else {
            $t[0] += ($h[0] - $t[0])/2
            $t[1] += ($h[1] - $t[1])/2
        }
        write-host "H:$($h[0]),$($h[1]) - T:$($t[0]),$($t[1])"
    }
}