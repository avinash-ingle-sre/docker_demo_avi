from flask import Flask, jsonify
import os

app = Flask(__name__)

@app.route('/health', methods=['GET'])
def health():
    return jsonify({"status": "healthy", "service": "order-service"}), 200

@app.route('/api/v1/orders', methods=['GET'])
def get_orders():
    return jsonify([
        {"order_id": 101, "item": "Laptop", "status": "Shipped"},
        {"order_id": 102, "item": "Monitor", "status": "Processing"}
    ]), 200

if __name__ == '__main__':
    port = int(os.environ.get('PORT', 8080))
    app.run(host='0.0.0.0', port=port)
