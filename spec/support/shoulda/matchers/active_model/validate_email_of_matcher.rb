# frozen_string_literal: true

module Shoulda
  module Matchers
    module ActiveModel
      # The `validate_email_of` matcher tests usage of the `EmailValidator`.
      #
      #     class Company
      #       include ActiveModel::Model
      #       attr_accessor :email
      #
      #       validates :email, email: true
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_email_of(:email) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_email_of(:email)
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
      #       attr_accessor :email
      #
      #       validates :email, email: true, on: :create
      #     end
      #
      #     # RSpec
      #     RSpec.describe Company, type: :model do
      #       it { should validate_email_of(:email).on(:create) }
      #     end
      #
      #     # Minitest (Shoulda)
      #     class CompanyTest < ActiveSupport::TestCase
      #       should validate_email_of(:email).on(:create)
      #     end
      #
      # @return [ValidateEmailOfMatcher}
      #
      def validate_email_of(attr)
        ValidateEmailOfMatcher.new(attr)
      end

      # @private
      class ValidateEmailOfMatcher < ValidationMatcher
        def matches?(subject)
          super(subject)
          @subject.class.validators_on(@attribute).any? { |v| v.is_a?(EmailValidator) }
        end

        def simple_description
          "validate that :#{@attribute} matches email formats"
        end
      end
    end
  end
end
