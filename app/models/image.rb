class Image < ActiveRecord::Base
  has_many :images
  belongs_to :image

	has_attached_file :pics, :styles => { :medium => "450x293!", :thumb => "721x658!", :big => "1351x900!" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :pics, :content_type => /\Aimage\/.*\Z/

  scope :eligible_parent_image, ->(image_type_id) {where(image_type: image_type_id)}
  scope :parent_image, -> {where("image_id is null")}

  IMAGETYPE = ["god","sivanmalai","person"]
  enum image_type: IMAGETYPE

  validates :image_type,presence: true
  validates :pics, attachment_presence: true

  def self.image_type_enum
  	IMAGETYPE.each_with_index.to_a
	end

  def sized_image(size)
    pics.url(size.to_sym)
  end

  def self.eligible_parent(*options)
    image_type_id = []
    options.each{|type| image_type_id << IMAGETYPE.index(type)}
    eligible_parent_image(image_type_id).parent_image
  end
end
