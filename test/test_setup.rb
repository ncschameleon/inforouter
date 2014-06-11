class TestSetup < Test::Unit::TextCase
  def default_test
    # placeholder to avoid error under Ruby 1.8.7
  end

  def setup
    Inforouter.configure do |config|
      config.host     = ENV['INFOROUTER_HOST'] || 'inforouter_host'
      config.username = ENV['INFOROUTER_USERNAME'] || 'inforouter_username'
      config.password = ENV['INFOROUTER_PASSWORD'] || 'inforouter_password'
    end
  end

  def teardown
    Inforouter.reset!
  end
end
