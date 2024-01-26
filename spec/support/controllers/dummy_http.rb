# frozen_string_literal: true

class DummyHTTP < Net::HTTPSuccess
  def success?
    true
  end

  def body
    { access_token: 'token' }
  end
end
