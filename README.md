# nannyacademy - block

NANY ACADEMY - Get your a proffesional nanny

## GETTING STARTED
1. flutter packages get
2. add google-services.json to android/app/ folder
3. flutter run


## REST API INTEGRATION

ENDPOINT (http://backend_url:port/api/nannyacademy)
## 1. LOGIN - POST    (email,password) : /auth/login

     👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND  👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "username": emailAddress,
        "password": password,
    }
    
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
        "responseBody":{
            "x-accessToken": "Abcdqw321bs9u8eu#d6udbc900404fhnf094rb84b482-d9938dbx2x34qw54qudba234"
        }
    }

# nannyacademy
