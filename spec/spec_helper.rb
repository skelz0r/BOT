# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path(File.join(File.dirname(__FILE__), '../'))

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].sort.each { |f| require f }

require 'hashie'

require 'lib/interceptor/base_interceptor'

[
  'lib/',
  'lib/interceptor/',
].each do |path|
  Dir.entries(path).each do |file|
    next unless file =~ /\.rb$/

    require "#{path}#{file.gsub(/\.rb$/, '')}"
  end
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.before(:all) do
    sounds_absolute_path = File.expand_path(File.join(File.dirname(__FILE__), '../sounds'))

    FileUtils.rm_rf(
      Dir["#{sounds_absolute_path}/*.MP3"]
    )
  end

  config.include_context 'interceptor_test_init', type: :interceptor
  config.include InterceptorMatcher
end
