param(
    [string]$server,
    [string]$username,
    [string]$password,
    [string]$environment,
    [string[]]$databases
)

Write-Host 'Extracting from ' $server

foreach($database in $databases) {
    $scriptDir = '.\' + $environment + '\' + $database
    dotnet schemazen script --server=$server --database=$database --user=$username --pass=$password --scriptDir=$scriptDir --overwrite


    if (Test-Path($scriptDir + '\.migrations')) {
        Remove-Item ($scriptDir + '\.migrations') -Force -Recurse
    }
    New-Item -Path ($scriptDir + '\.migrations') -ItemType Directory 
    
    Get-ChildItem ($scriptDir + '\users') -Filter *.sql | Get-Content | Out-File               -FilePath ($scriptDir + '\.migrations\V0_01__initial_users.sql') -Encoding utf8
    Get-ChildItem ($scriptDir + '\schemas') -Filter *.sql | Get-Content | Out-File             -FilePath ($scriptDir + '\.migrations\V0_02__initial_schemas.sql') -Encoding utf8
    Get-ChildItem ($scriptDir + '\tables') -Filter *.sql | Get-Content | Out-File              -FilePath ($scriptDir + '\.migrations\V0_03__initial_tables.sql') -Encoding utf8
    
    if (Test-Path ($scriptDir + '\check_constraints')) {
        Get-ChildItem ($scriptDir + '\check_constraints') -Filter *.sql | Get-Content | Out-File   -FilePath ($scriptDir + '\.migrations\V0_04__initial_check_constraints.sql') -Encoding utf8
    }
    Get-ChildItem ($scriptDir + '\defaults') -Filter *.sql | Get-Content | Out-File            -FilePath ($scriptDir + '\.migrations\V0_05__initial_defaults.sql') -Encoding utf8
    
    if (Test-Path ($scriptDir + '\synonyms')) {
        Get-ChildItem ($scriptDir + '\synonyms') -Filter *.sql | Get-Content | Out-File            -FilePath ($scriptDir + '\.migrations\V0_06__initial_synonyms.sql') -Encoding utf8
    }

    if (Test-Path ($scriptDir + '\foreign_keys')) {
        Get-ChildItem ($scriptDir + '\foreign_keys') -Filter *.sql | Get-Content | Out-File        -FilePath ($scriptDir + '\.migrations\V0_07__initial_foreign_keys.sql') -Encoding utf8
    }

    if (Test-Path ($scriptDir + '\views')) {
        Get-ChildItem ($scriptDir + '\views') -Filter *.sql | Get-Content | Out-File               -FilePath ($scriptDir + '\.migrations\V0_08__initial_views.sql') -Encoding utf8
    }

    if (Test-Path ($scriptDir + '\procedures')) {
        Get-ChildItem ($scriptDir + '\procedures') -Filter *.sql | Get-Content | Out-File          -FilePath ($scriptDir + '\.migrations\V0_09__initial_procedures.sql') -Encoding utf8
    }

    if (Test-Path  ($scriptDir + '\functions')) {
        Get-ChildItem ($scriptDir + '\functions') -Filter *.sql | Get-Content | Out-File           -FilePath ($scriptDir + '\.migrations\V0_10__initial_functions.sql') -Encoding utf8
    }
}