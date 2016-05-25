class Product
	attr_reader :title, :price, :stock

	@@products = []

	def initialize(options={})
		@title, @price, @stock = options[:title], options[:price], options[:stock]
		add_to_products
	end

	def self.all
		@@products
	end

	def self.find_by_title(title)
		@@products.find { |product| product.title == title }
	end

	def self.in_stock
		@@products.select { |product| product.in_stock? }
	end

	def in_stock?
		!stock.zero?
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