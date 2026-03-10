-- 1. List all movies and the number of ratings
SELECT
    m.movieId,
    m.title,
    COUNT(r.rating) AS rating_count
FROM movies m
JOIN ratings r
ON m.movieId = r.movieId
GROUP BY m.movieId, m.title;


-- 2. List all users and the number of ratings they have done
SELECT
    userId,
    COUNT(rating) AS total_ratings
FROM ratings
GROUP BY userId;


-- 3. List all movie IDs that have been rated
SELECT DISTINCT movieId
FROM ratings;


-- 4. List all users who have rated at least one movie
SELECT DISTINCT userId
FROM ratings;


-- 5. List all users with max, min and average rating
SELECT
    userId,
    MAX(rating) AS max_rating,
    MIN(rating) AS min_rating,
    AVG(rating) AS avg_rating
FROM ratings
GROUP BY userId;


-- 6. List all movies with max, min and average rating
SELECT
    movieId,
    MAX(rating) AS max_rating,
    MIN(rating) AS min_rating,
    AVG(rating) AS avg_rating
FROM ratings
GROUP BY movieId;
