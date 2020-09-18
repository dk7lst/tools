<?php
header("Content-Type: application/rss+xml");
?>
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>Recordings</title>
<link>https://CHANGEME/podcast/</link>
<description>Archiv der Aufzeichnungen. Dieser Link ist vertraulich zu behandeln und nur für Mitglieder von CHANGEME!</description>
<copyright>CHANGEME</copyright>
<atom:link href="https://CHANGEME/podcast/feed.php" rel="self" type="application/rss+xml" />
<image>
  <url>https://CHANGEME/podcast/logo-text.jpg</url>
  <title>Recordings</title>
  <link>https://CHANGEME/podcast/</link>
</image>
<?php
// https://de.wikipedia.org/wiki/RSS_%28Web-Feed%29
// http://www.rssboard.org/rss-specification
// https://validator.w3.org/feed/

foreach(glob("mp3/rec-*_n.mp3") as $f) {
  $ftime = filemtime($f);
  if(time() - $ftime > 24 * 60 * 60) continue;

  $URL = "https://CHANGEME/podcast/$f";
  $name = str_replace("-", " ", substr($f, 12, 13));
  $name = substr_replace($name, ":", 11, 0);
  $name = substr_replace($name, "/", 6, 0);
  $name = substr_replace($name, "/", 4, 0);
  echo "<item>\n";
  echo "  <title>Aufzeichnung $name</title>\n";
  echo "  <pubDate>" . date("D, d M Y H:i:s O", $ftime) . "</pubDate>\n";
  echo "  <link>$URL</link>\n";
  echo "  <guid>$URL</guid>\n";
  echo "  <enclosure url=\"$URL\" length=\"" . filesize($f) . "\" type=\"audio/mpeg\" />\n";
  echo "  <description>Automatisch in der Lautstärke angeglichene Aufzeichnung $name.</description>\n";
  echo "</item>\n";
}
?>
</channel>
</rss>
