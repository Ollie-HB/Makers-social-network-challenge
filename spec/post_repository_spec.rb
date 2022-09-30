require 'post_repository'

RSpec.describe PostRepository do

    def reset_posts_table
        seed_sql = File.read('spec/seeds_social_network.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
  
    before(:each) do
        reset_posts_table
    end

    it 'Returns full lists of posts' do
        repo = PostRepository.new
        posts = repo.all

        expect(posts.length).to eq 3 
        expect(posts.first.id).to eq '1'
        expect(posts.first.title).to eq 'birthday'
        expect(posts.first.content).to eq 'meal'
        expect(posts.first.views).to eq '1'
        expect(posts.first.user_account_id).to eq '1'
    end

    it 'Return single post' do
        repo = PostRepository.new
        post = repo.find(1)
        
        expect(post.title).to eq 'birthday'
        expect(post.content).to eq 'meal'
    end

    it 'It creates a new record' do
        repo = PostRepository.new
        post = Post.new
        post.title = 'funeral'
        post.content = 'Bye...'
        post.views = '0'
        post.user_account_id = '1'

        repo.create(post)

        posts = repo.all
        last_post = posts.last
        expect(last_post.title).to eq 'funeral'
        expect(last_post.content).to eq 'Bye...'
    end

    it 'It deletes a record' do
        repo = PostRepository.new
        repo.delete(1)

        all_posts = repo.all
        expect(all_posts.length).to eq 2
        expect(all_posts.first.id).to eq '2'
    end

    it 'updates a record' do
        repo = PostRepository.new

        post = repo.find(1)

        post.title = 'cakeday'
        post.content = 'eat cake'
        post.views = '11'

        repo.update(post)

        updated_post = repo.find(1)

        expect(updated_post.title).to eq 'cakeday' 
        expect(updated_post.content).to eq 'eat cake'
    end

end