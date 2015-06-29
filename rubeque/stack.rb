class Stack 
	def initialize(list)
  	@list = list
	end

	def push(list)
  	@list.push(*list.reverse)
  	true
	end

	def method_missing(name, *args) 
  	@list.send(name, *args)
	end
  
end


stack = Stack.new([5, 6, 7, 8])

puts stack.pop
puts stack.pop
puts stack.push([4, 2])
puts stack.pop(3)
puts stack.to_a
