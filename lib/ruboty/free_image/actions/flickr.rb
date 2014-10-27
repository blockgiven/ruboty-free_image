require 'flickraw'

module Ruboty
  module FreeImage
    module Actions
      class Flickr < Ruboty::Actions::Base
        def call
          FlickRaw.api_key = ENV['FLICKR_API_KEY']
          FlickRaw.shared_secret = ENV['FLICKR_API_SECRET']

          count = message[:count] || 10
          # CC BY, CC BY-SA
          license = "4,5"

          photos = flickr.photos.search(license: license, per_page: count, text: message[:keyword]).map do |photo|
            {
              image_url: FlickRaw.url_n(photo),
              title: photo.title,
              url: FlickRaw.url_photopage(photo)
            }
          end

          photos_message = photos.map {|photo|
            "#{photo[:title]}: #{photo[:url]}#{$/}#{photo[:image_url]}"
          }.join($/ * 2)

          message.reply(photos_message)
        end
      end
    end
  end
end
