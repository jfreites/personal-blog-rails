class Article < ActiveRecord::Base
	include AASM
	
	belongs_to :user
	has_many :comments, dependent: :destroy # Elimina el articulo sin importar que tiene comentarios
	has_many :has_categories, dependent: :destroy # Elimina el articulo sin importar que tenga categorias
	has_many :categories, through: :has_categories
	
	validates :title, presence: true
	validates :body, presence: true, length: { minimum: 20 }
	before_create :set_visits_count
	after_create :save_categories
	after_create :send_mail

	has_attached_file :cover, styles: { medium: "1280x720", thumb: "800x600", mini: "200x150" }
	validates_attachment_content_type :cover, content_type: /\Aimage\/.*\Z/

	#scope :ultimos, ->{ order("created_at DESC").limit(10) } has conflict with paginate
	scope :ultimos, ->{ order("created_at DESC") }

	# scope: La gema de AASM ya trae algo como esto
	scope :publicados, ->{ where(state: "published") }
	# ó
	#def self.publicados
	#	Article.where(state:"published")
	#end
	# end - scope

	# Custom setter or Virtual Attribute
	def categories=(value)
		@categories = value
	end

	def update_visits_count
		self.update(visits_count: self.visits_count + 1)
	end

	aasm column: "state" do
		state :in_draft, initial: true
		state :published

		event :publish do
			transitions from: :in_draft, to: :published
		end

		event :unpublish do
			transitions from: :published, to: :in_draft
		end
	end

	private

	def send_mail
		ArticleMailer.new_article(self).deliver_later
	end

	def save_categories
		#raise @categories.to_yaml
		unless @categories.nil?
			@categories.each do |category_id|
				HasCategory.create(category_id: category_id, article_id: self.id)
			end
		end
	end

	def set_visits_count
		self.visits_count ||= 0
	end
end
