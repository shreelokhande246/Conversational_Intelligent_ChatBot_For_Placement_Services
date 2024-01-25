import requests, json

designation = input('Enter Position : ').lower()
location = input('Enter location : ').lower()
exp = int(input('Enter experience : '))

payload = json.dumps({
    'designation' : designation,
    'location' : location,
    'exp' : exp
})

# this is proper way of using api
response = requests.get(f'http://127.0.0.1:8000/jobs', data = payload)
print(response.json())
