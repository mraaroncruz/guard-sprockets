require 'guard'
require 'guard/guard'

require 'sprockets'
require 'execjs'

module Guard
  class Sprockets < Guard
    def initialize(watchers=[], options={})
      super

      @sprockets = ::Sprockets::Environment.new

      @asset_paths = options.delete(:asset_paths) || []
      @asset_paths.each do |p|
        @sprockets.append_path p
      end

      @destination = options.delete(:destination)
      @root_file   = options.delete(:root_file)

      @opts = options
    end

    def start
       UI.info "Sprockets activated."
       UI.info "  - external asset paths = #{@asset_paths.inspect}" unless @asset_paths.empty?
       UI.info "  - destination path = #{@destination.inspect}"
       UI.info "Sprockets guard is ready and waiting for some file changes..."

       run_all
    end

    def run_all
      run_on_change([ @root_file ]) if @root_file

      true
    end

    def run_on_change(paths)
      if @root_file
        sprocketize(@root_file)
      else
        paths.each do |file|
          sprocketize(file)
        end
      end

      true
    end

    private

    def sprocketize(path)
      changed = Pathname.new(path)

      @sprockets.append_path changed.dirname

      output_basename = changed.basename.to_s
      output_basename.gsub!(/^(.*\.(?:js|css))\.[^.]+$/, '\1')

      output_file = Pathname.new(File.join(@destination, output_basename))

      UI.info "Sprockets: compiling #{output_file}"

      FileUtils.mkdir_p(output_file.parent) unless output_file.parent.exist?
      output_file.open('w') do |f|
        f.write @sprockets[output_basename]
      end

      UI.info "Sprockets finished compiling #{output_file}"
      Notifier.notify "Compiled #{output_basename}"
    rescue ExecJS::ProgramError => e
      UI.error "Sprockets failed to compile #{output_file}"
      UI.error e.message
      Notifier.notify "Syntax error in #{output_basename}: #{e.message}", :priority => 2, :image => :failed
    end
  end
end
