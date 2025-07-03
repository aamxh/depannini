# Depannini: A Full-stack Roadside Assistance Project

## Features

- Creating an account. 
- Email address validation.
- Signing-in with phone number.
- Signing-in with an email.
- Requesting an assistance: towing/repair.
- Accepting/refusing the assistance by an active assistant.
- Real-time assistance updates.

## Getting Started with the Backend

### Prerequisites

- Python 3.9+
- pip
- virtualenv
- PostgreSQL or SQLite

Notes: - For the moment, the frontend is only tested with SQLite. 
       - You have to install PostgreSQL on your machine if you want to work with it.
       - To switch between PostgreSQL and SQLite, comment/uncomment databse settings in settings.py.

### Installation & Setup

1. Clone the repository (if you haven't already):

   ```bash
   git clone https://github.com/aamxh/depannini.git
   cd depannini
   cd backend  #you must be in this folder depannini/backend
   ```

2. Create and activate a virtual environment:

   ```bash
   #Delete the existing folder first
   python -m venv venv
   source venv/bin/activate  # On Windows: venv/Scripts/Activate  #if you had problem look how to change the restriction policy
   ```

3. Install dependencies:

   ```bash
   pip install -r requirements.txt
   ```

4. Set up environment variables:

   ```bash
   cd depannini
   #you must be in this folder depannini/backend/depannini to do the next steps
   ```

5. Run migrations:

   ```bash
   python manage.py makemigrations
   python manage.py migrate
   ```

6. Create superuser:
You use it to sign-in to Django admin panel, it's accessed from the web using the end-point: http://localhost:8000/admin/

   ```bash
   python manage.py createsuperuser
   ```

7. Populate database:

   ```bash
   python manage.py populate_data
   ```

8. Start the development server:

   ```bash
   #you have to run this command when you see in the folder a file called manage.py
   daphne -b 0.0.0.0 -p 8000 depannini.asgi:application
   ```

## API Endpoints

### Authentication

- `POST /api/auth/register/` - Signing-up
- `POST /api/auth/login/email/` - Email login
- `POST /api/auth/login/phone/` - Phone login
- `POST /api/auth/token/refresh/` - Refresh JWT token 
- `POST /api/auth/password-reset/` - Request password reset
- `POST /api/auth/password-reset/confirm/` - Confirm password reset

### Edit/View Profiles

- `GET /api/profile/user/` - Get user profile
- `PUT /api/profile/user/` - Update user profile
- `GET /api/profile/assistant/` - Get assistant profile
- `PUT /api/profile/assistant/` - Update assistant profile
- `POST /api/profile/update-status/` - Update assistant status (active/inactive)
- `POST /api/profile/update-location/` - Update assistant location

### Assistance flow

- `POST /assistance/request/` - Request an assitance by a user
- `POST /assistance/accept/<assistance_id>/` - Accept an assistance by an assistant
- `POST /assistance/update/status/<assistance_id>` - Update the assistance status
- Web-Sockets endpoints:
   - `/assistance/<assistance_id>/` - Connect to the assistance web-socket
   - `/assistant/<assistant_id>` - Connect to the assistant web-socket

## Getting Started with the Front-end

### Prerequisites

- Flutter
- Android studio (recommended) or Visual Studio Code
- Google maps API keys: Android maps sdk key, iOS maps sdk key, directions key, and distance matrix key.

### Installation & Setup

1. Clone the repository (if you haven't already)

   ```bash
   git clone https://github.com/aamxh/depannini.git
   cd depannini
   ```

2. Install the required dependencies

   ```bash
   cd depannini-user
   flutter pub get

   cd ../depannini-assistant
   flutter pub get
   ```

3. Add the Google maps SDK key for Android

Both apps require adding a valid Google maps SDK key to AndriodManifest.xml, either by:
  
   - Adding it directly inside android/app/src/main/AndroidManifest.xml: 
  
      ```bash
      <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="@string/<YOUR_ACTUAL_KEY_HERE>"/>
      ```

   - Adding a refrence inside android/app/src/main/AndroidManifest.xml (recommended):
 
      ```bash
      <meta-data
        android:name="com.google.android.geo.API_KEY"
        android:value="@string/google_maps_key"/>
      ```
 
      Then add this to android/local.properties:
     
        ```bash
        MAPS_API_KEY=<your_actual_key_here>
        ```

      And before `defaultConfig()` block, add this to android/app/build.gradle:

        ```bash
        def MAPS_API_KEY = project.hasProperty("MAPS_API_KEY") ? project.MAPS_API_KEY : ""
        ``` 
  
      Finally, add this inside `defaultConfig()`:

        ```bash
        resValue "string", "google_maps_key", MAPS_API_KEY
        ```

4. Run the apps

   ```bash
   
   #From the root directory
   
   cd depannini-user
   flutter run

   #From the root directory

   cd depannini-assistant
   flutter run

   ```

## Contributers

- Mohammed Alsayed Ahmed - Front-end.
- Anes Adjal - Back-end.
- Merzougui Abdallah ElGhazali - Back-end.