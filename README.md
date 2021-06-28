# GitModifiedLines

Returns modified files and modified lines using git diff.

The code was pulled out from 
[overcommit](https://github.com/sds/overcommit/blob/8622f9e83fcd2b1e1bc1d19494d4c25843dbea5c/lib/overcommit/git_repo.rb) 
repo to be able to use its functionality outside of that gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'git_modified_lines', group: :development
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install git_modified_lines

## Usage

```ruby
cur_branch = GitModifiedLines.current_branch # => "test_branch"

GitModifiedLines.modified_files(ref: "master...#{cur_branch}") 
# => ["/Users/bguban/projects/git_modified_lines/README.md"]

GitModifiedLines.extract_modified_lines('README.md', ref: "master...#{cur_branch}")
#=> #<Set: {3, 10, 23, 24, 25, 26, 27, 28, 29, 30}>
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/git_modified_lines. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/[USERNAME]/git_modified_lines/blob/master/CODE_OF_CONDUCT.md).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the GitModifiedLines project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/git_modified_lines/blob/master/CODE_OF_CONDUCT.md).
