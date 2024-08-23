import mysql.connector
from flask import Flask, jsonify, request

app = Flask(__name__)

# Database connection function
def get_db_connection():
    connection = mysql.connector.connect(
        host="localhost",      # XAMPP MySQL host
        user="root",           # Default MySQL user
        password="",           # Default MySQL password (empty)
        database="maintenance_web_service"    # Your database name
    )
    return connection

@app.route('/api/users', methods=['GET'])
def get_users():
    conn = get_db_connection()
    cursor = conn.cursor(dictionary=True)
    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()
    cursor.close()
    conn.close()
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


# Define a route for the service
@app.route('/api', methods=['GET'])
def api():
    # Example data to return
    data = {
        "message": "Hello, World!",
        "status": "success"
    }
    return jsonify(data)

# Define another route with parameters
@app.route('/api/greet/<name>', methods=['GET'])
def greet(name):
    return jsonify({"message": f"Hello, {name}!"})

# Run the service
if __name__ == '__main__':
    app.run(port=5001, debug=True)
