function Get-TREUser {
    [CmdletBinding()]
    param(
        [string]$Titulo,

        [string] $Nome
    )
    BEGIN {}
    PROCESS {
        if ($PSBoundParameters.ContainsKey('Nome')) {
            $user_params = @{'Filter' = "DisplayName -like '$Nome*'"
                'Properties'          = '*'
            }         

        }

        if ($PSBoundParameters.ContainsKey('Titulo')) {
            $user_params = @{'Filter' = "SamAccountName -eq '$Titulo'"
                'Properties'          = '*'
            }
        }

        $users = Get-ADUser @user_params | Select-Object SamAccountName, DisplayName, EmailAddress
        

        foreach ($user in $users) {
            $props = @{'Nome' = $user.DisplayName
                'Titulo'      = $user.SamAccountName
                'E-Mail'      = $user.EmailAddress
            }
            $obj = New-Object -TypeName psobject -Property $props
            Write-Output $obj   
        }
        
    }

       
    END {

    }
}