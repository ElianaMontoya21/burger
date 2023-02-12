from flask import Flask

app = Flask(__name__)

#genrarla secret_key
app.secret_key = "burger_project"