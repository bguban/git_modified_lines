# frozen_string_literal: true

require_relative "git_modified_lines/version"
require 'set'

module GitModifiedLines
  module_function

  # Regular expression used to extract diff ranges from hunks of diff output.
  DIFF_HUNK_REGEX = /
      ^@@\s
      [^\s]+\s           # Ignore old file range
      \+(\d+)(?:,(\d+))? # Extract range of hunk containing start line and number of lines
      \s@@.*$
    /x.freeze

  # Extract the set of modified lines from a given file.
  #
  # @param file_path [String]
  # @param options [Hash]
  # @return [Set] line numbers that have been modified in file
  def extract_modified_lines(file_path, options)
    lines = Set.new

    flags = '--cached' if options[:staged]
    refs = options[:refs]
    subcmd = options[:subcmd] || 'diff'

    `git #{subcmd} --no-color --no-ext-diff -U0 #{flags} #{refs} -- "#{file_path}"`.
      scan(DIFF_HUNK_REGEX) do |start_line, lines_added|
      lines_added = (lines_added || 1).to_i # When blank, one line was added
      cur_line = start_line.to_i

      lines_added.times do
        lines.add cur_line
        cur_line += 1
      end
    end

    lines
  end

  # Returns the names of all files that have been modified compared to HEAD.
  #
  # @param options [Hash]
  # @return [Array<String>] list of absolute file paths
  def modified_files(options)
    flags = '--cached' if options[:staged]
    refs = options[:refs]
    subcmd = options[:subcmd] || 'diff'

    `git #{subcmd} --name-only -z --diff-filter=ACMR --ignore-submodules=all #{flags} #{refs}`.
      split("\0").
      map(&:strip).
      reject(&:empty?).
      map { |relative_file| File.expand_path(relative_file) }
  end

  # Returns the name of the currently checked out branch.
  # @return [String]
  def current_branch
    `git symbolic-ref --short -q HEAD`.chomp
  end
end
