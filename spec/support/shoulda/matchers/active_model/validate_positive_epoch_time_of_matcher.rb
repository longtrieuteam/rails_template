# frozen_string_literal: true

module Shoulda
  module Matchers
    module ActiveModel
      # The `validate_positive_epoch_time_of` matcher tests usage of the `PositiveEpochTimeValidator`.
      #
      #     class Company
      #       include ActiveModel::Model
      #       attr_accessor :positive_epoch_time
      #
      #       validates :positive_epoch_time, positive_epoch_time: true
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_positive_epoch_time_of(:positive_epoch_time) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_positive_epoch_time_of(:positive_epoch_time)
      #     end
      #
      # #### Qualifiers
      #
      # ##### on
      #
      # Use `on` if your validation applies only under a certain context.
      #
      #     class Company
      #       include ActiveModel::Model
      #       attr_accessor :positive_epoch_time
      #
      #       validates :positive_epoch_time, positive_epoch_time: true, on: :create
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_positive_epoch_time_of(:positive_epoch_time).on(:create) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_positive_epoch_time_of(:positive_epoch_time).on(:create)
      #     end
      #
      # @return [ValidatePositiveEpochTimeOfMatcher}
      #
      def validate_positive_epoch_time_of(attr)
        ValidatePositiveEpochTimeOfMatcher.new(attr)
      end

      # @private
      class ValidatePositiveEpochTimeOfMatcher < ValidationMatcher
        def matches?(subject)
          super(subject)
          @subject.class.validators_on(@attribute).any? { |v| v.is_a?(PositiveEpochTimeValidator) }
        end

        def simple_description
          "validate that :#{@attribute} matches positive_epoch_time formats"
        end
      end
    end
  end
end
