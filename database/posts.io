// Replication:
// master - slave per 1 DS
// RF = 3 (sync + async)
//
// Sharding:
// key based by user_id
// places table should be stored separately

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


Ref: posts.user_id > users.id
Ref: posts.place_id > places.id
