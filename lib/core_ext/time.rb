# frozen_string_literal: true

module CoreExt
  module Time
    def to_timestamp
      strftime('%Y%m%d%H%M%S')
    end
  end
end

Time.prepend(CoreExt::Time)
