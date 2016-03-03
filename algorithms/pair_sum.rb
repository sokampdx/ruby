#! /usr/bin/env ruby

def find_pair(array, sum)
  lookup = Array.new
  result = nil
  size = array.size
  (0..size).each do |i|
    current = array[i]
    if lookup[current]
      result = current
      break
    else      
      lookup[sum-current] = true
    end
  end
  result
end

def main
  array = [1, 6, 9, 10, 19, 2, 5, 3]
  n = 20
  answer = find_pair(array, n)
  print answer.nil? ? "No pair found" : [answer, n-answer]
  puts
end

main
