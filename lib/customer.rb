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

	def purchase(product, date = Date.today)
		date = date.is_a?(String) ? Date.parse(date) : date
		if product.in_stock?
			Transaction.new(self, product, date)
		else
			raise OutOfStockError, "'#{product.title}' is out of stock."
		end
	end

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