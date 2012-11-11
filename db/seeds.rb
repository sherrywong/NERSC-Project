# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



admin = User.create(:first=>:ADMIN, :last => :ACCOUNT, :email => "admin@gmail.com", :username => :admin, :password => :admin, :status => "active")
admin.admin = true; admin.save

anna = admin.create_user(:first=>:Anensshiya, :last => :Govinthasamy, :email => "anna@gmail.com", :username => :anna, :password => :agovinthasamy)
bob = admin.create_user(:first=>:Sherry, :last=> :Wong, :email => "bob@gmail.com", :username=>:bob, :password => :swong)
elise = admin.create_user(:first=>:Elise, :last => :McCallum, :email => "elise@gmail.com" , :username => :elise, :password => :emccallum)
linda = admin.create_user(:first=>:Lingbo, :last => :Zhang, :email=> "linda@gmail.com",  :username=>:linda, :password => :lzhang, :admin => "false")
jason = admin.create_user(:first=>:Jia, :last=> :Teoh, :email => "jason@gmail.com",  :username=>:jason, :password => :jteoh)

proj1 = admin.create_project(:name=>:MyFirstProject, :description => "This is the first test project")
#proj1.owner = admin
proj1.add_members(User.all.map {|x| x.id})
Risk.create_risk(admin.id, proj1.id, {:cost=> 3, :schedule => 2, :technical => 1, :status=> "active", :early_impact=> "2008-11-20", :last_impact=> "2013-10-20", :owner_id=>"admin", :description => "Project 1 risk 1", :probability => 2, :title => "Risk"}) 
Risk.create_risk(admin.id, proj1.id, {:cost=> 1, :schedule => 2, :technical => 3, :status=> "active", :early_impact=> "2013-11-20", :last_impact=> "2013-11-2", :owner_id=>"admin", :description => "Project 1 risk 2", :probability => 3, :title => "Risk 2"})


proj2 = admin.create_project(:name=>:MySecondProject, :description => "This is my second test project") #only admin can create, set owner to jason after.
proj2.owner = jason
proj2.add_members(User.find_all_by_admin(true).map {|x| x.id})
