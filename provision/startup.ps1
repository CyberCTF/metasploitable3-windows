# The first-boot steps of upstream's Vagrantfile (the win2k8 machine, default difficulty), run
# from the scripts Rapid7's box carries in C:\startup: firewall on with the vulnerable services
# opened, the autorun that maps the Linux machine's share, then the scripts removed.
$ErrorActionPreference = 'Continue'
if (Test-Path C:\startup\enable_firewall.bat) {
  cmd /c C:\startup\enable_firewall.bat
  cmd /c C:\startup\configure_firewall.bat
  cmd /c C:\startup\install_share_autorun.bat
  cmd /c C:\startup\setup_linux_share.bat
  Remove-Item C:\startup\* -Force
}
exit 0
