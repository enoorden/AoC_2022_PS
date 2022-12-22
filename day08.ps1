# AoC2022 Day8 - PowerShell

$data = Get-Content ./day08.input

$stopwatch =  [system.diagnostics.stopwatch]::StartNew()
function printGrid($g) {
    for ($y = 0; $y -lt $g.GetLength(0); $y++) {
        for ($x = 0; $x -lt $g.GetLength(1); $x++) {
            write-host $g[$y,$x] -NoNewline
        }
        Write-Host
    }
}

$grid = [int[,]]::new($data.count, $data.count)

#horizontal
for ($y = 0; $y -lt $data.Count; $y++) {
    if ($y -eq 0 -or $y -eq ($data.Count - 1)) {
        0..($data.count - 1) | % { $grid[$y,$_] = 1 }
        continue
    }
    [int[]]$row = $data[$y] -split '' -ne ''
    $max = ($row | Measure-Object -Maximum).Maximum
    
    $high = $row[0]
    for ($x = 1; $x -lt $row.Count - 2; $x++) {
        if ($row[$x] -gt $high) {
            $high = $row[$x]
            $grid[$y,$x] = 1
            if ($high -eq $max) { break }
        }
    }

    $high = $row[-1]
    for ($x = $row.count - 1; $x -gt 0; $x--) {
        if ($row[$x] -gt $high) {
            $high = $row[$x]
            $grid[$y,$x] = 1
            if ($high -eq $max) { break }
        }
    }
}

#vertical
for ($x = 0; $x -lt $data.Count; $x++) {
    if ($x -eq 0 -or $x -eq $data.Count - 1) {
        0..($data.count - 1) | % { $grid[$_,$x] = 1 }
        continue
    }
    [int[]]$row = $data | % { $_[$x] }
    $max = ($row | Measure-Object -Maximum).Maximum
    
    $high = $row[0]
    for ($y = 1; $y -lt $row.Count - 2; $y++) {
        if ($row[$y] -gt $high) {
            $high = $row[$y]
            $grid[$y,$x] = 1
            if ($high -eq $max) { break }
        }
    }

    $high = $row[-1]
    for ($y = $row.count - 1; $y -gt 1; $y--) {
        if ($row[$y] -gt $high) {
            $high = $row[$y]
            $grid[$y,$x] = 1
            if ($high -eq $max) { break }
        }
    }
}


#printGrid $grid
$stopwatch.Elapsed.TotalSeconds

($grid | ? {$_ -eq 1}).count 



#part2

$grid2 = [int[,]]::new($data.count, $data.count)

for ($y = 1; $y -lt $data.Count - 1; $y++) {
    for ($x = 1; $x -lt $row.Count - 1; $x++) {
        
        $tree = $data[$y][$x]

        $visXL = 0
        for ($xL = $x - 1; $xL -ge 0; $xL--) {
            if ($data[$y][$xL] -ge $tree) { $visXL++; break }
            $visXL++
        }

        $visXR = 0
        for ($xR = $x + 1; $xR -le $data.count - 1; $xR++) {
            if ($data[$y][$xR] -ge $tree) { $visXR++; break }
            $visXR++
        }

        $visYU = 0
        for ($yU = $y - 1; $yU -ge 0; $yU--) {
            if ($data[$yU][$x] -ge $tree) { $visYU++; break }
            $visYU++
        }

        $visYD = 0
        for ($yD = $y + 1; $yD -le $data.count - 1; $yD++) {
            if ($data[$yD][$x] -ge $tree) { $visYD++; break }
            $visYD++
        }

        $grid2[$y,$x] = $visXL * $visXR * $visYU * $visYD
    }
}

#printGrid $grid2
($grid2 | Measure-Object -Maximum).Maximum
$stopwatch.Elapsed.TotalSeconds