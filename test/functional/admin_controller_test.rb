require 'test_helper'

class AdminControllerTest < ActionController::TestCase

  context 'Admin namespace' do
    context 'as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: true
        sign_in @mailbox
      end

      context 'on GET to test' do
        setup do
          get :test
        end

        should respond_with :success
        should 'grant access' do
          assert_select 'h1', 'ok'
        end
      end
    end

    context 'not as admin' do
      setup do
        @mailbox = FactoryGirl.create :mailbox, admin: false
        sign_in @mailbox
      end

      context 'on GET to test' do
        should 'deny access' do
          assert_raise CanCan::AccessDenied do
            get :test
          end
        end
      end
    end

    context 'without session' do
      context 'on GET to test' do
        should 'deny access' do
          assert_raise CanCan::AccessDenied do
            get :test
          end
        end
      end
    end
  end

end