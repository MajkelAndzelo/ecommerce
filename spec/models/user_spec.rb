require 'rails_helper'


RSpec.describe User, type: :model do
    describe "validations" do
        it "requires an email address" do
            user = User.new(password: "password", nickname: "Nick", first_name: "Nicolas", last_name: "Cage")
            expect(user).not_to be_valid
        end
        it "requires a valid email address" do
            user = User.new(email: "invalid-email", password: "password", nickname: "Nick", first_name: "Nicolas", last_name: "Cage")
            expect(user).not_to be_valid
        end
        it "requires a password" do
            user = User.new(email: "test@test.com", nickname: "Nick", first_name: "Nicolas", last_name: "Cage")
            expect(user).not_to be_valid
        end
        it "requires a nickname" do
            user = User.new(email: "test@test.com", password: "password", first_name: "Nicolas", last_name: "Cage")
            expect(user).not_to be_valid
        end
        it "requiers a first name" do
            user = User.new(email: "test@test.com", password: "password", nickname: "Nick", last_name: "Cage")
            expect(user).not_to be_valid
        end
        it "requiers a last name" do
            user = User.new(email: "test@test.com", password: "password", nickname: "Nick", first_name: "Nicolas")
            expect(user).not_to be_valid
        end
    end
end