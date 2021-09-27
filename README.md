# kyc - block

NANY ACADEMY - Blockchain based KYC with face detection using Hypeledger fabric composer. Realtime kyc update. Dynamic kyc 

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


## 2. VERIFY REGISTRAR - POST  (firstName, surname, idNumber, dob, gender): /verify/registrar

    👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND  👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "firstname": firstName,
        "idNumber": idNumber,
        "surname": surname,
        "gender": gender,
        "dob": dob
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
    }


## 3. REGISTER - POST  (firstName, surname, idNumber, dob, gender, physicalAddress, idImgLink, pofImgLink,faceImgLink,emailAddress,password): /register

     👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND  👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "firstname": firstName,
        "surname": surname,
        "idNumber": idNumber,
        "gender": gender,
        "dob": dob,
        "physicalAddress": physicalAddress
        "idImgLink": idImgLink,
        "pofImgLink": pofImgLink,
        "faceImgLink": faceImgLink,
        "emailAddress": emailAddress,
        "password": password 
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
        "responseBody":{
            "accessCode": "123456"
        }
    }


## 4. UPLOAD DOCUMENTS - POST  (idBase64Image,idFileName,description, pofBase64Image,pofFileName,description): /upload/kyc-files
    👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND  👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 
     {
        "id": {
            "image": idBase64Image,
            "name": idFileName,
            "description": "ID File"
        },
      "pof": {
            "image": pofBase64Image,
            "name": pofFileName,
            "description": "Proof of Residence File"
        }
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
        "responseBody":{
            "idImgLink": "link_to_image_file",
            "pofImgLink": "link_to_image_file"
        }
    }


## 5. UPLOAD FACE - POST (faceBase64File, faceFileName, description): /upload/face
    👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "face": {
            "image": faceBase64Image,
            "name": faceFileName,
            "description": "Face File"
        },
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
        "responseBody":{
            "faceImgLink": "link_to_image_file"
        }
    }


## 6. GRANT ACCESS - POST(idNumber, bankName): /grant-access
    👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "idNumber": idNumber,
        "bankId": bankId
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
    }


## 7. UPDATE DETAILS - PUT(idNumber, pofBase64Image, physicalAddress): /update-kyc/idNumber
    👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 REQUEST SEND 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉 👉
    {
        "physicalAddress": physicalAddress
        "pof": {
            "image": pofBase64Image,
            "name": pofFileName,
            "description": "Updated File"
        },
    }
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success"
    }

## 8. GET BANKS - GET(idNumber): /get-banks
    👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈 RESPONSE BACK 👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈👈
    {
        "status":200,
        "message": "success",
        "responseBody": {
            "count": 1
            "bankNameList": [{
                "bankName": "NMBZ",
                "bankId": "NMBZ01"
            }]
        }
    }
# nannyacademy
