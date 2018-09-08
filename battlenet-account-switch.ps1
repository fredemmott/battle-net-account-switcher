# Copyright (c) 2018-present, Frederick Emmott
# All Rights Reserved.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree


# If you installed battle.net somewhere unusual, you'll have to edit this
$BATTLE_NET = "${env:PROGRAMFILES(x86)}\Battle.net\Battle.net Launcher.exe"

# Probably don't need to change anything below here

cd $env:APPDATA\Battle.net
$config = Get-Content "Battle.net.config" | ConvertFrom-Json
$accounts = ($config.Client.SavedAccountNames -split ",")
 
write-host "Accounts: "
write-host ""
for ($i = 0; $i -lt $accounts.Count; ++$i) {
  write-host "$($i+1). $($accounts[$i])"
}
 
while ($True) {
	write-host -nonewline ("Selection (1-$($accounts.Count)): ")
	$choice = read-host
	$is_numeric = $choice -match '^[0-9+]$'
	if (!$is_numeric) {
		continue;
	}
	$choice = [int] $choice;
	if (($choice -lt 1) -or ($choice -gt $accounts.Count)) {
		continue;
	}
	break;
}

# Adjust to zero-index
$choice--
$new_accounts = , $accounts[$choice]
for ($i = 0; $i -lt $accounts.Count; ++$i) {
  if ($i -eq $choice) {
    continue;
  }
  $new_accounts += $accounts[$i];
}
$config.Client.SavedAccountNames = $new_accounts -join ","
# We've now generated the new configuration, but not written it


if ((Get-Process "Battle.net" -ea SilentlyContinue) -eq $Null) {
	write-host "Battle.net is not running."
} else {
	write-host "Stopping Battle.net..."
	Stop-Process -name "Battle.net"
}
write-host "Updating configuration file..."

# Make a backup, just in case
cp "Battle.net.config" "Battle.net.config.switcher-backup"
ConvertTo-Json -depth 100 $config | Out-File -Encoding "UTF8" "Battle.net.config"

write-host "Launching Battle.net..."
Start-Process $BATTLE_NET