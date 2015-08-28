require File.dirname(__FILE__) + '/../lib/user.rb'

describe "User" do

    subject(:user) {User.new("Juntao", "Qiu")}

    it "converts Western name to Chinese name" do
        expect(user.name).to eq "QIU Juntao"
    end

    it "says hi when greeting" do
        expect(user.greeting).to eq "Hello, My name is QIU Juntao"
    end
end
