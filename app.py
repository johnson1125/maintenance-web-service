import mysql.connector
from flask import Flask, jsonify, request
import re
from datetime import datetime

app = Flask(__name__)


# Database connection function
def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",  # XAMPP MySQL host
        user="root",  # Default MySQL user
        password="",  # Default MySQL password (empty)
        database="maintenance_web_service"  # Your database name
    )
    return connection


# Testing
class User:
    def __init__(self, id, name, email):
        self.id = id
        self.name = name
        self.email = email
        self.test = {'test1', 'test2'}

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'email': self.email,
            'tests': [test for test in self.test],
            'class': {'attr1': 'test', 'attr2': 'test', 'attr3': 'test', }

        }


class Maintenance:
    def __init__(self, id, name, description, duration, hallType):
        self.id = id
        self.name = name
        self.description = description
        self.duration = duration
        self.hallType = hallType

    def to_dict(self):
        return {
            'id': self.id,
            'name': self.name,
            'description': self.description,
            'duration': self.duration,
            'hallType': self.hallType

        }

    def to_dict_id_name(self):
        return {
            'id': self.id,
            'name': self.name,
        }


class MaintenanceRecord:
    def __init__(self, id, startTime, hallID, maintenance):
        self.id = id
        self.startTime = startTime
        self.hallID = hallID
        self.maintenance = maintenance

    # create different to_dict for different data format
    def to_dict(self):
        return {
            'id': self.id,
            'startTime': self.startTime,
            'hallID': self.hallID,
            'maintenance': {'id': self.maintenance.id,
                            'name': self.maintenance.name,
                            'hallType': self.maintenance.hallType,
                            'description': self.maintenance.description,
                            'duration': self.maintenance.duration}

        }


@app.route('/api/maintenances', methods=['GET'])
def get_maintenances():
    # Retrieve optional query parameters with defaults
    hallType = request.args.get('hallType', default=None)
    maintenanceID = request.args.get('maintenanceID', default=None)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if (maintenanceID == None and hallType == None):
        cursor.execute("SELECT * FROM maintenances ")
    if (maintenanceID != None):
        cursor.execute("SELECT * FROM maintenances WHERE maintenanceID = %s", (maintenanceID,))
    if (hallType != None):
        cursor.execute("SELECT *  FROM maintenances WHERE hallType = %s", (hallType,))
    maintenances_data = cursor.fetchall()
    cursor.close()
    conn.close()
    # Create an array of User objects
    maintenances = []
    maintenances_formated_data = []
    for maintenance in maintenances_data:
        # Instantiate a User object with data from the database
        maintenance_obj = Maintenance(
            id=maintenance['maintenanceID'],
            name=maintenance['name'],
            description=maintenance['description'],
            duration=str(maintenance['duration']),
            hallType=maintenance['hallType'],

        )
        maintenances.append(maintenance_obj)

    if (hallType != None):
        for maintenance in maintenances:
            maintenances_formated_data.append(maintenance.to_dict_id_name())
    else:
        for maintenance in maintenances:
            maintenances_formated_data.append(maintenance.to_dict())
    return jsonify(maintenances_formated_data)


@app.route('/api/maintenance-record', methods=['POST'])
def add_maintenance_record():
    conn = get_db_connection()
    cursor = conn.cursor()
    new_maintenance_record = request.json

    starTime = new_maintenance_record['startTime']
    hallID = new_maintenance_record['hallID']
    maintenanceID = new_maintenance_record['maintenanceID']
    provided_date = datetime.strptime(starTime, "%Y-%m-%d %H:%M:%S")
    provided_date_str = provided_date.strftime("%y%m%d")
    id = get_next_id(provided_date_str)

    cursor.execute(
        "INSERT INTO `maintenancerecords` (`maintenanceRecordID`, `startTime`, `hallID`, `maintenanceID`) VALUES (%s,"
        "%s,%s,%s);",
        (id, starTime, hallID, maintenanceID))
    conn.commit()

    cursor.close()
    conn.close()
    return jsonify({"message": "maintenance record added successfully!", "maintenanceID": id}), 201


