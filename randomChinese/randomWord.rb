
FIRST = 19968
LAST = 40999

puts [rand(FIRST..LAST).to_s(16).to_i(16)].pack('U')
