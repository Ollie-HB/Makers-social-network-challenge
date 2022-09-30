1. Extract nouns from the user stories or specification

As a social network user,
So I can have my information registered,
I'd like to have a user account with my email address.

As a social network user,
So I can have my information registered,
I'd like to have a user account with my username.

As a social network user,
So I can write on my timeline,
I'd like to create posts associated with my user account.

As a social network user,
So I can write on my timeline,
I'd like each of my posts to have a title and a content.

As a social network user,
So I can know who reads my posts,
I'd like each of my posts to have a number of views.

Nouns: User account  email address, user name,
      posts user account, title, content, No of views 


2. Infer the Table Name and Columns

Record	      Properties
user_account	email_address, username
post	        title, content, views 

3. Decide the column types.

Table: user_accounts
id: SERIAL
email_address: text
username: text

Table: posts
id: SERIAL
title: text
content: text
views: int

4. Decide on The Tables Relationship

1. Can one user have many posts? YES
2. Can one post have many users? NO

-> Therefore, the foreign key is on the posts.

4. Write the SQL.

-- file: social_network_table.sql

CREATE TABLE user_accounts (
  id SERIAL PRIMARY KEY,
  email_address text,
  username text,
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  title text,
  content text,
  views int,
  user_account_id int,
  constraint fk_user_account foreign key(user_account_id)
    references user_accounts(id)
    on delete cascade
);

5. Create the tables.

psql -h 127.0.0.1 social_network < spec/social_network_table.sql

psql -h 127.0.0.1 social_network_test < spec/social_network_table.sql