@app.route('/api/maintenance-records', methods=['GET'])
def get_maintenance_records():
    # Retrieve optional query parameters with defaults
    hallID = request.args.get('hallID', default=None)

    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    if (hallID != None):
        cursor.execute("SELECT * FROM maintenancerecords INNER JOIN maintenances maintenancerecords.maintenanceID = "
                       "maintenances.maintenanceID ON WHERE hallID = %s", (hallID,))
    else:
        cursor.execute("SELECT * FROM maintenancerecords INNER JOIN maintenances on maintenancerecords.maintenanceID = "
                       "maintenances.maintenanceID")
    maintenance_records_data = cursor.fetchall()
    cursor.close()
    conn.close()
    # Create an array of User objects
    maintenance_records = []
    for maintenance_record in maintenance_records_data:
        # Instantiate a User object with data from the database

        maintenance_obj = Maintenance(
            id=maintenance_record['maintenanceID'],
            name=maintenance_record['name'],
            description=maintenance_record['description'],
            duration=str(maintenance_record['duration']),
            hallType=maintenance_record['hallType'],
        )

        maintenance_record_obj = MaintenanceRecord(
            id=maintenance_record['maintenanceRecordID'],
            startTime=str(maintenance_record['startTime']),
            hallID=maintenance_record['hallID'],
            maintenance=maintenance_obj
        )

        maintenance_records.append(maintenance_record_obj.to_dict())

    return jsonify(maintenance_records)

def get_next_id(provided_date_str):


    # Fetch the latest ID for the provided date
    latest_id = fetch_latest_id_for_date(provided_date_str)

    if latest_id is None:
        # If no latest ID found, start with the first suffix
        next_suffix_str = "0001"
    else:
        # Regular expression to match the pattern MTN-DDMMYY-XXXX
        pattern = r"^(MTNRD-(\d{6})-(\d{4}))$"
        match = re.match(pattern, latest_id)

        if match:
            # Extract components from the latest ID
            current_date_str = match.group(2)
            suffix = match.group(3)

            if current_date_str == provided_date_str:
                # Increment the suffix if the date matches
                next_suffix = int(suffix) + 1
                next_suffix_str = str(next_suffix).zfill(4)
            else:
                # Reset the suffix if the date does not match
                next_suffix_str = "0001"
        else:
            raise ValueError("Invalid ID format")

    # Generate the new ID
    new_id = f"MTNRD-{provided_date_str}-{next_suffix_str}"
    return new_id


def fetch_latest_id_for_date(date_str):
    conn = get_db_connection()
    cursor = conn.cursor()
    # Convert date_str to the format used in your database, if necessary
    cursor.execute("""
        SELECT maintenancerecordID 
        FROM maintenancerecords 
        WHERE DATE(startTime) = %s 
        ORDER BY maintenancerecordID DESC 
        LIMIT 1
        """, (date_str,))
    result = cursor.fetchone()
    conn.close()

    if result:
        return result[0]  # Assuming the ID is in the first column
    return None


@app.route('/api/users', methods=['GET'])
def get_users():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users")
    users_data = cursor.fetchall()
    cursor.close()
    conn.close()
    print(users_data)
    # Create an array of User objects
    users = []
    for user in users_data:
        # Instantiate a User object with data from the database
        user_obj = User(
            id=user['id'],
            name=user['name'],
            email=user['email']
        )
        users.append(user_obj.to_dict())

    return jsonify(users)


@app.route('/api/user', methods=['POST'])
def add_user():
    conn = get_db_connection()
    cursor = conn.cursor()
    new_user = request.json

    name = new_user['name']
    email = new_user['email']

    cursor.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (name, email))
    conn.commit()

    cursor.close()
    conn.close()
    return jsonify({"message": "User added successfully!"}), 201


# Run the service
if __name__ == '__main__':
    app.run(port=5001, debug=True)
    get_users()
