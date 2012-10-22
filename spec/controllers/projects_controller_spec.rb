require 'spec_helper'

describe ProjectsController do
  describe 'create' do
    it 'should be able to create a new project' do
      m = mock('project', :first => 'first')
      Project.should_receive(:create!).and_return(m)
      post :create, {:project => m}
      response.should redirect_to('/user/index')
    end
  end
  
  
  describe 'edit' do
    it 'should be able to edit a project' do
      m = stub_model(Project)
      Project.stub!(:find).and_return(m)
      get :edit, :id => m.id
      response.should be_success
    end
  end
  
  
  describe 'update' do
    it 'should be able to update a project field' do
      m = stub_model(Project)
      m.stub!(:update_attributes).and_return(true)
      Project.should_receive(:find).with('1').and_return(m)																																																																																																																																																																																																																																															
      put :update, :id => m.id, :project => {}
      response.should redirect_to('/projects/1')
    end
  end
  
  
  describe 'destroy' do
    it 'should be able to destroy a project' do
      m = stub_model(Project, :destroy => true)
      m.stub!(:find).and_return(m)
      Project.should_receive(:find).with(m.id.to_s).and_return(m)
 #     m.should_receive(:destory)
      post :destroy, :id => m.id.to_s
      #response.should redirect_to(movies_path)
    end
  end

  
  describe 'index' do
    before do
    end
  end
end
end