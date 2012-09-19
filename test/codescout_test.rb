require File.expand_path('../helper', __FILE__)

class CodeScoutTest < Service::TestCase
  def setup
    @stubs = Faraday::Adapter::Test::Stubs.new
  end

  def test_receive_event
    @stubs.post '/repos/receive' do |env|
      assert_equal 'token-1234', env[:request_headers]['x-token']
      assert_equal 'push', env[:request_headers]['x-github-event']

      assert_equal 'application/json', env[:request_headers]['content-type']
      assert !env[:body].empty?
    end

    service(:push, { 'token' => 'token-1234' }, payload).receive_event
  end


  def service(*args)
    super Service::CodeScout, *args
  end
end
