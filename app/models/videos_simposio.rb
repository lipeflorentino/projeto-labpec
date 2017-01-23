class VideosSimposio < ApplicationRecord
  belongs_to :simposio
  
  validate :link_youtube
  
  
  private
    def link_youtube
      if video
        uri = URI.parse(video)
        if uri.host.split('.')[0] != "www" || uri.host.split('.')[1] != "youtube" ||  uri.host.split('.')[2] != "com" || uri.path != "/watch"
          errors.add :video, 'Video deve ser um link completo para o youtube!'
        end
      end
    end
  
end
