# Delete all forecasts and associated updateTable elements that are older than a certain threshold 
	# (eg. 20days), ensuring db only stores relevant, recent data
# Removing from forecast improves performance as full table scans are faster and indexes may be less bloated
# WeatherData older than 20 days is still saved and can be used for more histrical analysis
	# This does not need to be deleted since the WeatherData relation is queried much less often than Forecast
DELETE updatetable, Forecast
FROM updatetable
JOIN Forecast ON updatetable.recordDateandTime = Forecast.recordDateandTime
WHERE Forecast.recordDateandTime > (CURRENT_DATE - INTERVAL 20 DAY);


# Promote the userRole of an active user (with userRole = Editor) who has submitted more than x weatherData entries
# Rewarding users with higher permission/roles encourages contributions, which can lead to a more robust dataset
UPDATE UserProfile
SET userRole = 'AdvancedEditor'
WHERE email IN (
    SELECT email
    FROM WeatherData
    GROUP BY email
    HAVING COUNT(*) > 4
);

# Insert weatherData into missing forecasts where forecast does not contain an entry for that date and time
# This enhances data completeness, benefitting short-term forecasts that can now make predictions based on current data rather than more historical data
# Models can also be updated/recalibrated based on the latest observations, improving future predictions
INSERT INTO Forecast (
    recordDateandTime,
    location,
    predictedTemp,
    predictedHumidity,
    predictedWindSpeed,
    predictedPrecipitation,
    predictedUV,
    predictedPollen,
    modelType,
    email
)
SELECT
    recordDateandTime,
    location,
    temperature AS predictedTemp,
    humidity AS predictedHumidity,
    windSpeed AS predictedWindSpeed,
    precipitation AS predictedPrecipitation,
    NULL AS predictedUV,
    pollen AS predictedPollen,
    'DataDrivenModel' AS modelType,
    email
FROM WeatherData w
WHERE DATE_FORMAT(w.recordDateandTime, '%Y-%m-%d %H') IN (
    SELECT DATE_FORMAT(f.recordDateandTime, '%Y-%m-%d %H')
    FROM Forecast f
    WHERE w.location = f.location
);			