class Simposio < ApplicationRecord
  has_many :video_simposios
  belongs_to :user
end
