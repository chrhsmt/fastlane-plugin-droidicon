module Fastlane
  module Actions
    class DroidiconAction < Action
      def self.needed_icons
        {
          android: {
            'mipmap-mdpi'    => '48x48',
            'mipmap-hdpi'    => '72x72',
            'mipmap-xhdpi'   => '96x96',
            'mipmap-xxhdpi'  => '144x144',
            'mipmap-xxxhdpi' => '192x192',
          },
        }
      end
      def self.run(params)
        fname = params[:appicon_image_file]
        basename = File.basename(fname, File.extname(fname))
        basepath = Pathname.new("#{params[:res_path]}")

        require 'mini_magick'
        image = MiniMagick::Image.open(fname)

        UI.user_error!("Minimum width of input image should be 1024") if image.width < 1024
        UI.user_error!("Minimum height of input image should be 1024") if image.height < 1024
        UI.user_error!("Input image should be square") if image.width != image.height

        FileUtils.mkdir_p(basepath)

        self.needed_icons[:android].each do |scale, sizes|
          sizes.each do |size|
            width, height = size.split('x').map { |v| v.to_f * scale.to_i }

            image = MiniMagick::Image.open(fname)
            image.format 'png'
            image.resize "#{width}x#{height}"
            image.write File.join(basepath, scale, params[:generated_file_name])

          end
        end

        UI.success("Successfully stored app icon at '#{basepath}'")
      end

      def self.description
        "Generate required icon sizes and iconset from a master application icon"
      end

      def self.authors
        ["@chrhsmt"]
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :appicon_image_file,
                                  env_name: "APPICON_IMAGE_FILE",
                               description: "Path to a square image file, at least 1024x1024",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :generated_file_name,
                                  env_name: "GENERATED_FILE_NAME",
                             default_value: "ic_launcher.png",
                               description: "Name of file generated",
                                  optional: true,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :res_path,
                                  env_name: "RES_PATH",
                             default_value: File.join("app", "src", "main", "res"),
                               description: "Path to the Resouce for the generated iconset",
                                  optional: true,
                                      type: String)
        ]
      end

      def self.is_supported?(platform)
        [:android].include?(platform)
        true
      end
    end
  end
end
