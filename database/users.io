// Replication:
// master - slave per 1 DS
// RF = 3 (sync + async)
//
// Sharding:
// key based by id
// for subscriptions table we use column follower_id as an id for sharding

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
