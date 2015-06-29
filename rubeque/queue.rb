class Queue
	def initialize(list)
  	@list = list
	end

	def pop(*n)
    @list.shift(*n)
	end  

	def push(list)
  	@list.push(*list)
  	true
	end

	def to_a
  	@list
	end
  
end


queue = Queue.new([5, 6, 7, 8])

puts queue.pop
puts queue.pop
puts queue.push([4, 2])
puts queue.pop(2)
puts queue.to_a
