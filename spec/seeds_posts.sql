TRUNCATE TABLE posts RESTART IDENTITY; -- replace with your own table name.


INSERT INTO posts (title, content, views, user_account_id) VALUES ('birthday', 'meal', 1, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('anniversary', 'happy', 3, 1);
INSERT INTO posts (title, content, views, user_account_id) VALUES ('wedding', 'congrats', 2, 2);

