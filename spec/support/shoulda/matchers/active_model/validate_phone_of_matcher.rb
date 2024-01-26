# frozen_string_literal: true

module Shoulda
  module Matchers
    module ActiveModel
      # The `validate_phone_of` matcher tests usage of the `PhoneValidator`.
      #
      #     class Company
      #       include ActiveModel::Model
      #       attr_accessor :phone
      #
      #       validates :phone, phone: true
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_phone_of(:phone) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_phone_of(:phone)
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
      #       attr_accessor :phone
      #
      #       validates :phone, phone: true, on: :create
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_phone_of(:phone).on(:create) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_phone_of(:phone).on(:create)
      #     end
      #
      # @return [ValidatePhoneOfMatcher}
      #
      def validate_phone_of(attr)
        ValidatePhoneOfMatcher.new(attr)
      end

      # @private
      class ValidatePhoneOfMatcher < ValidationMatcher
        def matches?(subject)
          super(subject)
          @subject.class.validators_on(@attribute).any? { |v| v.is_a?(PhoneValidator) }
        end

        def simple_description
          "validate that :#{@attribute} matches phone formats"
        end
      end
    end
  end
end
