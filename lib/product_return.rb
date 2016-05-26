class ProductReturn
	attr_reader :id, :customer, :product

	@@id = 1
	@@product_returns = []
	@@items_in_service = 0

	def initialize(customer, product, defect)
		@id, @customer, @product = @@id, customer, product
		@@id += 1
		add_to_product_returns
		defect ? send_to_service : accept_to_inventory
	end

	def self.all
		@@product_returns
	end

	def self.find(id)
		@@product_returns.find { |product_return| product_return.id == id }
	end

	def self.items_in_service
		@@items_in_service
	end

	private
	def add_to_product_returns
		@@product_returns << self	
	end

	def accept_to_inventory
		product.increase_stock_count
	end

	def send_to_service
		@@items_in_service += 1
	end
end