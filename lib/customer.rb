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

	def purchase(product)
		if product.in_stock?
			Transaction.new(self, product)
		else
			raise OutOfStockError, "'#{product.title}' is out of stock."
		end
	end

	def return_product(product, options={})
		if Transaction.find_by(customer: self, product: product).empty?
			raise NotRecordedTransactionError, "There was no such transaction recorded."
		else
			ProductReturn.new(self, product, options[:defect])
		end
	end

	private
	def add_to_customers
		if @@customers.map { |customer| customer.name }.include? name
			raise DuplicateCustomerError, "'#{name}' already exists."
		else
			@@customers << self
		end
	end
end