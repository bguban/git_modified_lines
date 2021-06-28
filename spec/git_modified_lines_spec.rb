# frozen_string_literal: true
require 'spec_helper'

RSpec.describe GitModifiedLines do
  describe '.extract_modified_lines' do
    let(:file) { 'file.txt' }
    let(:options) { {} }

    subject { described_class.extract_modified_lines(file, options) }

    around do |example|
      repo do
        echo("Hello World\nHow are you?", file)
        `git add file.txt`
        `git commit -m "Initial commit"`
        example.run
      end
    end

    context 'when no lines were modified' do
      it { is_expected.to be_empty }
    end

    context 'when lines were added' do
      before do
        echo('Hello Again', file, append: true)
      end

      it 'includes the added lines' do
        expect(subject.to_a).to eq([3])
      end
    end

    context 'when lines were removed' do
      before do
        echo('Hello World', file)
      end

      it { is_expected.to be_empty }
    end
  end

  describe '.modified_files' do
    let(:options) { {} }
    subject { described_class.modified_files(options) }

    around do |example|
      repo do
        example.run
      end
    end

    context 'when `staged` option is set' do
      let(:options) { { staged: true } }

      context 'when files were added' do
        before do
          touch 'added.txt'
          `git add added.txt`
        end

        it { is_expected.to eq([File.expand_path('added.txt')]) }
      end

      context 'when files were renamed' do
        before do
          touch 'file.txt'
          `git add file.txt`
          `git commit -m "Initial commit"`
          `git mv file.txt renamed.txt`
        end

        it { is_expected.to eq([File.expand_path('renamed.txt')]) }
      end

      context 'when files were modified' do
        before do
          touch 'file.txt'
          `git add file.txt`
          `git commit -m "Initial commit"`
          echo('Modification', 'file.txt', append: true)
          `git add file.txt`
        end

        it { is_expected.to eq([File.expand_path('file.txt')]) }
      end

      context 'when files were deleted' do
        before do
          touch 'file.txt'
          `git add file.txt`
          `git commit -m "Initial commit"`
          `git rm file.txt`
        end

        it { is_expected.to eq([]) }
      end

      context 'when submodules were added' do
        let(:submodule) do
          repo do
            `git commit --allow-empty -m "Initial commit"`
          end
        end

        before do
          `git submodule add #{submodule} sub 2>&1 > #{File::NULL}`
        end

        it { is_expected.not_to include File.expand_path('sub') }
      end
    end
  end
end
