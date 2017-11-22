module Luhn
  extend self

  def valid?(input)
    sum, i = 0, 0

    while c = input[i]
      c = c.to_i
      sum += begin
        i % 2 == 0 &&
          (c = c * 2 and c > 9 ? c -= 9 : c) || c
      end
      i += 1
    end

    (sum % 10).zero?
  end
end
