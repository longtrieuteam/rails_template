# frozen_string_literal: true

module Utils
  class PhoneNumber
    include Virtus.model

    attribute :phone, String

    # https://gist.github.com/tungvn/2460c5ba947e5cbe6606c5e85249cf04
    def vietnamese_phone?
      /^(03|05|07|08|09)+([0-9]{8})$/.match(phone_without_country_prefix).present?
    end

    ##
    # Remove prefix country code for vietnamese phone number
    #  Input:
    #    +84785288888
    #    +840785288888
    #    84785288888
    #    840785288888
    #  Output:
    #    0785288888
    #
    def phone_without_country_prefix
      phone.to_s.gsub(/^(\+840|\+84|840|84)/, '0')
    end

    alias to_s phone_without_country_prefix

    def present?
      phone.present?
    end

    def blank?
      phone.blank?
    end
  end
end
