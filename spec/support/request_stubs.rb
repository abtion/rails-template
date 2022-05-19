# frozen_string_literal: true

module RequestStubs
  def stub_strong_password(password: "woof-SAYS-muffi")
    digest = Digest::SHA1.hexdigest(password).upcase

    stub_request(:get, "https://api.pwnedpasswords.com/range/#{digest[0..4]}")
      .to_return(status: 200, body: "somehash:1\r\n", headers: {})
  end

  def stub_weak_password(password: "password", breach_count: 3_861_493)
    digest = Digest::SHA1.hexdigest(password).upcase

    stub_request(:get, "https://api.pwnedpasswords.com/range/#{digest[0..4]}")
      .to_return(status: 200, body: "#{digest[5..39]}:#{breach_count}\r\n", headers: {})
  end
end
