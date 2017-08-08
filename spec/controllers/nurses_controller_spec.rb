require 'rails_helper'

RSpec.describe NursesController do
  describe "#create" do
    it "creates a single nurse object" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(Nurse.count).to eq 1
    end

    it "creates a nurse object with a specific name" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(Nurse.last.first_name).to eq "John"
    end

    it "returns a 204 status response" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(response.status).to eq 204
    end

    context "when empty fields are submitted" do
      it "returns the related json error" do
        role = Role.create(name: "Test role")
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
        expect(response.body).to eq '{"errors":["Last name can\'t be blank"]}'
      end

      it "returns a 400 response status" do
        role = Role.create(name: "Test role")
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
        expect(response.status).to eq 400
      end

      it "does not create a nurse object" do
        role = Role.create(name: "Test role")
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
        expect(Nurse.count).to eq 0
      end
    end

    describe "#update" do
      it "updates a nurse object" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
        patch :update, params:{ id: nurse.id, nurse: {email:"test2@example.com"}}
        nurse.reload
        expect(nurse.email).to eq "test2@example.com"
      end

      it "does not update the 'sign in count' attribute" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
        patch :update, params:{ id: nurse.id, nurse: {sign_in_count: 2 }}
        nurse.reload
        expect(nurse.sign_in_count).to eq 0
      end

      it "does not update the 'verified' attribute" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
        patch :update, params:{ id: nurse.id, nurse: {verified: true}}
        nurse.reload
        expect(nurse.verified).to eq false
      end

      context "when empty fields are submitted" do
        it "returns the related json errors" do
          role = Role.create(name: "Test role")
          nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
          patch :update, params:{ id: nurse.id, nurse: {email:""}}
          expect(response.body).to eq '{"errors":["Email is invalid"]}'
        end

        it "returns a 400 response status" do
          role = Role.create(name: "Test role")
          nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
          patch :update, params:{ id: nurse.id, nurse: {email:""}}
          expect(response.status).to eq 400
        end

        it "does not update the attributes with invalid values" do
          role = Role.create(name: "Test role")
          nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
          patch :update, params:{ id: nurse.id, nurse: {first_name: "Bill", email: ""}}
          expect(nurse.email).to eq "test@example.com"
        end
      end

      context "when a nurse object id is invalid" do
        it "returns a 404 response status" do
          delete :update, params:{ id: 10, nurse: {first_name: "Bill" }}
          expect(response.status).to eq 404
        end
      end
    end

    describe "#delete" do
      it "deletes a nurse object" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
        delete :destroy, params:{ id: nurse.id }
        expect(Nurse.count).to eq 0
      end

      context "when a nurse object id is invalid" do
        it "returns a 404 response status" do
          delete :destroy, params:{ id: 10 }
          expect(response.status).to eq 404
        end
      end
    end

    describe "#show" do
      it "displays a single nurse object" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
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
      it "displays all nurse objects" do
        role = Role.create(name: "Test role")
        nurse = Nurse.create(email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id)
        nurse_2 = Nurse.create(email: "test3@example.com", first_name: "Mary", last_name: "Brown", phone_number: "074-0001-0001", verified: false, sign_in_count: 0, role_id: role.id)
        get :index
        nurse_obj = JSON.parse(response.body)
        expect(nurse_obj[0]["id"]).to eq 1
      end
    end
  end
end
