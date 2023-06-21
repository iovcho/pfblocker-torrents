#!/bin/bash
wget -q https://raw.githubusercontent.com/im-sm/Pi-hole-Torrent-Blocklist/main/all-torrent-websites.txt -O all-torrent-websites.txt;
wget -q https://raw.githubusercontent.com/im-sm/Pi-hole-Torrent-Blocklist/main/all-torrent-trackres.txt -O all-torrent-trackres.txt;
wget -q https://raw.githubusercontent.com/im-sm/Pi-hole-Torrent-Blocklist/main/custom-tracker.txt -O custom-tracker.txt;
wget -q https://raw.githubusercontent.com/im-sm/Pi-hole-Torrent-Blocklist/main/custom-website.txt -O custom-website.txt;

cat added_by_me.txt all-torrent-websites.txt all-torrent-trackres.txt custom-tracker.txt custom-website.txt > all_tmp.txt
## Remove all # and www.
cat all_tmp.txt | sed '/^#/d' | sed '/^# /d' | sed '/^www./d' > all_tmp2.txt
## copy all domains with www. prefix
cat all_tmp2.txt | sed -e "s/\(.*\)/www.\1/" > all_tmp3.txt
cat all_tmp2.txt all_tmp3.txt > all_domains.txt
## Remove duplicates records and add 0.0.0.0 prefix for pfblocker;
awk '!seen[$0]++' "all_domains.txt" | sed -e "s/\(.*\)/0.0.0.0 \1/" > "torrents_trackers.txt";
rm -rf all_*.txt all-torrent-websites.txt  all-torrent-trackres.txt custom-tracker.txt custom-website.txt;
