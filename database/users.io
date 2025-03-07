Table users {
  id integer [primary key]
  username varchar
  password_hash text
  created_at timestamp
}

Table subscriptions {
  follower_id integer
  followed_id integer
  created_at timestamp

  Indexes {
    (follower_id, followed_id) [pk]
  }
}

Ref: subscriptions.follower_id > users.id
Ref: subscriptions.followed_id > users.id