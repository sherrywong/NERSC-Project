require 'spec_helper'

describe ProjectController do
  describe 'new' do
    it 'should be able to create a new project' do
      p = mock('project', :id => 1, :name => 'n', :description => 't', :create_at => 'ca', :updated_at => 'dt')
      Project.should_receive(:new).and_return(p)
      post :new, {:project => p}
      response.should redirect_to('/user/project/index')
    end
  end
  
  
  describe 'edit' do
    it 'should be able to edit a project' do
      p = stub_model(Project)
      Project.stub!(:find).and_return(p)
      get :edit, :id => p.id
      response.should be_success
    end
  end
  
  
  describe 'update' do
    it 'should be able to update a project field' do
      p = stub_model(Project)
      p.stub!(:update_attributes).and_return(true)
      Project.should_receive(:find).with('1').and_return(m)																																																																																																																																																																																																																																															
      put :update, :id => p.id, :project => {}
      response.should redirect_to('/projects/1')
    end
  end
  
  
  describe 'destroy' do
    it 'should be able to destroy a project' do
      p = stub_model(Project, :destroy => true)
      p.stub!(:find).and_return(p)
      Project.should_receive(:find).with(p.id.to_s).and_return(p)
 #     p.should_receive(:destory)
      post :destroy, :id => p.id.to_s
      #response.should redirect_to(movies_path)
    end
  end

  
  describe 'index' do
    before do
    end
  end
end
