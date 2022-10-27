# frozen_string_literal: true

require "rails_helper"

RSpec.describe Admin::BaseController do
  describe "#index" do
    context "when policy scope not called" do
      controller do
        def index
          render plain: ""
        end
      end

      it "raises a Pundit::PolicyScopingNotPerformedError" do
        expect { get(:index) }.to raise_error(Pundit::PolicyScopingNotPerformedError)
      end
    end

    context "when policy scope called" do
      controller do
        def index
          @records = policy_scope(User)
          render plain: ""
        end
      end

      it "raises no error Pundit::PolicyScopingNotPerformedError" do
        expect { get(:index) }.to_not raise_error
      end
    end
  end

  describe "non index actions" do
    context "when authorize not called" do
      controller do
        def new
          render plain: ""
        end
      end

      it "raises a Pundit::AuthorizationNotPerformedError" do
        expect { get(:new) }.to raise_error(Pundit::AuthorizationNotPerformedError)
      end
    end

    context "when authorize called" do
      controller do
        def new
          @user = authorize(User.new)
          render plain: ""
        end
      end

      it "raises no error Pundit::PolicyScopingNotPerformedError" do
        expect { get(:new) }.to_not raise_error
      end
    end
  end
end
