# Taken from psake https://github.com/psake/psake

<#
.SYNOPSIS
  This is a helper function that runs a scriptblock and checks the PS variable $lastexitcode
  to see if an error occcured. If an error is detected then an exception is thrown.
  This function allows you to run command-line programs without having to
  explicitly check the $lastexitcode variable.
.EXAMPLE
  exec { svn info $repository_trunk } "Error executing SVN. Please verify SVN command-line client is installed"
#>
function Exec
{
    [CmdletBinding()]
    param(
        [Parameter(Position=0,Mandatory=1)][scriptblock]$cmd,
        [Parameter(Position=1,Mandatory=0)][string]$errorMessage = ($msgs.error_bad_command -f $cmd)
    )
    & $cmd
    if ($lastexitcode -ne 0) {
        throw ("Exec: " + $errorMessage)
    }
}

$artifacts = ".\artifacts"

if(Test-Path $artifacts) { Remove-Item $artifacts -Force -Recurse }

exec { & dotnet clean -c Release }
exec { & dotnet build -c Release }
exec { & dotnet test -c Release --no-build -l trx --verbosity=normal }

exec { & dotnet pack .\src\EasilyNET.AutoDependencyInjection\EasilyNET.AutoDependencyInjection.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Core\EasilyNET.Core.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Extensions\EasilyNET.Extensions.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.IdentityServer.MongoStorage\EasilyNET.IdentityServer.MongoStorage.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Images\EasilyNET.Images.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Mongo\EasilyNET.Mongo.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Mongo.ConsoleDebug\EasilyNET.Mongo.ConsoleDebug.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Mongo.Extension\EasilyNET.Mongo.Extension.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Mongo.GridFS\EasilyNET.Mongo.GridFS.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Mongo.GridFS.Extension\EasilyNET.Mongo.GridFS.Extension.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.RabbitBus\EasilyNET.RabbitBus.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.Tools\EasilyNET.Tools.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }
exec { & dotnet pack .\src\EasilyNET.WebCore\EasilyNET.WebCore.csproj -c Release -o $artifacts --include-symbols -p:SymbolPackageFormat=snupkg --no-build }