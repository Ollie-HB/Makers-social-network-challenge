-- user_accounts
-- (file: spec/seeds_user_accounts.sql)

-- Write your SQL seed here. 

TRUNCATE TABLE user_accounts RESTART IDENTITY; -- replace with your own table name.

INSERT INTO user_accounts (email_address, username) VALUES ('abc@gmail.com', 'abc123');
INSERT INTO user_accounts (email_address, username) VALUES ('xyz@gmail.com', 'xyz123');
