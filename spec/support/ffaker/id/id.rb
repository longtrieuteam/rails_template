# frozen_string_literal: true

module FFaker
  module Id
    extend ModuleUtils

    def self.id
      "#{rand(1..9)}#{rand(0..999).to_s.rjust(3, '0')}#{[*('A'..'Z')].sample}"
    end
  end
end
