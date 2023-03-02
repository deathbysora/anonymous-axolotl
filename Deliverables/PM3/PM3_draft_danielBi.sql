USE BeerApplication;

# 1 What are the top 10 most reviewed beer from the reviews
SELECT BeerName, COUNT(*) AS Review_Counts
FROM BeerReviews INNER JOIN Beers
  ON BeerReviews.BeerId = Beers.BeerId
GROUP BY Beers.BeerId, BeerName
ORDER BY Review_Counts DESC
LIMIT 10;

# 2 What are the top 10 most viewed beers by users (will be populated as user using it)
SELECT BeerName, COUNT(*) AS View_Counts
# need to populate this table
FROM ViewHistory INNER JOIN Beers
  ON ViewHistory.BeerId = Beers.BeerId
GROUP BY Beers.BeerId, BeerName
ORDER BY View_Counts DESC
LIMIT 10;

#3 What are the top 10 users that reviewed the most amount of beers (like a leader board)
SELECT Username, COUNT(*) AS UserName_Counts
FROM BeerReviews
GROUP BY UserName
ORDER BY UserName_Counts DESC
LIMIT 10;

#4 What are the most 10 popular reviews that has the most comments
SELECT ReviewId, COUNT(*) AS Review_Engagement
FROM BeerComments
GROUP BY ReviewId
ORDER BY Review_Engagement DESC
LIMIT 10;


#5 For a certain type of beerstyle, what are some recommended food that goes with it
SELECT FoodName 
from Food
WHERE Style = 'Ale'; # we can do an enum callout?


#6 Top 10 most active users in 2023 (cross review comments and user engagements/view history)
# Elsa working on it rn


#7 What are the top 5 most reviewed beers in the summer season (May-Sept)
SELECT BeerName, COUNT(*) AS Review_Counts
FROM BeerReviews INNER JOIN Beers
  ON BeerReviews.BeerId = Beers.BeerId
WHERE (MONTH(Created) <= 9 and MONTH(Created) >= 5)
GROUP BY Beers.BeerId, BeerName
ORDER BY Review_Counts DESC
LIMIT 5;

#8 What are the top 5 most VIEWED beers in the winter season (Oct-Dec)
SELECT BeerName, COUNT(*) AS View_Counts
# need to populate this table
FROM ViewHistory INNER JOIN Beers
  ON ViewHistory.BeerId = Beers.BeerId
WHERE (MONTH(Created) <= 12 and MONTH(Created) >= 10)
GROUP BY Beers.BeerId, BeerName
ORDER BY View_Counts DESC
LIMIT 5;

#9 Which users have never created a review or viewed any beers.
SELECT Users.UserName
FROM Users
  LEFT OUTER JOIN
    BeerReview
  ON BeerReview.UserName = Users.UserName
  LEFT OUTER JOIN
    ViewHistory
  ON ViewHistory.UserName = Users.UserName
  WHERE BeerReview.ReviewId is NULL and ViewHistory.ViewId is NULL;
  
#10 On average, how many food pairings options does any one beer style have?
SELECT AVG(T.Pairing_Counts) as Average_Pairing
FROM(
  SELECT BeerStyles.Style, COUNT(*) AS Pairing_Counts
  FROM BeerStyles LEFT OUTER JOIN Food
    ON BeerStyles.Style = Food.Style
  GROUP BY BeerStyles.Style
) AS T
