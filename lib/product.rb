class Product
	attr_reader :title, :price
	attr_accessor :stock

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

	def decrease_stock_count
		self.stock -= 1
	end

	def increase_stock_count
		self.stock += 1
	end

	private
	def add_to_products
		if @@products.map { |product| product.title }.include? title
			raise DuplicateProductError, "'#{title}' already exists."
		else
			@@products << self
		end
	end
end