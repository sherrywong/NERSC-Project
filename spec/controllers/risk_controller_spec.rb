require 'spec_helper'

describe RiskController do
  describe 'new' do
    it 'should be able to create a new risk' do
      r = mock('risk')
      Risk.should_receive(:new!).and_return(r)
      r.should_receive(:save)
      post :new, {:risk => r}
      response.should redirect_to('/user/risk/index')
    end
  end
  
  
  describe 'edit' do
    it 'should be able to edit a risk' do
      r = stub_model(Risk)
      Risk.stub!(:find).and_return(r)
      get :edit, :id => r.id
      response.should be_success
    end
  end
  
  
  describe 'update' do
    it 'should be able to update a risk field' do
      r = stub_model(Risk)
      r.stub!(:update_attributes).and_return(true)
      Risk.should_receive(:find).with('1').and_return(r)																																																																																																																																																																																																																																															
      put :update, :id => r.id, :risk => {}
      response.should redirect_to('/risks/1')
    end
  end
  
  
  describe 'destroy' do
    it 'should be able to destroy a risk' do
      r = stub_model(Risk, :destroy => true)
      r.stub!(:find).and_return(r)
      Risk.should_receive(:find).with(r.id.to_s).and_return(r)
 #     r.should_receive(:destory)
      post :destroy, :id => r.id.to_s
      #response.should redirect_to(movies_path)
    end
  end

  
  describe 'index' do
    before do
    end
  end
end
