// Replication:
// master - slave per 1 DS
// RF = 3 (sync + async)
//
// Sharding:
// not needed


Table comments {
  id integer [primary key]
  post_id integer
  user_id integer
  parent_id integer
  text varchar
  created_at timestamp
}

Table ratings {
  post_id integer
  user_id integer
  value int8
  created_at timestamp

  Indexes {
    (post_id, user_id) [pk]
  }
}

Ref: comments.parent_id > comments.id
Ref: comments.post_id > posts.id
Ref: comments.user_id > users.id

Ref: ratings.post_id > posts.id
Ref: ratings.user_id > users.id
