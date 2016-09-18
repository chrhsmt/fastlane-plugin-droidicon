module Fastlane
  module Helper
    class DroidiconHelper
      # class methods that you define here become available in your action
      # as `Helper::DroidiconHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the droidicon plugin helper!")
      end
    end
  end
end
