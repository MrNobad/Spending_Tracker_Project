require_relative('../models/merchants.rb')
also_reload('../models/*')

get '/merchants' do
  @merchants = Merchant.all()
  erb(:"merchants/index")
end

get '/merchants/:id' do
  @merchants = Merchant.find(params["id"].to_i)
end
