require 'spec_helper'

describe User do
  describe 'can_edit' do
    it 'should be able to edit user' do
      @pm = stub_model(ProjectMembership)
      ProjectMembership.stub!(:find_by_user_id_and_project_id).and_return(false)
      #User.should_return(false)
    end
  end

  describe 'create_user' do
    it 'should be able to create a new user'
 #     usr = mock('user')
 #     User.should_receive(:new).and_return(usr)
#      usr.should_receive(:save).and_return(usr)
      #      post :new, {:user => usr}

  end

  describe 'owner?' do
    it 'should describe if user is an owner of a project'
#      @p = stub_model(Project)
#      @p.stub!(:id).and_return(3)
#      @u = stub_model(User)
#      @p.stub!(:owner).and_return(@u)
#      Project.should_receive(:find_by_id).with(3).and_return(@p)
#      Project.should_receive(:owner).with(@p).and_return(@u)
  end

  describe 'create_project' do
    it 'should create a project' do
      p = mock('project')
      Project.should_receive(:new).and_return(p)
    end
  end
end
