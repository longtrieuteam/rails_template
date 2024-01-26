# frozen_string_literal: true

module CoreExt
  module Object
    def numeric?
      return true if is_a?(Numeric) || is_a?(Integer) || is_a?(Float)

      /\A[+-]?\d+?(_?\d+)*(\.\d+e?\d*)?\Z/.match?(to_s)
    end
  end
end

Object.prepend(CoreExt::Object)
