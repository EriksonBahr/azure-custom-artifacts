 param (
    [Parameter(Mandatory=$true)][string]$containerName,
    [Parameter(Mandatory=$true)][string]$destinationPath,
    [Parameter(Mandatory=$true)][string]$accountName,
    [Parameter(Mandatory=$true)][string]$accountKey
)

$connectionString = 'DefaultEndpointsProtocol=https;AccountName=[$accountName];AccountKey=[$accountKey]'

$storageAccount = New-AzureStorageContext -ConnectionString $connectionString

$blobs = Get-AzureStorageBlob -Container $containerName -Context $storageAccount

foreach ($blob in $blobs)
{
    New-Item -ItemType Directory -Force -Path $destinationPath

    Get-AzureStorageBlobContent `
    -Container $containerName -Blob $blob.Name -Destination $destinationPath `
    -Context $storageAccount

}