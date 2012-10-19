# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


User.create(:first=>:ADMIN, :last => :ACCOUNT, :email => "admin@gmail.com", :admin => true, :username => :admin, :password => :admin)
User.create(:first=>:Anensshiya, :last => :Govinthasamy, :email => "anna@gmail.com", :admin => false, :username => :anna, :password => :agovinthasamy)
User.create(:first=>:Sherry, :last=> :Wong, :email => "bob@gmail.com", :admin=>false, :username=>:bob, :password => :swong)
User.create(:first=>:Elise, :last => :McCallum, :email => "elise@gmail.com", :admin => false, :username => :elise, :password => :emccallum)
User.create(:first=>:Lingbo, :last => :Zhang, :email=> "linda@gmail.com", :admin=>false, :username=>:linda, :password => :lzhang)
User.create(:first=>:Jia, :last=> :Teoh, :email => "jason@gmail.com", :admin=>false, :username=>:jason, :password => :jteoh)

Project.create(:name=>:MyFirstProject, :description => "This is the first test project")
Project.create(:name=>:MySecondProject, :description => "This is my second test project")

