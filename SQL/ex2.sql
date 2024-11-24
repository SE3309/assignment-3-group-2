Create Database WeatherSystem;
create TABLE UserProfile(
email VARCHAR(200) PRIMARY KEY NOT NULL,
username VARCHAR(150),
userPassword VARCHAR(150),
location VARCHAR(150),
permissionLevel VARCHAR(150),
units VARCHAR(50),
defaultLocation VARCHAR(200),
notifications VARCHAR(100),
savedSearches VARCHAR(100),
userRole VARCHAR(100)
);

create TABLE ForecastModel(
modelName varchar(200) PRIMARY KEY NOT NULL,
modelType varchar(150),
accuracy varchar(200),
lastUpdated varchar(100),
algorithmType varchar(100) 
);

create TABLE Forecast(
recordDateandTime varchar(150) NOT NULL,
location varchar(150) NOT NULL,
predictedTemp varchar(150),
predictedHumidity varchar(100),
predictedWindSpeed int,
predictedPrecipitation float,
predictedUV int,
predictedPollen varchar(100),
modelType varchar(150),
email varchar(200),
FOREIGN KEY (email) references UserProfile(email),
PRIMARY KEY (recordDateandTime, location)
);

create TABLE ObservationPoint(
locationName varchar(200) PRIMARY KEY NOT NULL,
longitude float,
latitde float,
altitude float,
locationType varchar(150),
timeZone varchar(100),
recordDateandTime varchar(100)
);

create TABLE WeatherData(
temperature float,
humidity varchar(100),
windSpeed int,
windDirection varchar(100),
location varchar(150) NOT NULL,
pollen varchar(100),
precipitation float,
recordDateandTime varchar(100) NOT NULL,
email varchar(150),
FOREIGN KEY (email) references UserProfile(email),
PRIMARY KEY (recordDateandTime, location)
);

create TABLE UpdateTable(
newData varchar(250) PRIMARY KEY NOT NULL,
recordDateandTime varchar(200),
FOREIGN KEY (recordDateandTime) references Forecast(recordDateandTime)
);
