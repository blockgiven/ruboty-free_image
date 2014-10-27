require "ruboty/free_image/actions/flickr"

module Ruboty
  module Handlers
    class FreeImage < Base
      DEFAULT_PROVIDER = 'flickr'

      env :FLICKR_API_KEY, 'flickr api key'
      env :FLICKR_API_SECRET, 'flickr api secret key'

      on /free image (?:(?<keyword>.*) (?<count>\d+)|(?<keyword>.*))(?:from (?<provider>.*))?/, name: 'free_image', description: 'search free images'

      def free_image(message)
        provider = message[:provider] || DEFAULT_PROVIDER
        case provider.downcase
        when 'flickr'
          Ruboty::FreeImage::Actions::Flickr.new(message).call
        else
          message.reply("i can't search free images from #{provider}. make a pull request for ruboty-free_image!")
        end
      end
    end
  end
end
