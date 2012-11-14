require 'spec_helper'

describe Guard::Sprockets do

  describe '.initialize' do
    describe 'options' do
      describe 'asset_paths' do
        it { described_class.new.asset_paths.should eq ['app/assets/javascripts'] }
        it { described_class.new([], :asset_paths => 'foo/bar').asset_paths.should eq ['foo/bar'] }
        it { described_class.new([], :asset_paths => ['foo/bar']).asset_paths.should eq ['foo/bar'] }
      end

      describe 'destination' do
        it { described_class.new.destination.should eq 'public/javascripts' }
        it { described_class.new([], :destination => 'foo/bar').destination.should eq 'foo/bar' }
      end

      describe 'minify' do
        it { described_class.new.sprockets.js_compressor.should be_nil }
        it { described_class.new([], :minify => true).sprockets.js_compressor.should_not be_nil }
      end

      describe 'root_file' do
        it { described_class.new.root_file.should be_nil }
        it { described_class.new([], :root_file => 'foo/bar').root_file.should eq ['foo/bar'] }
        it { described_class.new([], :root_file => %w(a b c)).root_file.should eq %w(a b c) }
      end
    end
  end

  describe 'without_preprocessor_extension' do
    it { subject.send(:without_preprocessor_extension, 'foo.js.coffee').should eq 'foo.js' }
  end

  describe 'run_on_change' do
    before do
      subject.sprockets.should_receive(:[]).and_raise ExecJS::ProgramError
    end
    after { FileUtils.rm_r('public') }

    it { subject.run_on_changes(['foo']).should be_false }
  end

end
