require 'rails_helper'

def create_nurse(email = "test@example.com")
  Nurse.create(email: email, first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id)
end

RSpec.describe NursesController do
  before do
    @role = Role.create
  end

  describe "#create" do
    it "creates a single nurse object" do
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
      expect(Nurse.count).to eq 1
    end

    it "creates a nurse object with a specific name" do
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
      expect(Nurse.last.first_name).to eq "John"
    end

    it "returns a 204 status response" do
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
      expect(response.status).to eq 204
    end

    context "when empty fields are submitted" do
      it "returns the related json error" do
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
        expect(response.body).to eq '{"errors":["Last name can\'t be blank"]}'
      end

      it "returns a 400 response status" do
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
        expect(response.status).to eq 400
      end

      it "does not create a nurse object" do
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: @role.id}}
        expect(Nurse.count).to eq 0
      end
    end

    describe "#update" do
      it "updates a nurse object" do
        nurse = create_nurse
        patch :update, params:{ id: nurse.id, nurse: {email:"test2@example.com"}}
        nurse.reload
        expect(nurse.email).to eq "test2@example.com"
      end

      it "does not update the 'sign in count' attribute" do
        nurse = create_nurse
        patch :update, params:{ id: nurse.id, nurse: {sign_in_count: 2 }}
        nurse.reload
        expect(nurse.sign_in_count).to eq 0
      end

      it "does not update the 'verified' attribute" do
        nurse = create_nurse
        patch :update, params:{ id: nurse.id, nurse: {verified: true}}
        nurse.reload
        expect(nurse.verified).to eq false
      end

      context "when empty fields are submitted" do
        it "returns the related json errors" do
          nurse = create_nurse
          patch :update, params:{ id: nurse.id, nurse: {email:""}}
          expect(response.body).to eq '{"errors":["Email is invalid"]}'
        end

        it "returns a 400 response status" do
          nurse = create_nurse
          patch :update, params:{ id: nurse.id, nurse: {email:""}}
          expect(response.status).to eq 400
        end

        it "does not update the attributes with invalid values" do
          nurse = create_nurse
          patch :update, params:{ id: nurse.id, nurse: {first_name: "Bill", email: ""}}
          expect(nurse.email).to eq "test@example.com"
        end
      end

      context "when a nurse object is not found" do
        it "returns a 404 response status" do
          delete :update, params:{ id: 10, nurse: {first_name: "Bill" }}
          expect(response.status).to eq 404
        end
      end
    end

    describe "#delete" do
      it "deletes a nurse object" do
        nurse = create_nurse
        delete :destroy, params:{ id: nurse.id }
        expect(Nurse.count).to eq 0
      end

      context "when a nurse object is not found" do
        it "returns a 404 response status" do
          delete :destroy, params:{ id: 10 }
          expect(response.status).to eq 404
        end
      end
    end

    describe "#show" do
      it "displays a single nurse object" do
        nurse = create_nurse
        get :show, params:{ id: nurse.id }
        nurse_obj = JSON.parse(response.body)
        expect(nurse_obj["id"]).to eq 1
      end

      context "when a single nurse object id does not exist" do
        it "returns a 404 response status" do
          get :show, params:{ id: 10 }
          expect(response.status).to eq 404
        end
      end
    end

    describe "#index" do
      it "returns all the nurse objects" do
        nurse = create_nurse
        nurse2 = create_nurse("test3@example.com")
        get :index
        nurse_obj = JSON.parse(response.body)
        expect(nurse_obj.length).to eq 2
        expect(nurse_obj[0]["email"]).to eq "test@example.com"
        expect(nurse_obj[1]["email"]).to eq "test3@example.com"
      end
    end
  end
end
