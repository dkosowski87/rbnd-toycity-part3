class Transaction
	attr_reader :id, :customer, :product, :date

	@@id = 1
	@@transactions = []

	def initialize(customer, product, date = Date.today)
		@id, @customer, @product, @date = @@id, customer, product, date
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

	#Finds the particular transaction by parameters passed as an option hash.
	#It iterates throught the option hash to apply particular filters to the search.
	def self.find_by(options={})
		transactions = @@transactions.dup
		options.merge!({date: Date.parse(options[:date])}) if options[:date]
		options.each do |key, value|
			transactions.select! { |transaction| transaction.send(key) == value }
		end
		return transactions
	end

	def self.find_between_dates(start_date, end_date)
		@@transactions.select { |transaction| transaction.date.between?(Date.parse(start_date), Date.parse(end_date)) }
	end

	private
	def add_to_transactions
		@@transactions << self
	end

	def ship_product
		product.decrease_stock_count
	end
end