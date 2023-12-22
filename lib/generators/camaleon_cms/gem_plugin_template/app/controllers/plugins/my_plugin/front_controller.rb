module Plugins
  module PluginClass
    class FrontController < CamaleonCms::Apps::PluginsFrontController
      skip_before_action :verify_authenticity_token, only: [:your_email_sending_action]
      include Plugins::PluginClass::MainHelper
      def index
        # actions for frontend module
      end

      # add custom methods below
    end
  end
end
