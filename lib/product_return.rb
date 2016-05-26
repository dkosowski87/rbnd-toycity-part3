class ProductReturn
	attr_reader :id, :customer, :product

	@@id = 1
	@@product_returns = []

	def initialize(customer, product)
		@id, @customer, @product = @@id, customer, product
		@@id += 1
		add_to_product_returns
		accept
	end

	def self.all
		@@product_returns
	end

	def self.find(id)
		@@product_returns.find { |product_return| product_return.id == id }
	end

	private
	def add_to_product_returns
		@@product_returns << self	
	end

	def accept
		product.increase_stock_count
	end
end