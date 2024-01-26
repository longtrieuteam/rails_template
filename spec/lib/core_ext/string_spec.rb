# frozen_string_literal: true

require 'rails_helper'

describe CoreExt::String do
  describe '#visible?' do
    tests = [
      { input: 'true', output: true },
      { input: 'false', output: false },
      { input: 'invalid', output: false },
      { input: '', output: false },
    ]

    tests.each do |test|
      context "when input is #{test[:input]}" do
        it "returns #{test[:output]}" do
          actual = test[:input].to_boolean

          expect(actual).to eq(test[:output])
        end
      end
    end
  end

  describe '#remove_vn_character' do
    tests = [
      {
        input: 'àáạảãâầấậẩẫăằắặẳẵ èéẹẻẽêềếệểễ ìíịỉĩ òóọỏõôồốộổỗơờớợởỡ ùúụủũưừứựửữ ỳýỵỷỹ đ',
        output: 'aaaaaaaaaaaaaaaaa eeeeeeeeeee iiiii ooooooooooooooooo uuuuuuuuuuu yyyyy d',
      },
      {
        input: 'ÀÁẠẢÃÂẦẤẬẨẪĂẰẮẶẲẴ ÈÉẸẺẼÊỀẾỆỂỄ ÌÍỊỈĨ ÒÓỌỎÕÔỒỐỘỔỖƠỜỚỢỞỠ ÙÚỤỦŨƯỪỨỰỬỮ ỲÝỴỶỸ Đ',
        output: 'AAAAAAAAAAAAAAAAA EEEEEEEEEEE IIIII OOOOOOOOOOOOOOOOO UUUUUUUUUUU YYYYY D',
      },
      {
        input: 'ú òa uể oải ăn éo ị, ục ức oáy oăm ở ẳng ôm',
        output: 'u oa ue oai an eo i, uc uc oay oam o ang om',
      },
      {
        input: 'Ú ÒA UỂ OẢI ĂN ÉO Ị, ỤC ỨC OÁY OĂM Ở ẲNG ÔM',
        output: 'U OA UE OAI AN EO I, UC UC OAY OAM O ANG OM',
      },
    ]

    tests.each do |test|
      context "when input is #{test[:input]}" do
        it "returns #{test[:output]}" do
          actual = test[:input].remove_vn_character

          expect(actual).to eq(test[:output])
        end
      end
    end
  end
end
