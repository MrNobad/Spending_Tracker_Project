require_relative('../models/tags.rb')
also_reload('../models/*')

get '/tags' do
  @tags = Tag.all()
  erb(:"tags/index")
end

get '/tags/:id' do
  @tags = Tag.find(params["id"].to_i)
end
