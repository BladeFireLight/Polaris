﻿Describe "New-PolarisRoute" {

    BeforeAll {

        #  Import module
        Import-Module ..\Polaris.psd1

        #  Start with a clean slate
        Remove-PolarisRoute
        }

    It "Should create GET route" {

        #  Define route
        $Method = 'GET'
        $Path   = "TestRoute$Method"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock
        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should create POST route" {

        #  Define route
        $Method = 'POST'
        $Path   = "TestRoute$Method"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock
        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should create PUT route" {

        #  Define route
        $Method = 'PUT'
        $Path   = "TestRoute$Method"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock
        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should create DELETE route" {

        #  Define route
        $Method = 'DELETE'
        $Path   = "TestRoute$Method"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock
        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should create route with Scriptpath" {

        #  Define route
        $Method = 'GET'
        $Path   = "TestScriptBlockRoute$Method"
        $ScriptPath = "TestDrive:\$Path.ps1"

        $Path | Out-File -FilePath $ScriptPath -NoNewline

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptPath $ScriptPath
        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should throw error if Scriptpath not found" {

        #  Define route
        $Method = 'GET'
        $Path   = "TestScriptBlockRoute$Method"
        $ScriptPath = "TestDrive:\DOESNOTEXIST.ps1"

        #  Create route
        { New-PolarisRoute -Path $Path -Method $Method -ScriptPath $ScriptPath -ErrorAction Stop } |
            Should Throw
        }

    It "Should create route with matching Path but new Method" {

        #  Define route
        $Method = 'GET'
        $Path   = "TestNewMethod$Method"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock

        #  Define route
        $Method = 'POST'
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock

        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $Path
        }

    It "Should throw error if route for Path and Method exists" {

        #  Define route
        $Method = 'GET'
        $Path   = "TestExisting"
        $Scriptblock = [scriptblock]::Create( $Path )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock

        #  Create route
        { New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock -ErrorAction Stop } |
            Should Throw
        }

    It "Should overwrite route with matching Path and Method with Force switch" {

        #  (Using existing route from previous test.)

        #  Define route
        $Method = 'GET'
        $Path   = "TestExisting"
        $NewContent = "NewContent"
        $Scriptblock = [scriptblock]::Create( $NewContent )

        #  Create route
        New-PolarisRoute -Path $Path -Method $Method -ScriptBlock $Scriptblock -Force

        
        #  Test route
        ( Get-PolarisRoute -Path $Path -Method $Method ).Scriptblock | Should Be $NewContent
        }

    AfterAll {

        #  Clean up test routes
        Remove-PolarisRoute
        }
    }
