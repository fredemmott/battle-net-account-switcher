# battle-net-account-switcher
Powershell script to switch between logged in battlenet accounts

This script will:

1. Prompt you to select an account
1. Stop battle.net
1. Change battle.net's configuration file
1. Restart battle.net

Battle.net will prompt for your password the first time you switch to each account, but will remember it for future runs. This script does not save passwords.

## Usage

1. Download it to your 'Documents' folder
1. Right click on your desktop and select 'create shortcut'
1. Enter the following:

```
%WINDIR%\System32\WindowsPowerShell\v1.0\powershell.exe -command "& %USERPROFILE%\Documents\battlenet-account-switch.ps1"
```

If you download it to somewhere other than Documents, you'll need to update the quoted text.

## Example

```
Accounts:

1. fred@example.com
2. fredsalt@example.com
Selection (1-2): 2
Battle.net is not running.
Updating configuration file...
Launching battle.net...
```
