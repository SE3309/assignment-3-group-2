CREATE VIEW UserWeatherData AS
SELECT
    u.email,
    u.username,
    u.location AS userLocation,
    w.recordDateandTime,
    w.temperature,
    w.humidity,
    w.windSpeed,
    w.windDirection
FROM
    UserProfile u
JOIN
    WeatherData w
ON
    u.email = w.email;

CREATE VIEW ForecastObservation AS
SELECT
    f.modelName,
    f.accuracy,
    o.locationName,
    o.longitude,
    o.latitude,
    o.altitude,
    o.timeZone
FROM
    ForecastModel f
JOIN
    ObservationPoint o
ON
    f.modelType = o.locationType;