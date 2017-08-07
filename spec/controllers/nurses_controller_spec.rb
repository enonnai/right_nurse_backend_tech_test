require 'rails_helper'

RSpec.describe NursesController do
  describe "#create" do
    it "creates a single nurse object" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(Nurse.count).to eq 1
    end

    it "creates a nurse with a specific name" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(Nurse.last.first_name).to eq "John"
    end

    it "returns a 204 status response" do
      role = Role.create(name: "Test role")
      post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: "Doe", phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
      expect(response.status).to eq 204
    end

    context "when there are empty fields" do
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

      it "does not create a nurse" do
        role = Role.create(name: "Test role")
        post :create, params:{ nurse: {email: "test@example.com", first_name: "John", last_name: nil, phone_number: "074-0000-0000", verified: false, sign_in_count: 0, role_id: role.id}}
        expect(Nurse.count).to eq 0
      end
    end

  end
end
