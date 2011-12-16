require 'guard'
require 'guard/guard'
require 'erb'

require 'sprockets'

module Guard
  class Sprockets < Guard
    def initialize(watchers=[], options={})
      super 
      
      # init Sprocket env for use later
      @sprockets_env = ::Sprockets::Environment.new
      
      @asset_paths = options.delete(:asset_paths) || []
      # add the asset_paths to the Sprockets env
      @asset_paths.each do |p|
        @sprockets_env.append_path p
      end
      # store the output destination
      @destination = options.delete(:destination)
      @opts = options
    end

    def start
       UI.info "Sprockets waiting for asset file changes..."
       UI.info " -- external asset paths = [#{@asset_paths.inspect}]" unless @asset_paths.empty?
       UI.info " -- destination path = [#{@destination.inspect}]"
    end
    
    def run_all
      true
    end

    def run_on_change(paths)
      paths.each{ |js| sprocketize(js) }
      true
    end
    
    private
    
    def sprocketize(path)
      changed = Pathname.new(path)

      @sprockets_env.append_path changed.dirname

      output_basename = changed.basename.to_s
      if m = output_basename.match(/^(.*\.(?:js|css))\.[^.]+$/)
        output_basename = m[1]
      end

      output_file = Pathname.new(File.join(@destination, output_basename))
      UI.info "Sprockets creating file #{output_file}"
      FileUtils.mkdir_p(output_file.parent) unless output_file.parent.exist?
      output_file.open('w') do |f|
        f.write @sprockets_env[output_basename]
      end
    end
  end
end
