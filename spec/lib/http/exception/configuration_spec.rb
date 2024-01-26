# frozen_string_literal: true

require 'rails_helper'

describe Http::Exceptions::Configuration do
  let(:result) do
    [
      SocketError,
      Errno::ETIMEDOUT,
      Net::ReadTimeout,
      Net::OpenTimeout,
      Net::ProtocolError,
      Errno::ECONNREFUSED,
      Errno::EHOSTDOWN,
      Errno::ECONNRESET,
      Errno::ENETUNREACH,
      Errno::EHOSTUNREACH,
      Errno::ECONNABORTED,
      OpenSSL::SSL::SSLError,
      EOFError,
    ]
  end

  it 'returns default exceptions to convert' do
    expect(described_class.new.exceptions_to_convert).to eq(result)
  end
end
