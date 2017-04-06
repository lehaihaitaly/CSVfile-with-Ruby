require 'csv'
@countryHash = Hash.new
@nameHash = Hash.new
@nameFile = 'SalesJan2009.csv'
@totalPricesInJanuary = Array.new
def readCSV
	ar = Array.new
	client = Array.new
	CSV.foreach(@nameFile,headers:true ) do |row|
		ar<<row['Country']
		client << row['Name'] 
		@totalPricesInJanuary<<row['Price'].to_i
	end
	@countryHash = ar.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
	@nameHash = client.inject(Hash.new(0)) {|h,x| h[x]+=1;h}
end


def numberOfTransactions
   return @countryHash.values.max
end

def countryWithMostTransactions
	return @countryHash.key(@countryHash.values.max)
end

def totalPricesByCountry
	totalPricesByCountry = Array.new
	CSV.foreach(@nameFile,headers:true ) do |row|
		totalPricesByCountry<< row['Price'].to_i if row['Country'] == @countryHash.key(@countryHash.values.max)
		end
		sum = 0
		totalPricesByCountry.each do |totalPrice|
			sum = sum+totalPrice
			end
		return sum
end

def potentialClients
	names= Array.new
	@nameHash.each do |key, value| 
	if value >1
   names<<key		
end
	end
	return names.sort
end

def totalPricesInJanuary
	sum = 0
	price = Hash.new
		@totalPricesInJanuary.each do |totalPrice|
			sum = sum+totalPrice
			end
		price[:total_Price_in_January]= sum
		return price
	end 
readCSV
print "Biggest number of transactions is: "
puts numberOfTransactions
print "Country with most transactions is: "
puts countryWithMostTransactions
print "Total price is: "
puts totalPricesByCountry
print "Potential clients with more than 1 transactions in alphabetial order are: "
print potentialClients
puts
puts totalPricesInJanuary