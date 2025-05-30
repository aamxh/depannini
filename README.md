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
cd backend
```

2. Create and activate a virtual environment:
```bash
python -m venv venv
source venv/bin/activate  # On Windows: venv/Scripts/Activate  #if you had problem look how to change the restriction policy
```

3. Install dependencies:
```bash
pip install -r requirements.txt
```

4. Set up environment variables:

cd depannini
Create a `.env` file in the root directory with:
```
#you need to create a twilio account from https://www.twilio.com/en-us and get this data :
TWILIO_ACCOUNT_SID = 'your twilio account sid'
TWILIO_AUTH_TOKEN = 'your twilio auth token'
TWILIO_PHONE_NUMBER= 'you twilio phone number'

#in email password you have to generate a token in your google account and use it as a password
EMAIL_USER=your_email@example.com
EMAIL_PASS=your_password

```

5. Run migrations:
```bash

python manage.py makemigrations
python manage.py migrate
```

6. Create superuser:
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

- `POST /api/auth/register/` - User registration
- `POST /api/auth/verify-email/` - Email verification
- `POST /api/auth/verify-phone/` - Phone verification
- `POST /api/auth/login/email/` - Email login
- `POST /api/auth/login/phone/` - Phone login
- `POST /api/auth/token/refresh/` - Refresh JWT token
-`POST /api/auth/password-reset/` - Request password reset 
-`POST /api/auth/password-reset/confirm/` - Confirm password reset

### User Profiles

- `GET /api/profile/user/` - Get user profile
- `PUT /api/profile/user/` - Update user profile
- `GET /api/profile/assistant/` - Get assistant profile
- `PUT /api/profile/assistant/` - Update assistant profile

### 

### User Profiles

- `GET /api/profile/user/` - Get user profile
- `PUT /api/profile/user/` - Update user profile
- `GET /api/profile/assistant/` - Get assistant profile
- `PUT /api/profile/assistant/` - Update assistant profile


