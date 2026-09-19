{
  flake.homeModules.pyradio = {
    programs.pyradio = {
      enable = true;
      settings = {
        theme = "everforest-hard";
        use_transparency = true;
        force_transparency = true;
        enable_notifications = 0;
        use_os_media_controls = true;
      };
      stations = [
        {
          name = "ROCK FM";
          url = "http://nashe1.hostingradio.ru/rock-128.mp3";
        }
        {
          name = "ChroniX Radio Metalcore";
          url = "http://usa17.fastcast4u.com:5508/listen.pls";
        }
        {
          name = "Big R Radio - 80s Metal FM";
          url = "http://bigrradio.cdnstream1.com/5186_128";
          iconUrl = "http://www.bigrradio.com/image/favicon/apple-touch-icon.png";
        }
        {
          name = "Rock Antenne - Heavy Metal";
          url = "http://mp3channels.webradio.rockantenne.de/heavy-metal";
        }
        {
          name = "1.FM - High Voltage Radio";
          url = "http://strm112.1.fm/highvoltage_mobile_mp3";
        }
        {
          name = "181.FM - 80's HairBand";
          url = "http://www.181.fm/stream/pls/181-hairband.pls";
        }
        {
          name = "Crucial Velocity Radio";
          url = "http://crucialvelocity.ca/crucial128.m3u";
          iconUrl = "http://crucialvelocity.ca/CrucialVelocityLogo.jpg";
        }
        {
          name = "Nu Metal Radio";
          url = "http://stream.revma.ihrhls.com/zc9483/hls.m3u8";
        }
        {
          name = "181.FM - Old School HipHop/RnB";
          url = "http://listen.181fm.com/181-oldschool_128k.mp3";
        }
        {
          name = "Hot 108 JAMZ";
          url = "http://sc.hot108.com:4000/";
        }
        {
          name = "181.FM - The Beat (HipHop/R&B)";
          url = "http://www.181.fm/stream/pls/181-beat.pls";
        }
        {
          name = "181.FM - 90's Country";
          url = "http://www.181.fm/stream/pls/181-90scountry.pls";
        }
        {
          name = "181.FM - Power 181 (Top 40)";
          url = "http://www.181.fm/stream/pls/181-power.pls";
        }
        {
          name = "181.FM - True R&B";
          url = "http://www.181.fm/stream/pls/181-rnb.pls";
        }
        {
          name = "1.FM - Alternative Rock X Hits Radio";
          url = "http://strm112.1.fm/x_mobile_mp3";
        }
        {
          name = "2000 FM - Top 40";
          url = "http://bigrradio.cdnstream1.com/5106_128";
          iconUrl = "http://2000fm.net/images/logo.png";
        }
        {
          name = "2000 FM - Hard Rock";
          url = "http://bigrradio.cdnstream1.com/5104_128";
          iconUrl = "http://2000fm.net/images/logo.png";
        }
      ];
    };
  };
}
