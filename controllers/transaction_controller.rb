require_relative('../models/transactions.rb')
require_relative('../models/merchants.rb')
require_relative('../models/tags.rb')
also_reload('../models/*')

get '/transactions' do
  @transactions = Transaction.all
  erb(:"transactions/index")
end

get '/transactions/new' do
  @merchants = Merchant.all
  @tags = Tag.all
  erb(:"transactions/new")
end

post '/transactions' do
  transaction = Transaction.new(params)
  transaction.save
  redirect to("/transactions")
end

get '/transactions/:id' do
  @transactions = Transaction.find(params['id'].to_i)
  erb( :"transactions/index" )
end

post '/transaction/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end
