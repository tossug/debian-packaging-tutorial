#!/usr/bin/ruby -w

require 'date'

BROKEN_DATES = ['2011-05-16', '2011-05-17', '2011-05-18', '2011-05-19', '2011-05-20', '2013-05-15', '2013-05-21', '2013-05-22', '2013-05-23', '2013-05-24', '2013-05-25', '2013-05-26', '2013-05-27', '2013-05-28', '2013-05-29', '2013-05-30', '2013-07-03', '2013-07-04', '2013-03-23', '2013-03-24', '2013-03-25', '2012-12-30', '2013-05-14', '2013-05-15' ]

system("scp lintian.debian.org:~cjwatson/dhstats.txt .")
f = File::new("cdbs-dh7.txt", 'w')
f.puts "date dh dh7 cdbs"
IO::read("dhstats.txt").split(/\n\n/).each do |par|
  par.strip!
  next if par == "Sun Sep 20 00:29:01 UTC 2009"
  lines = par.split(/\n/)
  date = Date::parse(lines[0]).to_s
  next if BROKEN_DATES.include?(date) or date > '2013-05-13'
  dh = lines.grep(/^debhelper: /)[0].split[2].gsub(/[\(\)\%]/,'').to_f
  dh7 = lines.grep(/^dh\(1\): /)[0].split[2].gsub(/[\(\)\%]/,'').to_f
  cdbs = lines.grep(/^CDBS: /)[0].split[2].gsub(/[\(\)\%]/,'').to_f
  f.puts "#{date} %.2f %.2f %.2f" % [dh - dh7 - cdbs, dh7, cdbs]
end
f.close
system("rm dhstats.txt")
