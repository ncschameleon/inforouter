require 'helper'

class TestConfiguration < TestSetup
  def setup
    Inforouter.setup!
  end

  def test_missing_configuration
    assert_raise Inforouter::Errors::MissingConfig do
      Inforouter.client.request :dummy, body: {}
    end
  end

  def test_missing_host
    Inforouter.configure do |config|
      config.username = 'inforouter_username'
    end
    assert_raise Inforouter::Errors::MissingConfigOption do
      Inforouter.client.request :dummy, body: {}
    end
  end

  def test_missing_username
    Inforouter.configure do |config|
      config.host = 'inforouter_host'
    end
    assert_raise Inforouter::Errors::MissingConfigOption do
      Inforouter.client.request :dummy, body: {}
    end
  end
end
