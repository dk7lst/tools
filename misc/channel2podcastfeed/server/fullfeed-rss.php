<?php
header("Content-Type: application/rss+xml");
?>
<?xml version="1.0" encoding="utf-8"?>
<rss version="2.0" xmlns:atom="http://www.w3.org/2005/Atom">
<channel>
<title>Recordings</title>
<link>https://CHANGEME/podcast/</link>
<description>Archiv der Aufzeichnungen. ADMIN-Version!</description>
<copyright>CHANGEME</copyright>
<atom:link href="https://CHANGEME/podcast/fullfeed-rss.php" rel="self" type="application/rss+xml" />
<image>
  <url>https://CHANGEME/podcast/logo-text.jpg</url>
  <title>Recordings</title>
  <link>https://CHANGEME/podcast/</link>
</image>
<?php
// https://de.wikipedia.org/wiki/RSS_%28Web-Feed%29
// http://www.rssboard.org/rss-specification
// https://validator.w3.org/feed/

function getsortkey($f) {
  return substr($f, 12, 13) . substr($f, 8, 3);
}

function cmp($a, $b) {
  if($a == $b) return 0;
  return getsortkey($a) < getsortkey($b) ? -1 : 1;
}

$list = glob("mp3/rec-*_n.mp3", GLOB_NOSORT);
usort($list, "cmp");
foreach($list as $f) {
  $URL = "https://CHANGEME/podcast/$f";
  $name = str_replace("-", " ", substr($f, 8, 17));
  $name = substr_replace($name, ":", 15, 0);
  $name = substr_replace($name, "/", 10, 0);
  $name = substr_replace($name, "/", 8, 0);
  echo "<item>\n";
  echo "  <title>$name</title>\n";
  echo "  <pubDate>" . date("D, d M Y H:i:s O", filemtime($f)) . "</pubDate>\n";
  echo "  <link>$URL</link>\n";
  echo "  <guid>$URL</guid>\n";
  echo "  <enclosure url=\"$URL\" length=\"" . filesize($f) . "\" type=\"audio/mpeg\" />\n";
  echo "  <description>Aufzeichnung $name.</description>\n";
  echo "</item>\n";
}
?>
</channel>
</rss>
