# frozen_string_literal: true

module CoreExt
  module Hash
    def to_mash
      HashieMashResult.new(self)
    end
  end
end

Hash.prepend(CoreExt::Hash)
