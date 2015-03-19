class Image < ActiveRecord::Base
	has_attached_file :pics, :styles => { :medium => "300x300>", :thumb => "100x100>", :big => "1351x900!" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :pics, :content_type => /\Aimage\/.*\Z/

    IMAGETYPE = ["God","Sivanmalai","Person"]
    enum image_type: IMAGETYPE

    validates :image_type,presence: true
    validates :pics, attachment_presence: true

    def self.image_type_enum
    	IMAGETYPE.each_with_index.to_a
  	end

  	def big_image
  		pics.url(:big)
  	end
end
