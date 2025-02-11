# System design for social network

Homework for the [System Design course](https://google.com)


## Requirements

--- 

### Functional requirements
- Posts publishing (posts include text, img, geo)
- Get posts
- Follow/Unfollow travelers
- Interact with others (ratings/comments on posts)
- Discover popular spots and view related posts
- View feeds (personal & followed) in reverse chronological order
---


### Non-functional requirements
- DAU = 10kk (linear growth)
- Audience (Regional Focus): CIS (Commonwealth of Independent States)
- Always store data (no data is ever purged)
- 99.95% availability
- Geo distribution is not needed
- Limits:
  - Max number of followers: 1kk
- Typical Activities (per user):
  - 1 post per week
  - 3 comments per week
  - 5 ratings per day
  - view feeds 3 times per day (each feed request loads ~15 posts)
  - 1 time per week view popular spots
- Performance (Timing):
  - Create a post: ≤ 1s
  - Comment on a post: ≤ 1s
  - Search posts by geo: ≤ 2s
  - Load the feed: ≤ 2s
- Seasonality. Usage spikes expected during peak travel/holiday seasons (e.g., summer vacations, winter holidays), with a possible **30-40% increase** in daily activity (posts, comments, feed views). The system must handle these peaks while maintaining performance and availability targets

--- 


## Calculation

### Posts

```
RPC(write) = 10kk * 1 post per week / 7 / 86400 ~= 17
RPC(read) = 10kk * 3 time per day view feeds(15 posts) / 86400 ~= 350
```

### Comments

```
RPC(write) = 10kk * 3 comments per week / 7 / 86400 ~= 50
```

### Ratings

```
RPC(write) = 10kk * 5 ratings per day / 86400 ~= 600
```

### Spots

```
RPC(read) = 10kk * 1 time per week view popular spots / 7 / 86400 ~= 20
```


## Models
#### Post:
- id (8 bytes)
- author_id (8 bytes)
- text (up to 500 bytes)
- img (up to 1MB) -> s3 storage
- geo ~PostGIS (up to 100 bytes)
- created_at (8 bytes)

**Total**: 8B + 8B + 500B + 1MB + 100B + 8B ~= 1MB

---
#### Comment:
- id (8 bytes)
- post_id (8 bytes)
- author_id (8 bytes)
- text (up to 250 bytes)
- created_at (8 bytes)

**Total**: 8B + 8B + 8B + 250B + 8B ~= 300B

---

#### Rating:
- id (8 bytes)
- post_id (8 bytes)
- author_id (8 bytes)
- value INT8 (1 byte)
- created_at (8 bytes)

**Total** 8B + 8B + 8B + 1B + 8B ~= 33B

--- 

## Traffic

### Posts

```
Traffic (write) = 17 * 1MB = 17MB/s
Traffic (read) = 350 * 15 * 1MB = 5.25GB/s
```

### Comments

```
Traffic (write) = 50 * 300B = 15KB/s
```

### Ratings

```
Traffic (write) = 600 * 33B = 20KB/s
```

**For the peak load, we need to add 40% to the calculated values.**