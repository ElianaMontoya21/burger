from flask_app.config.mysqlconnection import connectToMySQL

import re #importamos exprsiones regulares

#crear una expresión regular para verificar que tengamos el email con formato correcto
EMAIL_REGEX = re.compile(r'^[a-zA-Z0-9.+_-]+@[a-zA-Z0-9._-]+\.[a-zA-Z]+$')

from flask import flash #mandar mensajes a la plantilla

class User:
    
    def __init__(self, data):
        self.id = data['id']
        self.first_name = data['first_name']
        self.last_name = data['last_name']
        self.email = data['email']
        self.password = data['password']
        self.created_at = data['created_at']
        self.updated_at = data['updated_at']

    @classmethod
    def save(cls, formulario):
        query = "INSERT INTO users(first_name, last_name, email, password) VALUES (%(first_name)s, %(last_name)s, %(email)s, %(password)s);"
        result = connectToMySQL('proyecto_db').query_db(query, formulario) #insert resive id
        return result #result = Identificador del nuevo registro


    @staticmethod
    def valida_usuario(formulario):
        #formulario = {
        #    first_name:    "Elena",
        #    last_name:     "De Troya",
        #    email:         "elena@codingdojo.com",
        #    password:      "password123",
        #confirm_password:      "password123",
        #}
        es_valido = True

        # validar que mi nombre tenga más de dos caracteres 
        if len(formulario['first_name']) <3:
            flash('Nombre debe tener almenos 3 caracteres', 'registro')
            es_valido = False

        if len(formulario['last_name']) <3:
            flash('Apellido debe tener al menos 3 caracteres', 'registro')
            es_valido = False

        #valido email con expresiones regulares
        if not EMAIL_REGEX.match(formulario['email']):
            flash('E-mail invalido', 'registro')
            es_valido = False
        
        if len(formulario['password']) < 6:
            flash('contraseña debe tener al menos 6 caracteres', 'registro')
            es_valido = False
        
        if formulario['password'] != formulario['confirm_password']:
            flash('contraseñas no coinciden', 'registro')
            es_valido = False

        # consultar si ya existeel correo
        query = "SELECT * FROM users WHERE email = %(email)s"
        results = connectToMySQL('proyecto_db').query_db(query, formulario)
        if len(results) >= 1:
            flash('E-mail registrado previamente', 'registro')
            es_valido = False
        
        return es_valido

    @classmethod
    def get_by_email(cls, formulario):
        #formulario = {
        #   "email": "elena@cd.com"
        #   "password": "1234"
        #}
        query = "SELECT * FROM users WHERE email = %(email)s"
        result = connectToMySQL('proyecto_db').query_db(query, formulario)
        if len(result) < 1:
            return False
        else:
            #result = [ {first_name: Elena, last_name: De Troya.....} ]
            user = cls(result[0]) #Haciendo una instancia de User -> CON los datos que recibimos de la base de datos
            return user

    @classmethod
    def get_by_id (cls, formulario):
        query = "SELECT * FROM users WHERE id = %(id)s"
        result = connectToMySQL('proyecto_db').query_db(query, formulario) #select resive lista
        user = cls(result[0])
        return user


