require_relative('../models/transactions.rb')
require_relative('../models/merchants.rb')
require_relative('../models/tags.rb')
also_reload('../models/*')
require("pry")

get '/transactions' do
  @transactions = Transaction.all
  @transaction_total = Transaction.total_trans.to_f
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

get "/transactions/sorted" do
  @transaction_total = Transaction.total_trans
  @transactions = Transaction.order_by_date if params["sort_by"] == "Date"
  @transactions = Transaction.order_by_tag if params["sort_by"] == "Tag"
  @transactions = Transaction.order_by_merchant if params["sort_by"] == "Merchant"
  erb(:"transactions/index")
end

get '/transactions/:id' do
  @transactions = Transaction.find(params['id'].to_i)
  erb( :"transactions/index" )
end

post '/transactions/:id/delete' do
  Transaction.delete(params[:id])
  redirect to("/transactions")
end
