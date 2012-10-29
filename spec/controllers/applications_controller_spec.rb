require 'spec_helper'

describe ApplicationController do
  describe 'login_required' do
    it 'should redirect' do
      response.should redirect_to('/user/index')
    end
  end
  
  
  describe 'project_id_matches_user' do
    it 'should redirect' do
      response.should redirect_to('/usr/index')
    end
  end
  
  
  describe 'is_admin' do
    it 'should redirect' do
      #response.should redirect_to('/usr/index')
    end
  end
end