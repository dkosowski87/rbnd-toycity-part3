class Customer
	attr_reader :name

	@@customers = []

	def initialize(options={})
		@name = options[:name]
		add_to_customers
	end

	def self.all
		@@customers
	end

	def self.find_by_name(name)
		@@customers.find { |customer| customer.name == name}
	end

	#Allows for purchasing a product. Creates a new transaction with the proper data if the product is in stock.
	#Takes a product and a date argument. The date can be passed as string "2016-05-25" or as a date value type.
	#The date defaults to today's date.
	def purchase(product, date = Date.today)
		date = date.is_a?(String) ? Date.parse(date) : date
		if product.in_stock?
			Transaction.new(self, product, date)
		else
			raise OutOfStockError, "'#{product.title}' is out of stock."
		end
	end

	#Allows for returning a product. Checks if a transaction has been made in the store.
	#It takes a product and a defect argument. The defect argument if true signals that the product bought has a defect.
	def return_product(product, defect = false)
		if Transaction.find_by(customer: self, product: product).empty?
			raise NotRecordedTransactionError, "There was no such transaction recorded."
		else
			ProductReturn.new(self, product, defect)
		end
	end

	private
	def add_to_customers
		if Customer.find_by_name(name)
			raise DuplicateCustomerError, "'#{name}' already exists."
		else
			@@customers << self
		end
	end
end