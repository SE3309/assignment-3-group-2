use weathersystem; 

describe UpdateTable;
describe WeatherData;
describe ObservationPoint;
describe Forecast;
describe ForecastModel;
describe UserProfile;

select * from forecast;
select * from observationPoint;
select * from weatherData;
insert into forecast (recordDateandTime, location, predictedTemp, predictedHumidity, predictedWindSpeed, predictedPrecipitation, predictedUV, predictedPollen, modelType)
values(
"13/11/2024/1234",
"Batman",
20,
55,
12,
6.2,
6,
20,
"climate");



INSERT INTO ObservationPoint(locationName, recordDateandTime)
SELECT location, recordDateandTime FROM forecast;

INSERT INTO WeatherData(temperature, humidity, windSpeed, location,  pollen, precipitation, recordDateandTime)
SELECT predictedTemp, predictedHumidity, predictedWindSpeed, location, predictedPollen, predictedPrecipitation, recordDateandTime FROM forecast;


