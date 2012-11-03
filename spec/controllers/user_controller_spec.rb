require 'spec_helper'

describe UserController do
  describe 'new' do
    it 'should be able to create a new user' do
      controller.stub!(:validate_login).and_return(true)
      # login (:admin)
      u = mock('user')
      User.should_receive(:new).and_return(u)
      u.should_receive(:save)
      post :new, {:user => u}
      # Need to log in first
      response.should redirect_to('/user/index')
    end
  end


  describe 'edit' do
    it 'should be able to edit a user' do
      u = stub_model(User)
      User.stub!(:find).and_return(u)
      get :edit, :id => u.id
      response.should be_success
    end
  end


  describe 'update' do
    it 'should be able to update a user field' do
      u = stub_model(User)
      u.stub!(:update_attributes).and_return(true)
      User.should_receive(:find).with('1').and_return(u)
      put :update, :id => u.id, :user => {}
      response.should redirect_to('/users/1')
    end
  end


  describe 'destroy' do
    it 'should be able to destroy a user' do
      u = stub_model(User, :destroy => true)
      u.stub!(:find).and_return(u)
      User.should_receive(:find).with(u.id.to_s).and_return(u)
 #     u.should_receive(:destory)
      post :destroy, :id => u.id.to_s
      #response.should redirect_to(movies_path)
    end
  end


  describe 'index' do
    before do
    end
  end
end
