# AoC2022 Day6 - PowerShell

[char[]]$data = Get-Content ./day06.input

#part1
for ($i = 4; $i -lt $data.Count; $i++) {
    if (($data[($i-3)..($i)] | select -Unique).count -eq 4) {
        $i + 1
        break
    }
}

#part2
for ($i = 14; $i -lt $data.Count; $i++) {
    if (($data[($i-13)..($i)] | select -Unique).count -eq 14) {
        $i + 1
        break
    }
}