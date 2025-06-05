# Depannini Project - Backend & Frontend Integration Guide



## Getting Started with the Backend

### Prerequisites

- Python 3.9+
- pip
- virtualenv
- PostgreSQL (recommended) or SQLite
The project is using postgres as a database so you have install it on your machine and configure it 
otherwise you can go with sqlite, just uncomment the database settings for sqlite in settings.py and comment 
those of postgres . 
### Installation & Setup

1. Clone the repository:
```bash
git clone <repository-url>
cd backend  #you must be in this folder depannini/backend
```

2. Create and activate a virtual environment:
```bash
#Delete the existing folder first
python -m venv venv
source venv/bin/activate  # On Windows: venv/Scripts/Activate  #if you had problem look how to change the restriction policy
```

3. Install dependencies:

pip install -r requirements.txt
```

4. Set up environment variables:

cd depannini
#you must must locate in this folder depannini/backend/depannini
Create a `.env` file in the root directory with: 

```
#you need to create a twilio account from https://www.twilio.com/en-us and get this data :
#for you mohamed I sent you the info by email so you don't have to create anything just replace the info

TWILIO_ACCOUNT_SID = 'your twilio account sid'
TWILIO_AUTH_TOKEN = 'your twilio auth token'
TWILIO_PHONE_NUMBER= 'you twilio phone number'

# if you want to use the email endpoints : you have to generate a token in your google account and use it as a password so you can send emails using you google account

EMAIL_USER=your_email@example.com
EMAIL_PASS=your_password

```

5. Run migrations:
```bash

python manage.py makemigrations
python manage.py migrate
```

6. Create superuser:
#You use it to sign in to django admin panel, it's accessed from the web using the end point 
/http:localhost:8000/admin/
```bash
python manage.py createsuperuser
```
7. Populate database:
```bash
python manage.py populate_data

8. Start the development server:
```bash
#you have to run this command when you see in the folder a file called manage.py
daphne -b 0.0.0.0 -p 8000 depannini.asgi:application
```

## API Endpoints

### Authentication

- `POST /api/auth/register/` - User registration #go to api.http file to see an example
- `POST /api/auth/verify-email/` - Email verification #sends code to the email of the user that sent this request if not verified
- `POST /api/auth/verify-email/confirm/` #in the body put the code entered by the user and the backend will verify the code if it's true will validate the email 
- `POST /api/auth/verify-phone/` - Phone verification #in the body send a phone number ex:+213783... I'll send a code to this phone number and return the same code in the http response you have to compare the code entered by the user and the code I returned in order to verify that phone number
- `POST /api/auth/login/email/` - Email login #in the body send an email and password in the response you will get the token and the refresh token of this user 
- `POST /api/auth/login/phone/` - Phone login #same method with email login
- `POST /api/auth/token/refresh/` - Refresh JWT token 
-`POST /api/auth/password-reset/` - Request password reset #we assume that the user is not logged in this request is sent from the login page 'forget password'
-`POST /api/auth/password-reset/confirm/` - Confirm password reset
### to see examples go to api.http file 
### User Profiles

- `GET /api/profile/user/` - Get user profile
- `PUT /api/profile/user/` - Update user profile
- `GET /api/profile/assistant/` - Get assistant profile
- `PUT /api/profile/assistant/` - Update assistant profile

- `POST /api/profile/update-status/`
- `POST /api/profile/update-location/`

### Assistance flow

- `POST /assistance/request/` #for ass
- `POST /assistance/accept/<assistance_id>/`
- `POST /assistance/`
- `POST /assistance/`