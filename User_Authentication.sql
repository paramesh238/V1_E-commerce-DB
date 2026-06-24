-- 1. View User Login Details
SELECT
    u.user_id,
    u.name,
    u.email,
    ul.username,
    ul.last_login
FROM users u
JOIN user_login ul
    ON u.user_id = ul.user_id;

-- 2. Find Users Who Never Logged In
SELECT
    u.user_id,
    u.name
FROM users u
LEFT JOIN user_login ul
    ON u.user_id = ul.user_id
WHERE ul.last_login IS NULL;

-- 3. Last Logged-In Users
SELECT
    username,
    last_login
FROM user_login
ORDER BY last_login DESC;

-- 4. Login Activity Ranking Using a window function:
SELECT
    username,
    last_login,

    ROW_NUMBER() OVER
    (
        ORDER BY last_login DESC
    ) AS login_rank

FROM user_login;