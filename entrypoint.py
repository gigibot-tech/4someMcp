# app.py

from flask import Flask, request, jsonify
from sqlalchemy import create\_engine, text

app = Flask(**name**)

@app.route('/execute\_query', methods=\['POST'])
def execute\_query():
data = request.get\_json() or {}
db = data.get('db\_info')
query = data.get('query')
max\_rows = data.get('max\_rows', 100)

if not db or not query:
    return jsonify({'error': 'db_info and query fields are required'}), 400

# Construct SQLAlchemy URL
db_type = db.get('database_type').lower()
user = db.get('username')
pwd = db.get('password')
host = db.get('host')
port = db.get('port')
name = db.get('database_name')
ssl = db.get('ssl', False)

url = f"{db_type}://{user}:{pwd}@{host}:{port}/{name}"
if ssl:
    url += '?sslmode=require'

try:
    engine = create_engine(url)
    with engine.connect() as conn:
        result = conn.execute(text(query).execution_options(stream_results=True))
        rows = [list(row) for row in result.fetchmany(max_rows)]
        cols = result.keys()
    return jsonify({
        'executed_query': query,
        'columns': cols,
        'rows': rows
    })
except Exception as e:
    return jsonify({'error': str(e)}), 500
```

if **name** == '**main**':
app.run(host='0.0.0.0', port=8000)
