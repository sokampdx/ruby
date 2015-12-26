class Player
	@go_forward = true
	@retreating = false

	def direction
		if @go_forward
			:forward
		else
			:backward
		end
	end

	def retreat
		change_direction unless @retreating
		@retreating = true
	end

	def regroup
		change_direction if @retreating
		@retreating = false
	end

	def change_direction 
		@go_forward ^= @go_forward
	end

	def safe_to_rest(warrior)
		warrior.health <= 18 && warrior.health >= @health
	end

	def health_too_low(warrior)
		warrior.health <= 10 && warrior.health < @health
	end

  def play_turn(warrior)
		@health ||= warrior.health

		if warrior.feel(direction).captive?
			warrior.rescue!(direction)
		else
			if safe_to_rest(warrior)
				warrior.rest!
			elsif health_too_low(warrior)
				retreat
				warrior.walk!(direction)
			else
				regroup
				if warrior.feel.enemy?
					warrior.attack!
				elsif warrior.feel.empty?
					warrior.walk!
				else
					warrior.pivot!
				end
			end
		end
		@health = warrior.health
	end	
end
