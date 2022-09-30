require 'user_account_repository'

RSpec.describe UserAccountRepository do

    def reset_user_account_table
        seed_sql = File.read('spec/seeds_social_network.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
  
    before(:each) do
        reset_user_account_table
    end


    it 'Returns a list of user accounts' do

        repo = UserAccountRepository.new
        user_accounts = repo.all

        expect(user_accounts.length).to eq 2
        expect(user_accounts.first.id).to eq '1'
        expect(user_accounts.first.email_address).to eq 'abc@gmail.com'
        expect(user_accounts.first.username).to eq 'abc123'
    end


    it "returns a single user account" do
        repo = UserAccountRepository.new
        user_account = repo.find(1)
        
        expect(user_account.email_address).to eq 'abc@gmail.com'
        expect(user_account.username).to eq 'abc123'
    end


    it 'adds a new user account' do
        repo = UserAccountRepository.new
        user_account  = UserAccount.new
        user_account.email_address = 'hey!@gmail.com'
        user_account.username = 'hey!123'

        repo.create(user_account)

        user_accounts = repo.all
        last_user_account = user_accounts.last
        expect(last_user_account.email_address).to eq 'hey!@gmail.com'
        expect(last_user_account.username).to eq 'hey!123'
    end


    it "deletes a record" do

        repo = UserAccountRepository.new
        repo.delete(1)
        all_user_accounts = repo.all

        expect(all_user_accounts.length).to eq 1
        expect(all_user_accounts.first.id).to eq '2'
    end

    
    it 'updates a record' do 
        repo = UserAccountRepository.new

        user_account = repo.find(1)
        user_account.email_address = 'new123@gmail.com'
        user_account.username = 'new123'
        
        repo.update(user_account)
        updated_user_account = repo.find(1)

        expect(updated_user_account.email_address).to eq 'new123@gmail.com' 
        expect(updated_user_account.username).to eq 'new123'
    end
end