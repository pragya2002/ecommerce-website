from datetime import datetime
import json
import math
from flask import Flask, escape, request, render_template, request, session, redirect,flash
from flask_sqlalchemy import SQLAlchemy
from flask_mail import Mail
import pymysql
pymysql.install_as_MySQLdb()
f = open('config.json', "r")
# Reading from file
params = json.loads(f.read())["params"]
app = Flask(__name__)
app.config.update(
    MAIL_SERVER='smtp.gmail.com',
    MAIL_PORT='465',
    MAIL_USE_SSL=True,
    MAIL_USERNAME=params['gmail-user'],
    MAIL_PASSWORD=params['gmail-password']
)
mail = Mail(app)
app.config['SECRET_KEY'] = 'the random string'

app.config['SQLALCHEMY_DATABASE_URI'] = params["local_uri"]

db = SQLAlchemy(app)

@app.route('/')
def index():
    logged_in=False
    if "user" in session:
        logged_in=True
        return(render_template("index.html",newuser=session["user"],logged_in=logged_in))
    return(render_template("index.html",logged_in=logged_in))

class Users(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    name= db.Column(db.String(100), nullable=False)
    phone = db.Column(db.String(100), nullable=False)
    username = db.Column(db.String(100), nullable=False)
    password = db.Column(db.String(200), nullable=False)
    
    
@app.route('/login', methods=['GET', 'POST'])
def login(): 
    if "user" in session:
        return(redirect("/"))
    if(request.method == "POST"):
        username = request.form.get("username")
        password = request.form.get("password")
        users=Users.query.filter_by(username=username).all()
        if(users and password == users[0].password):
            session["user"] = username
            flash("Logged in successfully!")
            return(redirect("/"))
        else:
            flash("Wrong username or password!")
    return(render_template("login.html"))


@app.route('/signup', methods=['GET', 'POST'])
def signup():
    if(request.method == "POST"):
        name = request.form.get("name")
        phone = request.form.get("phone")
        username=request.form.get("username")
        password=request.form.get("password")
        f=Users.query.filter_by(username=username).all()
        if not f:
            entry = Users(name=name,
                              phone=phone, username=username, password=password)
            db.session.add(entry)
            db.session.commit()
            flash("Account created successfully!")
            session["user"] = username
            return(redirect("/"))
        else:
            flash("Username already exists!")
            return redirect("/signup")

    return render_template("signup.html")


@app.route('/logout')
def logout():
    session.pop("user")
    return redirect("/")

class Feedback(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(100), nullable=False)
    phone= db.Column(db.String(100), nullable=False)
    last = db.Column(db.String(100), nullable=False)
    feedback = db.Column(db.String(100), nullable=False)


@app.route('/feedback', methods=["GET", "POST"])
def feedback():
    logged_in=False
    if "user" in session:
        logged_in=True
        if(request.method == "POST"):
            email = request.form.get("email")
            phone = request.form.get("phone")
            last = request.form.get("last")
            feedback = request.form.get("feedback")
            entry2 = Feedback(email=email,phone=phone,last=last,feedback=feedback)
            db.session.add(entry2)
            db.session.commit()
            flash("Feedback sent!")
            mail.send_message('New message from ' + email,
                          sender=email,
                          recipients=[params["gmail-user"]],
                          body="Last Purchase: "+last+"\n\n"+"Feedback: "+feedback+"\n\n"+"Phone number: "+phone
                          )
        
        return(render_template("feed.html",newuser=session["user"],logged_in=logged_in))
    return(render_template("error.html"))


class Products(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    category= db.Column(db.String(100), nullable=False)
    title = db.Column(db.String(100), nullable=False)
    description = db.Column(db.String(200), nullable=False)
    price = db.Column(db.Integer, nullable=False)
    img_url = db.Column(db.String(200), nullable=False)
    quantity_avail = db.Column(db.Integer, nullable=False)


@app.route('/categories/<string:cat>', methods=["GET", "POST"])
def categories(cat):
    if cat=="list": 
        logged_in=False
        if "user" in session:
            logged_in=True
            return(render_template("categ.html",newuser=session["user"],logged_in=logged_in))
        return(render_template("categ.html",logged_in=logged_in))
    else:
        if cat=="accessories":
            heading="ACCESSORIES"
        elif cat=="summer":
            heading="SUMMER WEAR"
        elif cat=="winter":
            heading="WINTER WEAR"
        elif cat=="sports":
            heading="SPORTS AND ATHLEISURE"
        logged_in=False
        accessories=Products.query.filter_by(category=cat).all()
        last = math.ceil(len(accessories)/int(params['no_of_items']))
        page = request.args.get('page')
        if (not str(page).isnumeric()):
            page = 1
        page = int(page)
        accessories = accessories[(page-1)*int(params['no_of_items']):(page-1)
                    * int(params['no_of_items']) + int(params['no_of_items'])]
        if page == 1:
            prev = "#"
            next = "?page=" + str(page+1)
        elif page == last:
            prev = "?page=" + str(page-1)
            next = "#"
        else:
            prev = "?page=" + str(page-1)
            next = "?page=" + str(page+1)
        if "user" in session:
            logged_in=True
            return(render_template("accessories.html",newuser=session["user"],logged_in=logged_in,accessories=accessories,product=heading,prev=prev,next=next))
        return(render_template("accessories.html",logged_in=logged_in,accessories=accessories,product=heading,prev=prev,next=next))








class Cart(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    username= db.Column(db.String(100), nullable=False)
    product = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.Integer, nullable=False)
    price = db.Column(db.String(100), nullable=False)
    img_url = db.Column(db.String(200), nullable=False)
    
@app.route('/add_cart/<string:cat>/<string:sno>')
def add_cart(cat,sno):
    logged_in=False
    accessories=Products.query.filter_by(category=cat).all()
    if cat=="accessories":
        heading="ACCESSORIES"
    elif cat=="summer":
        heading="SUMMER WEAR"
    elif cat=="winter":
        heading="WINTER WEAR"
    else:
        heading="SPORTS AND ATHLEISURE"
    last = math.ceil(len(accessories)/int(params['no_of_items']))
    page = request.args.get('page')
    if (not str(page).isnumeric()):
        page = 1
    page = int(page)
    accessories = accessories[(page-1)*int(params['no_of_items']):(page-1)
                    * int(params['no_of_items']) + int(params['no_of_items'])]
    if page == 1:
        prev = "#"
        next = "?page=" + str(page+1)
    elif page == last:
        prev = "?page=" + str(page-1)
        next = "#"
    else:
        prev = "?page=" + str(page-1)
        next = "?page=" + str(page+1)
    if "user" in session:
        logged_in=True
        #
        chosen=Products.query.filter_by(category=cat,sno=sno).first()
        user_using=session["user"]
        item=chosen.title
        pric=chosen.price
        img=chosen.img_url
        present=Cart.query.filter_by(username=user_using,product=item).first()
        if present:
            present.quantity+=1
            db.session.commit()
        else:
            entry1=Cart(
                             username =user_using, product=item,quantity=1,price=pric,img_url=img)
            db.session.add(entry1)
            db.session.commit()
        flash("Added to cart successfully!")
        return(render_template("accessories.html",logged_in=logged_in,accessories=accessories,product=heading,snocheck=int(sno),cat=cat,newuser=session["user"],success=True,next=next,prev=prev))
    
    flash("Log in to continue shopping!")
    return(render_template("accessories.html",logged_in=logged_in,accessories=accessories,product=heading,snocheck=int(sno),cat=cat,success=False,next=next,prev=prev))


@app.route('/cart')
def cart():
    if "user" in session:
        orders=Cart.query.filter_by(username=session["user"]).all()
        totall=0
        for i in orders:
            totall=totall+(int(i.price)*i.quantity)
        return(render_template("cart.html",newuser=session["user"],logged_in=True,orders=orders,totall=totall))
    
    return(render_template("error.html"))



@app.route('/delete/<string:product>')
def delete(product):
    if "user" in session:
        order=Cart.query.filter_by(username=session["user"],product=product).first()
        if order.quantity>1:
            order.quantity-=1
        else:
            db.session.delete(order)
        db.session.commit()
        totall=0
        
        return(redirect("/cart"))
    
    return(render_template("error.html"))

class Orders(db.Model):
    sno = db.Column(db.Integer, primary_key=True)
    username= db.Column(db.String(100), nullable=False)
    product = db.Column(db.String(100), nullable=False)
    quantity = db.Column(db.String(100), nullable=False)
    img_url= db.Column(db.String(200), nullable=False)
    price= db.Column(db.String(200), nullable=False)

@app.route('/checkout')
def checkout():
    if "user" in session:
        orders=Cart.query.filter_by(username=session["user"]).all()
        for order in orders:
            product=Products.query.filter_by(title=order.product).first()
            product.quantity_avail-=order.quantity
            db.session.commit()
            entry=Orders(username=session["user"],product=product.title,quantity=order.quantity,img_url=product.img_url,price=product.price)
            db.session.add(entry)
            db.session.commit()
            db.session.delete(order) 
            db.session.commit()
        flash("Order placed successfully!")
        return(redirect("/"))
    
    return(render_template("error.html"))

app.run(debug="True")