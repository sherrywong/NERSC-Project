# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)



admin = User.create(:first=>:ADMIN, :last => :ACCOUNT, :email => "admin@gmail.com", :admin => true, :username => :admin, :password => :admin, :status => :active)
anna = User.create(:first=>:Anensshiya, :last => :Govinthasamy, :email => "anna@gmail.com", :admin => false, :username => :anna, :password => :agovinthasamy, :status => :active)
bob = User.create(:first=>:Sherry, :last=> :Wong, :email => "bob@gmail.com", :admin=>false, :username=>:bob, :password => :swong, :status => :active)
elise = User.create(:first=>:Elise, :last => :McCallum, :email => "elise@gmail.com", :admin => false, :username => :elise, :password => :emccallum, :status => :active)
linda = User.create(:first=>:Lingbo, :last => :Zhang, :email=> "linda@gmail.com", :admin=>false, :username=>:linda, :password => :lzhang, :status => :retired)
jason = User.create(:first=>:Jia, :last=> :Teoh, :email => "jason@gmail.com", :admin=>false, :username=>:jason, :password => :jteoh, :status => :active)

proj1 = admin.create_project(:name=>:MyFirstProject, :description => "This is the first test project")
#proj1.owner = admin
proj1.add_members(User.all.map {|x| x.id})
admin.create_risk_for_project(proj1, {:cost=> "High", :description => "Project 1 risk 1", :probability => "Low", :title => "Risk 1"})
anna.create_risk_for_project(proj1, {:cost=> "Low", :description => "Project 1 risk 2", :probability => "Low", :title => "Risk 2"})


proj2 = admin.create_project(:name=>:MySecondProject, :description => "This is my second test project") #only admin can create, set owner to jason after.
proj2.owner = jason
proj2.add_members(User.find_all_by_admin(true).map {|x| x.id})


