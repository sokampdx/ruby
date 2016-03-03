#! /usr/bin/env ruby

class Cashier
  def self.get_change(change, currency)
    min_count = Array.new(change + 1, 0)
    min_coin = Array.new(change + 1, 0)

    (1..change).each do |remain|
      current_count = remain 
      current_coin = 1

      currency.each do |coin|
        next if coin > remain

        count = min_count[remain - coin] + 1
        current_count, current_coin = count, coin if count < current_count
      end

      min_count[remain] = current_count
      min_coin[remain] = current_coin
    end

    return min_count, min_coin
  end
end

def main
  currency = [32, 17, 1]
  change = ARGV.shift.to_i 
  count, coin = Cashier.get_change(change, currency)
  puts "number of coin used -- #{count[change]}"

  remain = change
  while remain > 0
    used = coin[remain]
    remain -= used
    puts used
  end
end

main
