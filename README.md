# SparkFoundationInternship
Internship-Task2-LinearRegression


We've been live for almost a month now and we’re starting to generate sales. Can you help me understand where the bulk of our website sessions are coming from, through yesterday? I’d like to see a breakdown by UTM source, campaignand referring domain if possible. 

SQL CODE: 

use mavenfuzzyfactory;
SET global time_zone = '-5:00';

select utm_source, utm_campaign, http_referer, COUNT( DISTINCT website_session_id) AS sessions
 from website_sessions
 where created_at < '2012-04-12'
 group by utm_source, utm_campaign, http_referer
 ORDER BY sessions DESC;

