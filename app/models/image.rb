class Image < ActiveRecord::Base
	has_attached_file :pics, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
    validates_attachment_content_type :pics, :content_type => /\Aimage\/.*\Z/

    enum image_type: ["God","Sivanmalai","Person"]

    validates :image_type,presence: true
    validates :pics, attachment_presence: true
end
