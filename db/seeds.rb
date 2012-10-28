# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


admin = User.create(:first=>:ADMIN, :last => :ACCOUNT, :email => "admin@gmail.com", :admin => true, :username => :admin, :password => :admin)
anna = admin.add_new_user(:first=>:Anensshiya, :last => :Govinthasamy, :email => "anna@gmail.com", :admin => false, :username => :anna, :password => :agovinthasamy)
bob = admin.add_new_user(:first=>:Sherry, :last=> :Wong, :email => "bob@gmail.com", :admin=>false, :username=>:bob, :password => :swong)
elise = admin.add_new_user(:first=>:Elise, :last => :McCallum, :email => "elise@gmail.com", :admin => false, :username => :elise, :password => :emccallum)
linda = admin.add_new_user(:first=>:Lingbo, :last => :Zhang, :email=> "linda@gmail.com", :admin=>false, :username=>:linda, :password => :lzhang)
jason = admin.add_new_user(:first=>:Jia, :last=> :Teoh, :email => "jason@gmail.com", :admin=>false, :username=>:jason, :password => :jteoh)

proj1 = admin.create_project(:name=>:MyFirstProject, :description => "This is the first test project")
#proj1.owner = admin
proj1.add_members(User.all.map {|x| x.id})
admin.create_risk_for_project(proj1, {:cost=> "High", :description => "Project 1 risk 1", :probability => "Low", :title => "Risk 1"})
anna.create_risk_for_project(proj1, {:cost=> "Low", :description => "Project 1 risk 2", :probability => "Low", :title => "Risk 2"})


proj2 = admin.create_project(:name=>:MySecondProject, :description => "This is my second test project") #only admin can create, set owner to jason after.
proj2.owner = jason
proj2.add_members(User.find_all_by_admin(true).map {|x| x.id})


