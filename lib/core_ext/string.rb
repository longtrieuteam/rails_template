# frozen_string_literal: true

module CoreExt
  module String
    def to_boolean
      self == 'true'
    end

    def remove_vn_character
      string = self
      return string if string.blank?

      mapping_codes = {
        /[àáạảãâầấậẩẫăằắặẳẵ]/ => 'a',
        /[èéẹẻẽêềếệểễ]/ => 'e',
        /[ìíịỉĩ]/ => 'i',
        /[òóọỏõôồốộổỗơờớợởỡ]/ => 'o',
        /[ùúụủũưừứựửữ]/ => 'u',
        /[ỳýỵỷỹ]/ => 'y',
        /đ/ => 'd',
        /[ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ]/ => 'A',
        /[ÈÉẸẺẼÊỀẾỆỂỄ]/ => 'E',
        /[ÌÍỊỈĨ]/ => 'I',
        /[ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ]/ => 'O',
        /[ÙÚỤỦŨƯỪỨỰỬỮ]/ => 'U',
        /[ỲÝỴỶỸ]/ => 'Y',
        /Đ/ => 'D',
        /\u0300/ => '',
        /\u0301/ => '',
        /\u0302/ => '',
        /\u0303/ => '',
        /\u0306/ => '',
        /\u0309/ => '',
        /\u0323/ => '',
        /\u031B/ => '',
      }
      mapping_codes.each { |key, value| string = string.gsub(key, value) }
      string
    end
  end
end

String.prepend(CoreExt::String)
