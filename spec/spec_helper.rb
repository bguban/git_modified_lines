# frozen_string_literal: true

require "git_modified_lines"
require "rspec/core/memoized_helpers"

Dir[File.dirname(__FILE__) + "/support/**/*.rb"].sort.each { |f| require f }

RSpec.configure do |config|
  config.include GitSpecHelpers
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = %i[expect should]
  end

  config.mock_with :rspec do |c|
    c.syntax = %i[expect should]
  end
end
