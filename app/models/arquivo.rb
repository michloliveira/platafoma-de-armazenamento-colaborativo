class Arquivo < ApplicationRecord
    include ImageUploader::Attachment(:image)
    has_many :copia
    has_many :users, through: :copia
    validates :description, presence: true
end
