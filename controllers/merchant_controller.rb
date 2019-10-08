require_relative('../models/merchants.rb')
also_reload('../models/*')

get '/merchants' do
  @merchants = Merchant.all()
  @transaction_merchant_total = Merchant.total_merchant_amount
  erb(:"merchants/index")
end

get '/merchants/new' do
  erb(:"merchants/new")
end

post '/merchants' do
  merchant = Merchant.new(params)
  merchant.save
  redirect to("/merchants")
end

get '/merchants/:id' do
  @merchants = Merchant.find(params["id"].to_i)
end

post '/merchants/:id/delete' do
  Merchant.delete(params[:id])
  redirect to("/merchants")
end
