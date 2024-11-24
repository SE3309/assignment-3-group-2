SELECT F.predictedTemp, F.predictedHumidity
FROM Forecast F, UserProfile U
WHERE F.email = U.email AND U.location = 'South Thomas';

SELECT username
FROM UserProfile
WHERE email IN (
    SELECT email
    FROM Forecast
    WHERE predictedPrecipitation > 49.9
);

SELECT modelName
FROM ForecastModel FM
WHERE EXISTS (
    SELECT 1
    FROM Forecast F
    WHERE F.modelType = FM.modelName AND FM.accuracy >= '90%'
);

SELECT location, AVG(predictedTemp) AS avgTemp
FROM Forecast
GROUP BY location;

SELECT O.locationName, W.temperature, W.humidity
FROM ObservationPoint O, WeatherData W
WHERE O.locationName = W.location
  AND O.latitude BETWEEN 30.0 AND 50.0
  AND O.longitude BETWEEN -100.0 AND -70.0;

SELECT U.username, COUNT(F.email) AS forecastCount
FROM UserProfile U, Forecast F
WHERE U.email = F.email
GROUP BY U.username
ORDER BY forecastCount DESC
LIMIT 5;

SELECT locationType, COUNT(*) AS observationCount
FROM ObservationPoint
GROUP BY locationType
HAVING locationType IN ('Urban', 'Suburban', 'Rural');