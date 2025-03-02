Table users {
  id integer [primary key]
  username varchar
  password_hash text
  created_at timestamp
}

Table posts {
  id integer [primary key]
  user_id integer
  place_id integer
  description text
  status varchar
  media_url varchar
  created_at timestamp
}

Table places {
  id integer [primary key]
  name varchar
  coordinates geography(point)
  address varchar
  created_at timestamp
}

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

Table subscriptions {
  follower_id integer
  followed_id integer
  created_at timestamp

  Indexes {
    (follower_id, followed_id) [pk]
  }
}


Ref: posts.user_id > users.id
Ref: posts.place_id > places.id

Ref: comments.parent_id > comments.id
Ref: comments.post_id > posts.id
Ref: comments.user_id > users.id

Ref: ratings.post_id > posts.id
Ref: ratings.user_id > users.id

Ref: subscriptions.follower_id > users.id
Ref: subscriptions.followed_id > users.id
