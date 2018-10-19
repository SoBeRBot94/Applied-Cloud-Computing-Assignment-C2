#!/usr/bin/env python3

from flask import Flask, jsonify
import subprocess
import sys
import os

app = Flask(__name__)


@app.route('/cowsay/api/v1.0/saysomething', methods=['GET'])
def cow_say():
    containerHostname = os.uname().nodename
    data=subprocess.check_output(["cowsay","Hello student"])
    return data, containerHostname

if __name__ == '__main__':
    
    app.run(host='0.0.0.0',debug=True)
