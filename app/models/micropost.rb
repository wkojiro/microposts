class Micropost < ActiveRecord::Base
  belongs_to :user
  belongs_to :origin, class_name: "Micropost"
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
  mount_uploader :image,ImageUploader
end
