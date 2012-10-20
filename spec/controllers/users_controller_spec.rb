require 'spec_helper'

describe UsersController do
  describe 'create' do
    it 'should be able to create a new user' do
      m = mock('user', :first => 'first')
      User.should_receive(:create!).and_return(m)
      post :create, {:user => m}
      response.should redirect_to('/user/index')
    end
  end
  
  
  describe 'edit' do
    it 'should be able to edit a user' do
      m = stub_model(User)
      User.stub!(:find).and_return(m)
      get :edit, :id => m.id
      response.should be_success
    end
  end
  
  
  describe 'update' do
    it 'should be able to update a user field' do
      m = stub_model(User)
      m.stub!(:update_attributes).and_return(true)
      User.should_receive(:find).with('1').and_return(m)																																																																																																																																																																																																																																															
      put :update, :id => m.id, :user => {}
      response.should redirect_to('/users/1')
    end
  end
  
  
  describe 'destroy' do
    it 'should be able to destroy a user' do
      m = stub_model(User, :destroy => true)
      m.stub!(:find).and_return(m)
      User.should_receive(:find).with(m.id.to_s).and_return(m)
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
