class Transaction
	attr_reader :id, :product, :customer

	@@id = 1
	@@transactions = []

	def initialize(customer, product)
		@id, @customer, @product = @@id, customer, product
		@@id += 1
		add_to_transactions
		ship_product
	end

	def self.all
		@@transactions
	end

	def self.find(id)
		@@transactions.find { |transaction| transaction.id == id }
	end

	private
	def add_to_transactions
		@@transactions << self
	end

	def ship_product
		product.decrease_stock_count
	end
end