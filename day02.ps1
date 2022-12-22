# AoC2022 Day2 - PowerShell

$data = Get-Content ./day02.input

enum hand { 
    A = 1; B = 2; C = 3
    X = 1; Y = 2; Z = 3
}
enum score {
    x = 0; y = 3; z = 6
}

function getScore ($op,$re) {
    $winScore = 0
    #draw
    if ([hand]::$op.value__ -eq [hand]::$re.value__) {
        $winScore = 3 
    }
    #win
    if (($op -eq 'A' -and $re -eq 'Y') -or ($op -eq 'B' -and $re -eq 'Z') -or ($op -eq 'C' -and $re -eq 'X')) {
        $winScore = 6
    }
    return [hand]::$re.value__ + $winScore
}

function getHand ($op,$outcome) {
    $order = 'a','b','c','a'
    $return = 'x', 'y', 'z', 'x'
    switch ($outcome) {
        'x' {
            $index = [array]::IndexOf($order, $op.ToLower(), 1)
            return $return[$index - 1]
          }
        'y' {
            $index = [array]::IndexOf($order, $op.ToLower())
            return $return[$index] }
        'z' { 
            $index = [array]::IndexOf($order, $op.ToLower())
            return $return[$index + 1]
         }
    }
}

$total = 0
foreach ($d in $data) {
    $op,$re = $d -split ' '
    $total += getScore $op $re
}

$total

$total = 0
foreach ($d in $data) {
    $op,$outcome = $d -split ' '
    $score = getScore $op (gethand $op $outcome)
    $total += $score
}

$total