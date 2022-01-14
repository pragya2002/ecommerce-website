from datetime import datetime
import json
from unicodedata import category
from flask import Flask, escape, request, render_template, request, session, redirect,flash
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import pymysql
pymysql.install_as_MySQLdb()
f = open('config.json', "r")
# Reading from file
params = json.loads(f.read())["params"]
app = Flask(__name__)

app.config['SECRET_KEY'] = 'the random string'

app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]

db = SQLAlchemy(app)

class Products(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    category= db.Column(db.String(100), nullable=False)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(200), nullable=False)
    price = db.Column(db.Integer, nullable=False)
    img_url = db.Column(db.String(200), nullable=False)
    quantity_avail = db.Column(db.Integer, nullable=False)

class Users(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name= db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(100), nullable=False)
    username = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(200), nullable=False)
    
class Orders(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    username= db.Column(db.String(100), nullable=False)
    product = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.String(200), nullable=False)
    date = db.Column(db.String(200), nullable=False)
    price = db.Column(db.String(100), nullable=False)
    img_url = db.Column(db.String(200), nullable=False)
    
@app.route('/', methods=['GET', 'POST'])
def index():
    if "user" in session:
        products=Products.query.filter_by().all()
        if "user" in session:
            return(render_template("dashboard.html",products=products))
    if(request.method == "POST"):
        username = request.form.get("username")
        password = request.form.get("password")
        if username == params["admin_username"] and password ==  params["admin_password"] :
            session["user"] = username
            flash("Logged in successfully!")
            return(redirect("/"))
        else:
            flash("Wrong username or password!")
    return(render_template("login.html"))



@ app.route('/edit/<string:sno>', methods=["GET", "POST"])
def edit(sno):
    if "user" in session and session["user"] == params["admin_username"]:
        product=Products.query.filter_by(sno=sno).first()
        if(request.method == "POST"):
            title = request.form.get("title")
            category = request.form.get("category")
            price = request.form.get("price")
            quantity_avail = request.form.get("quantity_avail")
            description = request.form.get("description")
            img_url = request.form.get("img_url")
            if(sno == "0"):
                entry = Products(title=title,
                              category=category, price=price, quantity_avail=quantity_avail, description=description, img_url=img_url)
                db.session.add(entry)
                db.session.commit()

            else:
                product.title = title
                product.category = category
                product.price = price
                product.quantity_avail = quantity_avail
                product.description = description
                product.img_url = img_url
                db.session.commit()
                
            return(redirect("/"))

        return render_template("edit.html", product=product,sno=sno)
    return(render_template("error.html"))

@ app.route('/delete/<string:sno>', methods=["GET", "POST"])
def delete(sno):
    if "user" in session and session["user"] == params["admin_username"]:
        product = Products.query.filter_by(sno=sno).first()
        db.session.delete(product)
        db.session.commit()
    return redirect("/")

 
@app.route('/logout')
def logout():
    session.pop("user")
    return redirect("/")

@app.route('/users', methods=['GET', 'POST'])
def users():
    if "user" in session:
        users=Users.query.filter_by().all()
        return(render_template("users.html",users=users))
    
    return(render_template("error.html"))
 
 
@app.route('/edit_user/<string:sno>', methods=["GET", "POST"])
def edit_user(sno):
    if "user" in session and session["user"] == params["admin_username"]:
        user=Users.query.filter_by(sno=sno).first()
        if(request.method == "POST"):
            name = request.form.get("name")
            username = request.form.get("username")
            phone = request.form.get("phone")
            password = request.form.get("password")
            
            if(sno == "0"):
                entry = Users(name=name,
                              username=username, phone=phone, password=password)
                db.session.add(entry)
                db.session.commit()

            else:
                user.name = name
                user.username = username
                user.phone = phone
                user.password = password
                db.session.commit()
                
            return(redirect("/users"))

        return render_template("edit_user.html", user=user,sno=sno)
    return(render_template("error.html"))
   

@ app.route('/delete_user/<string:sno>', methods=["GET", "POST"])
def delete_user(sno):
    if "user" in session and session["user"] == params["admin_username"]:
        user = Users.query.filter_by(sno=sno).first()
        db.session.delete(user)
        db.session.commit()
    return redirect("/users")

@app.route('/orders', methods=['GET', 'POST'])
def orders():
    if "user" in session:
        orders=Orders.query.filter_by().all()
        lst=[]
        for order in orders:
            a=order.username
            b=order.date
            if [a,b] not in lst:
                lst.append([a,b])
        return(render_template("orders.html",lst=lst))
    
    return(render_template("error.html"))



@app.route('/view_order/<string:username>/<string:date>', methods=['GET', 'POST'])
def view_order(username,date):
    if "user" in session:
        orders=Orders.query.filter_by(username=username,date=date).all()
        totall=0
        for i in orders:
            totall=totall+(int(i.price)*i.quantity)
        return(render_template("view_order.html",orders=orders,username=username,date=date,totall=totall))

    return(render_template("error.html"))


@ app.route('/delivered/<string:username>/<string:date>', methods=["GET", "POST"])
def delivered(username,date):
    if "user" in session and session["user"] == params["admin_username"]:
        orders = Orders.query.filter_by(username=username,date=date).all()
        for order in orders:
            db.session.delete(order)
            db.session.commit()
    return redirect("/orders")

app.run(debug="True")