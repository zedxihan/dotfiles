{ ... }:

{
  home.file.".var/app/org.qbittorrent.qBittorrent/config/qBittorrent/qBittorrent.conf" = {
    force = true;
    text = ''
      [Appearance]
      ColorScheme=Dark
      Style=Fusion

      [Application]
      FileLogger\Age=1
      FileLogger\AgeType=1
      FileLogger\Backup=true
      FileLogger\DeleteOld=true
      FileLogger\Enabled=true
      FileLogger\MaxSizeBytes=66560
      FileLogger\Path=/home/zedxihan/.local/share/qBittorrent/logs
      GUI\Notifications\TorrentAdded=false

      [BitTorrent]
      Session\AlternativeGlobalDLSpeedLimit=0
      Session\AlternativeGlobalUPSpeedLimit=0
      Session\BTProtocol=TCP
      Session\DHTEnabled=false
      Session\DefaultSavePath=/mnt/shared
      Session\LSDEnabled=false
      Session\MaxUploadsPerTorrent=10
      Session\PeXEnabled=false
      Session\Port=11643
      Session\QueueingSystemEnabled=false
      Session\SSL\Port=9492
      Session\StartPaused=false

      [Core]
      AutoDeleteAddedTorrentFile=Never

      [LegalNotice]
      Accepted=true

      [Preferences]
      General\CloseToTrayNotified=true
      General\ExitConfirm=false
      General\Locale=en
      General\MinimizeToTray=true
      General\PreventFromSuspendWhenDownloading=true
      General\StatusbarFreeDiskSpaceDisplayed=true
      General\UseCustomUITheme=false

      [RSS]
      AutoDownloader\DownloadRepacks=true
      AutoDownloader\SmartEpisodeFilter=s(\d+)e(\d+), (\d+)x(\d+), "(\d{4}[.\-]\d{1,2}[.\-]\d{1,2})", "(\d{1,2}[.\-]\d{1,2}[.\-]\d{4})"
    '';
  };
}
