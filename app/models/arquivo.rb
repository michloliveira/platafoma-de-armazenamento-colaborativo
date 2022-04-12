class Arquivo < ApplicationRecord
    include ImageUploader::Attachment(:image)
    belongs_to :user
    validates :description, presence: true
end
