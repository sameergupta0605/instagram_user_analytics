select * from ig_clone.comments;
select * from ig_clone.follows;
select * from ig_clone.likes;
select * from ig_clone.photo_tags;
select * from ig_clone.photos;
select * from ig_clone.tags;
select * from ig_clone.users;

-- ------------------------------------------------------------------------------------------------------------------------ --

-- Marketing metrics

-- query1
-- Find the 5 oldest users of the Instagram from the database provided

select * 
from ig_clone.users 
order by created_at limit 5;

-- query 2
-- Find the users who have never posted a single photo on Instagram

select * 
from ig_clone.users 
where id not in 
(select user_id from ig_clone.photos);

-- query 3
-- Identify the winner of the contest and provide their details to the team (most likes on a single photo)


select t1.photo_id, count(t1.user_id) as likes, t3.* 
from ig_clone.likes t1
join ig_clone.photos t2 on t1.photo_id=t2.id
join ig_clone.users t3 on t2.user_id=t3.id
group by t1.photo_id
order by likes desc
limit 1;

-- query 4
-- Identify and suggest the top 5 most commonly used hashtags on the platform

select t2.*, count(t1.photo_id) 
from ig_clone.photo_tags t1
join ig_clone.tags t2 on t1.tag_id=t2.id
group by t2.id
order by count(photo_id) desc
limit 5;

-- query 5
-- What day of the week do most users register on? Provide insights on when to schedule an ad campaign

select dayname(created_at) as day, count(id) as reg_count
from ig_clone.users
group by 1
order by count(id) desc;


-- Investor Metrics

-- query 1
-- Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).

select * from ig_clone.users 
where id in (
select user_id
from ig_clone.likes 
group by user_id 
having count(photo_id)=(select distinct count(id) from ig_clone.photos));

