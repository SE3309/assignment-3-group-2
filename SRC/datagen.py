from faker import Faker
import random
import csv

fake = Faker()

# Number of records to generate
user_profile_count = 2000
forecast_model_count = 10
forecast_count = 2000
observation_point_count = 500
weather_data_count = 2000
update_table_count = 500

# Function to generate a unique set of values
def generate_unique_set(generator_function, count):
    unique_values = set()
    while len(unique_values) < count:
        unique_values.add(generator_function())
    return list(unique_values)

# Function to save data to CSV files
def save_to_csv(data, filename):
    if data:
        keys = data[0].keys()
        with open(filename, 'w', newline='', encoding='utf-8') as file:
            writer = csv.DictWriter(file, fieldnames=keys)
            writer.writeheader()
            writer.writerows(data)

# Generate data for each table
def generate_data():
    # Generate UserProfile data
    user_profiles = []
    emails = generate_unique_set(fake.email, user_profile_count)
    for email in emails:
        user_profiles.append({
            "email": email,
            "username": fake.user_name(),
            "userPassword": fake.password(),
            "location": fake.city(),
            "permissionLevel": random.choice(["Admin", "User", "Guest"]),
            "units": random.choice(["Metric", "Imperial"]),
            "defaultLocation": fake.city(),
            "notifications": random.choice(["Enabled", "Disabled"]),
            "savedSearches": fake.word(),
            "userRole": random.choice(["Basic", "Premium", "VIP"])
        })

    # Generate ForecastModel data
    forecast_models = []
    model_names = generate_unique_set(fake.word, forecast_model_count)
    for model_name in model_names:
        forecast_models.append({
            "modelName": model_name,
            "modelType": random.choice(["Numerical", "Statistical", "Hybrid"]),
            "accuracy": f"{random.uniform(80, 99):.2f}%",
            "lastUpdated": fake.date_time_this_year().isoformat(),
            "algorithmType": random.choice(["AI", "ML", "Traditional"])
        })

    # Generate ObservationPoint data
    observation_points = []
    location_names = generate_unique_set(fake.city, observation_point_count)
    for location_name in location_names:
        observation_points.append({
            "locationName": location_name,
            "longitude": random.uniform(-180, 180),
            "latitude": random.uniform(-90, 90),
            "altitude": random.uniform(0, 5000),
            "locationType": random.choice(["Urban", "Rural", "Suburban"]),
            "timeZone": fake.timezone(),
            "recordDateandTime": fake.date_time_this_year().isoformat()
        })

    # Generate Forecast data
    forecasts = []
    for _ in range(forecast_count):
        location = random.choice(location_names)  # Ensure location matches ObservationPoint
        forecasts.append({
            "recordDateandTime": fake.date_time_this_month().isoformat(),
            "location": location,
            "predictedTemp": f"{random.uniform(-30, 40):.2f}",
            "predictedHumidity": f"{random.uniform(10, 100):.2f}",
            "predictedWindSpeed": random.randint(0, 100),
            "predictedPrecipitation": random.uniform(0, 50),
            "predictedUV": random.randint(0, 10),
            "predictedPollen": random.choice(["Low", "Moderate", "High"]),
            "modelType": random.choice(model_names),  # Ensure modelType matches ForecastModel
            "email": random.choice(emails)  # Ensure email matches UserProfile
        })

    # Generate WeatherData
    weather_data = []
    for _ in range(weather_data_count):
        location = random.choice(location_names)  # Ensure location matches ObservationPoint
        weather_data.append({
            "temperature": random.uniform(-30, 40),
            "humidity": f"{random.uniform(10, 100):.2f}",
            "windSpeed": random.randint(0, 100),
            "windDirection": random.choice(["N", "S", "E", "W"]),
            "location": location,  # Ensure location matches ObservationPoint
            "pollen": random.choice(["Low", "Moderate", "High"]),
            "precipitation": random.uniform(0, 50),
            "recordDateandTime": fake.date_time_this_month().isoformat(),
            "email": random.choice(emails)  # Ensure email matches UserProfile
        })

    # Generate UpdateTable data
    updates = []
    for _ in range(update_table_count):
        updates.append({
            "newData": fake.sentence(),
            "recordDateandTime": random.choice([forecast["recordDateandTime"] for forecast in forecasts])  # Match Forecast recordDateandTime
        })

    return {
        "UserProfile": user_profiles,
        "ForecastModel": forecast_models,
        "Forecast": forecasts,
        "ObservationPoint": observation_points,
        "WeatherData": weather_data,
        "UpdateTable": updates
    }


# Generate and save data
generated_data = generate_data()
for table_name, table_data in generated_data.items():
    save_to_csv(table_data, f"{table_name}.csv")

print("Data generation complete. Files saved.")
