#	This file is meant to be called once when the system is deployed - it 
#	initializes any projects/risks/users required for initial operation.
#	The current version only initializes the admin user, who should create 
#	any other user accounts required (which, in turn, can also create any 
#	required projects/risks. 
admin = User.create(:first=>:ADMIN, :last => :ACCOUNT, :email => "admin@gmail.com", :username => :admin, :password => :admin, :status => "active")
admin.admin = true; admin.save