class Product
	attr_reader :title

	@@products = []

	def initialize(options={})
		@title = options[:title]
		add_to_products
	end

	def self.all
		@@products
	end

	private
	def add_to_products
		if @@products.map { |product| product.title }.include? self.title
			raise DuplicateProductError, "#{self.title} already exists."
		else
			@@products << self
		end
	end
end