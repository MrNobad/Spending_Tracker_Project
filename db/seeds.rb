require_relative( "../models/merchants" )
require_relative( "../models/tags" )
require_relative( "../models/transactions" )
require("pry-byebug")

Transaction.delete_all()
Merchant.delete_all()
Tag.delete_all()


merchant1 = Merchant.new({"name" => "Tesco"})
merchant1.save
merchant2 = Merchant.new({"name" => "Lothian Transport"})
merchant2.save
merchant3 = Merchant.new({"name" => "Edinburgh Council"})
merchant3.save
merchant4 = Merchant.new({"name" => "Vapourize"})
merchant4.save
merchant5 = Merchant.new({"name" => "O2"})
merchant5.save

tag1 = Tag.new({"type" => "Groceries"})
tag1.save
tag2 = Tag.new({"type" => "Luxury"})
tag2.save
tag3 = Tag.new({"type" => "Household Bills"})
tag3.save
tag4 = Tag.new({"type" => "Phone"})
tag4.save
tag5 = Tag.new({"type" => "Transport"})
tag5.save

transaction1 = Transaction.new({"date_time" => "12/14/2019", "merchant_id" => merchant1.id, "tag_id" => tag1.id, "amount" => 37.50})
transaction2 = Transaction.new({"date_time" => "12/18/2019", "merchant_id" => merchant2.id, "tag_id" => tag5.id, "amount" => 57.00})
transaction3 = Transaction.new({"date_time" => "12/23/2019", "merchant_id" => merchant3.id, "tag_id" => tag3.id, "amount" => 112.35})
transaction4 = Transaction.new({"date_time" => "12/19/2019", "merchant_id" => merchant4.id, "tag_id" => tag2.id, "amount" => 19.95})
transaction5 = Transaction.new({"date_time" => "12/09/2019", "merchant_id" => merchant5.id, "tag_id" => tag4.id, "amount" => 25.00})
transaction6 = Transaction.new({"date_time" => "11/11/2019", "merchant_id" => merchant1.id, "tag_id" => tag2.id, "amount" => 23.60})

transaction1.save
transaction2.save
transaction3.save
transaction4.save
transaction5.save
transaction6.save

binding.pry
nil
