/************************************************************************************************
Title:			SQL Queries Part2
Created by: Santosh Mungle  <santoshmungle@gmail.com>
License:		CC BY 3.0

Usage:
These queries meant to give you an understanding of sql queries for analyzing data in database.

Part 2 Description: 
After creating their first trade with MarketInvoice, clients are asked to rate the experience on a scale 1-10. 
Clients fall into following three categories based on their score:
9-10: Promoter
7-8: Neutral
0-6: Detractor

A net promoter score is computed by subtracting the percentage of clients who are detractors 
from the percentage of clients who are promoters.

Given the following table:
table: net_promoter_scores
columns: response_id (pk), client_email, score, response_datetime
************************************************************************************************/

Query 1. Write a sql query to compute the net promoter score for each of the last six months. 
Solution:
/* Trades is my database where I have tables including clients, trades, salesreps, comments, net_promoter_scores*/
USE Trades 
GO
SELECT (SELECT (SELECT COUNT(score) FROM net_promoter_scores
WHERE score BETWEEN 9 AND 10 AND response_datetime > dateadd(mm,-6,getdate())) * 100 / 
(SELECT COUNT(score) FROM net_promoter_scores WHERE response_datetime > dateadd(mm,-6,getdate())))
- (SELECT (SELECT COUNT(score) FROM net_promoter_scores
WHERE score BETWEEN 0 AND 6 AND response_datetime > dateadd(mm,-6,getdate())) * 100 / 
(SELECT COUNT(score) FROM net_promoter_scores WHERE response_datetime > dateadd(mm,-6,getdate()))) 
AS net_promoter_score


Query 2. Looking at the data, you notice that several clients have responded to the survey more than once, 
in different months, with different scores. In order not to bias the analysis, only one score per company 
should be counted. Decide on a way to achieve this, and adjust the query you wrote in answer to 
Query 1 to achieve this. Justify your decision.
Solution:
I would suggest calculating the average for a client with multiple responses over time period. 
It’s because different score over time suggest his/her sentiment/satisfaction for trades with MarketInVoice. 
For example, a client had positive experience about his first trade, so he rated highly but rated poorly 
for his last trade with MarketInVoice. Therefore, average would represent all his trade experiences. 
On the other hand, considering only one last/first score would not include his experience over time. 

/* Trades is my database where I have tables including clients, trades, salesreps, comments, net_promoter_scores*/
USE Trades
GO
SELECT (SELECT SUM(AA.NoOfResponse) FROM (SELECT client_email, COUNT(score) AS NoOfResponse, AVG(score) AS Avg_Score 
FROM net_promoter_scores
GROUP BY client_email, response_datetime
HAVING AVG(score) BETWEEN 9 AND 10 AND response_datetime > dateadd(mm,-6,getdate())) AA)
* 100/
(SELECT SUM(AA.NoOfResponse) FROM (SELECT client_email, COUNT(score) AS NoOfResponse, AVG(score) AS Avg_Score 
FROM net_promoter_scores
GROUP BY client_email, response_datetime
HAVING response_datetime > dateadd(mm,-6,getdate())) AA)
-
(SELECT SUM(AA.NoOfResponse) FROM (SELECT client_email, COUNT(score) AS NoOfResponse, AVG(score) AS Avg_Score 
FROM net_promoter_scores
GROUP BY client_email, response_datetime
HAVING AVG(score) BETWEEN 0 AND 6 AND response_datetime > dateadd(mm,-6,getdate())) AA)
* 100/
(SELECT SUM(AA.NoOfResponse) FROM (SELECT client_email, COUNT(score) AS NoOfResponse, AVG(score) AS Avg_Score 
FROM net_promoter_scores
GROUP BY client_email, response_datetime
HAVING response_datetime > dateadd(mm,-6,getdate())) AA) AS net_promoter_score

