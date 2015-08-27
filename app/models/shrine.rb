class Shrine < ActiveRecord::Base
	has_many :species
	validates :name,:description, presence: true

	attr_accessor :picture

	after_save :save_picture_profile, if: :picture 
	def save_picture_profile
		filename 	= picture.original_filename
		folder		= "public/shrines/#{id}/profile"

		FileUtils::mkdir_p folder

		f = File.open File.join(folder, filename), "wb"
		f.write picture.read()
		f.close

		self.picture = nil

		update image: filename
	end	
end