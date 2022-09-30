1. Design and create the Table

Table: user_accounts

Table: user_accounts
id SERIAL PRIMARY KEY,
email_address text,
username text

Table: posts
id SERIAL PRIMARY KEY,
title text,
content text,
views int,
user_account_id int,

2. Create Test SQL seeds

-- user_accounts
-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here. 

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

INSERT INTO user_accounts (email_address, username) VALUES ('abc@gmail.com', 'abc123');
INSERT INTO user_accounts (email_address, username) VALUES ('xyz@gmail.com', 'xyz123');

psql -h 127.0.0.1 social_network < spec/seeds_user_accounts.sql

psql -h 127.0.0.1 social_network_test < spec/seeds_user_accounts.sql

-- posts
-- (file: spec/seeds_posts.sql)
-- Write your SQL seed here. 

TRUNCATE TABLE students RESTART IDENTITY; -- replace with your own table name.

INSERT INTO posts (title, content, views, user_account_id) VALUES ('birthday', 'meal', '1', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('anniversary', 'happy', '3', '1');
INSERT INTO posts (title, content, views, user_account_id) VALUES ('wedding', 'congrats', '2', '2');

psql -h 127.0.0.1 social_network < spec/seeds_posts.sql

psql -h 127.0.0.1 social_network_test < spec/seeds_posts.sql

3. Define the class names
Usually, the Model class name will be the capitalised table name (single instead of plural). The same name is then suffixed by Repository for the Repository class name.

class Post
end

class PostRepository
end

class UserAccount
end

class UserAccountRepository
end


4. Implement the Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

class Post
  attr_accessor :id, :title, :content, :views, :user_account_id
end


class UserAccount
    attr_accessor :id, :email_address, :username
end


5. Define the Repository Class interface


class PostRepository

  def all
    # Executes the SQL query:
    # 'SELECT id, title, content, views, user_account_id FROM posts;'

    # Returns an array of Post objects.
  end

  def find(id)
    # Executes the SQL query:
    # 'SELECT id, title, content, views, user_account_id FROM posts WHERE id = $1;'

    # Returns a single post object.
  end

  def create(post)
    #'INSERT INTO posts (title, content, views, user_account_id) VALUES($1, $2, $3, $4);'
    # Returns nothing/nil, creates a new post
  end

  def delete(id)
    #'DELETE FROM posts WHERE id = $1;'
    # Returns nothing/nil, deletes a post
  end

  def update(post)
    # 'Update posts SET title = $1, content = $2, views = $3, user_account_id $4 WHERE id $5;'
end


class UserAccountRepository

  def all
    # Executes the SQL query:
    # 'SELECT id, email_address, username FROM user_accounts;'

    # Returns an array of user_account objects.
  end

  def find(id)
    # Executes the SQL query:
    # 'SELECT id, email_address, username FROM user_accounts WHERE id = $1;'

    # Returns a single user_account object.
  end

  def create(post)
    #'INSERT INTO user_accounts (email_address, username) VALUES($1, $2);'
    # Returns nothing/nil, creates a new user_account object
  end

  def delete(id)
    #'DELETE FROM user_accounts WHERE id = $1;'
    # Returns nothing/nil, deletes a user_account
  end

  def update(post)
   # 'UPDATE posts SET email_address = $1, username = $2 WHERE id = $3;'
   # returns nothing/nil updates record
end


6. Write Test Examples

PostRepository

# 1
# Get all posts

repo = PostRepository.new
posts = repo.all
posts.length # => 3
posts.first.id # => 1
posts.first.title # => 'birthday'
posts.first.content # 'meal'
posts.first.views # => 1
posts.first.user_account_id # => 5

# 2
# Get a single student

repo = PostRepository.new
post = repo.find(1)
post.title # => 'birthday'
post.content # => 'meal'


# 3
# Add a new ...
repo = PostRepository.new
post = Post.new
post.title = 'funeral'
post.content = 'Bye...'
post.views = 0
post.user_account_id = 5

repo.create(post)

posts = repo.all
last_post = posts.last
last_post.title # => 'funeral'
last_post.content # => 'Bye...'


# 4
# Delete a ...
repo = PostRepository.new
repo.delete(1)

all_posts = repo.all
all_posts.length # => 2
all_posts.first.id # => 2

#5
# Update
repo = PostRepository.new

post = repo.find(1)
post.title = 'cakeday'
post.content = 'eat cake'
post.views = 11

updated_post = repo.find(1)

updated_post.title = 'cakeday' 
updated_post.content = 'eat cake'


UserAccountRepository

## 1
# Get all posts

repo = UserAccountRepository.new
user_acountss = repo.all

user_accounts.length # => 2
user_accounts.first.id # => 5
user_accounts.first.email_address # => 'abc@gmail.com'
user_accounts.first.username # => 'abc123'

# 2
# Get a single student   
# is find(1) the primary key or the first item in sql array?
repo = UserAccountRepository.new
user_account = repo.find(1)
user_account.email_address # => 'abc@gmail.com'
user_account.username # => 'abc123'


# 3
# Add a new ...
repo = UserAccountRepository.new
user_account  = UserAccount.new
user_account .email_address = 'hey!@gmail.com'
user_account .username = 'hey!123'

repo.create(user_account)

user_accounts = repo.all
last_user_account = user_accounts.last
last_user_account.email_address # => 'hey!@gmail.com'
last_user_account.username # => 'hey!123'


# 4
# Delete a user_account
# is find(1) the primary key or the first item in sql array?

repo = UserAccountRepository.new
repo.delete(1)
all_user_accounts = repo.all
all_user_accounts.length # => 1
all_user_accounts.first.id # => 6

#5
# Update
repo = UserAccountRepository.new

user_account = repo.find(1)
user_account.email_address = 'new123@gmail.com'
user_account.username = 'new123'

updated_user_account = repo.find(1)

updated_user_account.email_address = 'new123@gmail.com' 
updated_user_account.username = 'new123'


7. Reload the SQL seeds before each test run

def reset_posts_table
        seed_sql = File.read('spec/seeds_posts.sql')
        connection = PG.connect({ host: '127.0.0.1', dbname: 'social_network_test' })
        connection.exec(seed_sql)
    end
  
    before(:each) do
        reset_posts_table
    end




def reset_..._table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

end

8. Test-drive and implement the Repository class behaviour
After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour.

