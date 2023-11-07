module Dartsass
  module Runner
    EXEC_PATH      = "#{Pathname.new(__dir__).to_s}/../../exe/dartsass"
    CSS_LOAD_PATH  = Rails.root.join("app/assets/stylesheets")
    CSS_BUILD_PATH = Rails.root.join("app/assets/builds")

    module_function

    def dartsass_build_mapping
      Rails.application.config.dartsass.builds.map { |input, output|
        "#{Shellwords.escape(CSS_LOAD_PATH.join(input))}:#{Shellwords.escape(CSS_BUILD_PATH.join(output))}"
      }.join(" ")
    end

    def dartsass_build_options
      Rails.application.config.dartsass.build_options
    end

    def dartsass_load_paths
      [ CSS_LOAD_PATH ].concat(Rails.application.config.assets.paths).map { |path| "--load-path #{Shellwords.escape(path)}" }.join(" ")
    end

    def dartsass_compile_command
       "#{EXEC_PATH} #{dartsass_build_options} #{dartsass_load_paths} #{dartsass_build_mapping}"
    end
  end
end
