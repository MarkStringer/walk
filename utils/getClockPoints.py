import math
import argparse

# Constants
EARTH_RADIUS_MILES = 3958.8  # Earth radius in miles

def clockface_to_bearing(clock_number):
    # Convert clock number (1-12) to degrees
    return (12 - clock_number) * 30

def calculate_destination(lat, lon, clock_number, distance_miles):
    # Convert latitude and longitude from degrees to radians
    lat_rad = math.radians(lat)
    lon_rad = math.radians(lon)
    
    # Convert clock number to bearing in degrees and then to radians
    bearing_deg = clockface_to_bearing(clock_number)
    bearing_rad = math.radians(bearing_deg)
    
    # Calculate the angular distance in radians
    angular_distance = distance_miles / EARTH_RADIUS_MILES
    
    # Haversine formula for destination point
    new_lat_rad = math.asin(math.sin(lat_rad) * math.cos(angular_distance) + 
                            math.cos(lat_rad) * math.sin(angular_distance) * math.cos(bearing_rad))
    
    new_lon_rad = lon_rad + math.atan2(math.sin(bearing_rad) * math.sin(angular_distance) * math.cos(lat_rad),
                                       math.cos(angular_distance) - math.sin(lat_rad) * math.sin(new_lat_rad))
    
    # Convert back from radians to degrees
    new_lat = math.degrees(new_lat_rad)
    new_lon = math.degrees(new_lon_rad)
    
    # Normalize the longitude to be between -180 and 180
    new_lon = (new_lon + 540) % 360 - 180
    
    return new_lat, new_lon

def main():
    # Set up argument parsing
    parser = argparse.ArgumentParser(description="Calculate new latitude and longitude from clockface direction and distance.")
    parser.add_argument('latitude', type=float, help='Initial latitude')
    parser.add_argument('longitude', type=float, help='Initial longitude')
    parser.add_argument('clock_number', type=int, choices=range(1, 13), help='Clock face number (1-12)')
    parser.add_argument('distance_miles', type=float, help='Distance in miles')
    
    args = parser.parse_args()
    
    # Call the calculate_destination function with the parsed arguments
    new_lat, new_lon = calculate_destination(args.latitude, args.longitude, args.clock_number, args.distance_miles)
    
    # Output the result
    print(f"{new_lat}, {new_lon}")

if __name__ == "__main__":
    main()

