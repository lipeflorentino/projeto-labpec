class DocumentosSimposio < ApplicationRecord
  belongs_to :simposio
  mount_uploader :arquivo, FileUploader
end
