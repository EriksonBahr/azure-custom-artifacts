 param (
    [Parameter(Mandatory=$true)][string]$xmlPath,
    [Parameter(Mandatory=$true)][string[]]$elementAttrName,
    [Parameter(Mandatory=$true)][string[]]$attrNames,
    [Parameter(Mandatory=$true)][string[]]$attrValues
)

$xml = New-Object XML
$xml.Load($xmlPath)

for($i=0; $elementAttrName.Length -gt $i; $i++){
    $xPathExpression = '//*[@*="'+$elementAttrName[$i]+'"]';
    $element =  $xml.SelectSingleNode($xPathExpression)
    $element.SetAttribute($attrNames[$i], $attrValues[$i]);
}

$xml.Save($xmlPath)


