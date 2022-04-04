class Arquivo < ApplicationRecord
    include ImageUploader::Attachment(:image)

    validates :description, presence: true
end
