CREATE TABLE account (
  id SERIAL,  -- Auto-incrementing primary key for the account table.
  email VARCHAR(128) UNIQUE,  -- Unique email for each account.
  created_at DATE NOT NULL DEFAULT NOW(),  -- Creation timestamp with a default of the current date.
  updated_at DATE NOT NULL DEFAULT NOW(),  -- Timestamp for last update, defaults to current date.
  PRIMARY KEY(id)  -- Setting id as the primary key.
);

CREATE TABLE post (
  id SERIAL,  -- Auto-incrementing primary key for the post table.
  title VARCHAR(128) UNIQUE NOT NULL,  -- Unique, non-nullable title for each post.
  content VARCHAR(1024),  -- Content of the post, with a 1024 character limit.
  account_id INTEGER REFERENCES account(id) ON DELETE CASCADE,  -- Foreign key to account, cascade on delete.
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp of post creation with timezone, defaults to current time.
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp for last update, defaults to current time.
  PRIMARY KEY(id)  -- Setting id as the primary key.
);

CREATE TABLE comment (
  id SERIAL,  -- Auto-incrementing primary key for the comment table.
  content TEXT NOT NULL,  -- Content of the comment, must not be null.
  account_id INTEGER REFERENCES account(id) ON DELETE CASCADE,  -- Foreign key to account, cascade on delete.
  post_id INTEGER REFERENCES post(id) ON DELETE CASCADE,  -- Foreign key to post, cascade on delete.
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp of comment creation with timezone, defaults to current time.
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp for last update, defaults to current time.
  PRIMARY KEY(id)  -- Setting id as the primary key.
);

CREATE TABLE fav (
  id SERIAL,  -- Auto-incrementing primary key for the fav table.
  oops TEXT,  -- Placeholder column to be removed later.
  post_id INTEGER REFERENCES post(id) ON DELETE CASCADE,  -- Foreign key to post, cascade on delete.
  account_id INTEGER REFERENCES account(id) ON DELETE CASCADE,  -- Foreign key to account, cascade on delete.
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp of favoriting action, defaults to current time.
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),  -- Timestamp for last update, defaults to current time.
  UNIQUE(post_id, account_id),  -- Each account can favorite a post only once.
  PRIMARY KEY(id)  -- Setting id as the primary key.
);

ALTER TABLE post 
ALTER COLUMN content TYPE TEXT;  -- Change the type of the content column from VARCHAR(1024) to TEXT for longer content.

ALTER TABLE fav 
DROP COLUMN oops;  -- Remove the placeholder column 'oops' from the fav table.

ALTER TABLE fav 
ADD COLUMN howmuch INTEGER;  -- Add a new column 'howmuch' of type INTEGER to the fav table.