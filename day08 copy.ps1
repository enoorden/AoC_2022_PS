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
for ($y = 1; $y -lt $data.Count - 1; $y++) {
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
    for ($x = $row.count - 1; $x -gt 1; $x--) {
        if ($row[$x] -gt $high) {
            $high = $row[$x]
            $grid[$y,$x] = 1
            if ($high -eq $max) { break }
        }
    }
}

#vertical
# for ($x = 1; $x -lt $data.Count - 1; $x++) {
#     [int[]]$row = $data | % { $_[$x] }
#     $max = ($row | Measure-Object -Maximum).Maximum
    
#     $high = $row[0]
#     for ($y = 1; $y -lt $row.Count - 2; $y++) {
#         if ($row[$y] -gt $high) {
#             $high = $row[$y]
#             $grid[$y,$x] = 1
#             if ($high -eq $max) { break }
#         }
#     }

#     $high = $row[-1]
#     for ($y = $row.count - 1; $y -gt 1; $y--) {
#         if ($row[$y] -gt $high) {
#             $high = $row[$y]
#             $grid[$y,$x] = 1
#             if ($high -eq $max) { break }
#         }
#     }
# }


printGrid $grid

write-host ''
$stopwatch.Elapsed.TotalSeconds