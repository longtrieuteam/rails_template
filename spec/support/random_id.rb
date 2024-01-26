# frozen_string_literal: true

class RandomId
  def self.generate
    "#{rand(1..9)}#{rand(0..999).to_s.rjust(3, '0')}#{[*('A'..'Z')].sample}"
  end
end
