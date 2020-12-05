use mavenfuzzyfactory;

SELECT * FROM website_pageviews;
SELECT * FROM website_sessions;
SELECT * FROM orders;

CREATE TEMPORARY TABLE first_pageviews;
SELECT MIN(website_pageview_id) as min_pageview_id, website_session_id 
FROM website_pageviews 
WHERE created_at < '2012-06-14' 
GROUP BY 2;

CREATE TEMPORARY TABLE sessions_home_landingpage;
SELECT fp.website_session_id , wp.pageview_url as landing_page
FROM first_pageviews fp
LEFT JOIN website_pageviews  wp
ON fp.min_pageview_id = wp.website_pageview_id
WHERE  wp.pageview_url = '/home';

CREATE TEMPORARY TABLE bounced_sessions;
SELECT sh.website_session_id , sh.landing_page, COUNT(wp.website_pageview_id) as count_pages_viewed
FROM sessions_home_landingpage sh
LEFT  JOIN website_pageviews  wp
ON sh.website_session_id = wp.website_session_id
GROUP BY 1,2
HAVING count_pages_viewed= 1;


SELECT COUNT( DISTINCT shl.website_session_id) as sessions , COUNT( DISTINCT  bs.website_session_id )as bounced,
COUNT( DISTINCT  bs.website_session_id )/ COUNT( DISTINCT shl.website_session_id) as bounced_rate
FROM sessions_home_landingpage shl
LEFT JOIN  bounced_sessions bs
ON shl.website_session_id = bs.website_session_id
ORDER BY shl.website_session_id
;











