require 'rspec'

class PrimeFactor
  def self.solve(number = nil)
    return [] if number.nil? ||  number <= 1

    factors = []
    (2..number).each do |divisor|
      while number % divisor == 0
        factors.push(divisor) 
        number /= divisor
      end
    end

    factors << number if number > 1

    factors
  end
end

def assert_factor(number, factors)
  it_behaves_like 'factoring', number, factors
end

describe PrimeFactor do
  shared_examples 'factoring' do |user_input, expectation|
    it "takes #{user_input.nil? ? 'nil' : user_input} and return #{expectation.to_s}" do
      expect(PrimeFactor.solve(user_input)).to match_array(expectation)
    end
  end

  assert_factor(nil, [])
  assert_factor(1, [])
  assert_factor(2, [2])
  assert_factor(3, [3]) 
  assert_factor(4, [2,2])
  assert_factor(5, [5])
  assert_factor(6, [2,3])    
  assert_factor(7, [7])
  assert_factor(8, [2,2,2])
  assert_factor(9, [3,3])
  assert_factor(10, [2,5])
  assert_factor(2*2*2*3*3*5*11*17, [2,2,2,3,3,5,11,17])
end
