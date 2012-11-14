require 'guard'
require 'guard/guard'

require 'sprockets'
require 'execjs'

module Guard
  class Sprockets < Guard

    attr_reader :asset_paths, :destination, :root_file, :sprockets

    def initialize(watchers = [], options = {})
      super(watchers, options)

      @options     = options
      @asset_paths = Array(@options[:asset_paths] || 'app/assets/javascripts')
      @destination = @options[:destination] || 'public/javascripts'
      @root_file   = Array(@options[:root_file]) if @options[:root_file]

      @sprockets = ::Sprockets::Environment.new
      @asset_paths.each { |p| @sprockets.append_path(p) }
      @root_file.each{|f| @sprockets.append_path(Pathname.new(f).dirname) } if @root_file

      if @options.delete(:minify)
        begin
          require 'uglifier'
          @sprockets.js_compressor = ::Uglifier.new
          UI.info 'Sprockets will compress output.'
        rescue LoadError => ex
          UI.error "minify: Uglifier cannot be loaded. No compression will be used.\nPlease include 'uglifier' in your Gemfile."
          UI.debug ex.message
        end
      end
    end

    def start
       UI.info 'Guard::Sprockets is ready and waiting for some file changes...'
       UI.debug "Guard::Sprockets.asset_paths = #{@asset_paths.inspect}" unless @asset_paths.empty?
       UI.debug "Guard::Sprockets.destination = #{@destination.inspect}"

       run_all
    end

    def run_all
      run_on_changes []
    end

    def run_on_changes(paths)
      paths = @root_file if @root_file

      success = true
      paths.each do |file|
        success &= sprocketize(file)
      end
      success
    end

    private

    def sprocketize(path)
      path = Pathname.new(path)

      output_filename = without_preprocessor_extension(path.basename.to_s)
      output_path = Pathname.new(File.join(@destination, output_filename))

      UI.info "Sprockets will compile #{output_filename}"

      FileUtils.mkdir_p(output_path.parent) unless output_path.parent.exist?
      output_path.open('w') do |f|
        f.write @sprockets[output_filename]
      end

      UI.info "Sprockets compiled #{output_filename}"
      Notifier.notify "Sprockets compiled #{output_filename}"
    rescue ExecJS::ProgramError => ex
      UI.error "Sprockets failed compiling #{output_filename}"
      UI.error ex.message
      Notifier.notify "Sprockets failed compiling #{output_filename}!", :priority => 2, :image => :failed

      false
    end

    def without_preprocessor_extension(filename)
      filename.gsub(/^(.*\.(?:js|css))\.[^.]+$/, '\1')
    end
  end
end
