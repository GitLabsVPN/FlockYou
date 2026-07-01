from flask import Flask, jsonify

app = Flask(__name__)

@app.route('/update', methods=['GET'])
def update_database():
    macs = [
        "78:8D:71", "3E:4F:0C", "DC:A6:0D", "00:1B:44", "B8:27:39"
    ]
    return jsonify(macs)

if __name__ == '__main__':
    app.run(debug=True)
