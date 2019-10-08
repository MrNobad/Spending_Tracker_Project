require_relative('../models/tags.rb')
also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  @transaction_tag_total = Tag.total_tag_amount
  erb(:"tags/index")
end

get '/tags/new' do
  erb(:"tags/new")
end

post '/tags' do
  tag = Tag.new(params)
  tag.save
  redirect to("/tags")
end

get '/tags/:id' do
  @tags = Tag.find(params["id"].to_i)
end

post '/tags/:id/delete' do
  Tag.delete(params[:id])
  redirect to("/tags")
end
