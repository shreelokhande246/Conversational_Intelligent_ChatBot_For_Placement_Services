from fastapi import FastAPI
import uvicorn
from pydantic import BaseModel
from selenium import webdriver
from bs4 import BeautifulSoup
import time as t


def get_url(designation, location, exp) :
    # x2
    x2 = designation.replace(' ', '%20').replace(',', '%2C%20').replace(', ', '%2C%20')

    # x1
    char_to_replace = {' ': '-', ',': '-', ', ': '-'}
    for key, value in char_to_replace.items() :
        designation = designation.replace(key, value)
    x1 = designation + '-jobs-in-' + location.split(',')[0]

    # x3
    x3 = location.replace(' ', '%20').replace(',', '%2C%20').replace(', ', '%2C%20')

    # x4
    x4 = exp

    # final url
    url = 'https://www.naukri.com/{x1}?k={x2}&l={x3}&experience={x4}&nignbevent_src=jobsearchDeskGNB'.format(x1 = x1, x2 = x2, x3 = x3, x4 = x4)

    return url

# more protected and more sophisticated way
class Input(BaseModel) :
    designation : str
    location : str
    exp : int

app1 = FastAPI()

@app1.get('/jobs')
def predict_model(parameters : Input) :
    url = get_url(parameters.designation, parameters.location, parameters.exp)
    driver = webdriver.Chrome('./chromedriver')
    driver.maximize_window()
    driver.get(url)

    driver.find_elements_by_xpath('//*[@id="root"]/div[4]/div/div/section[3]/div[1]/div[2]/span/span[2]/p/i')[0].click()
    driver.find_element_by_xpath('//*[@id="root"]/div[4]/div/div/section[3]/div[1]/div[2]/span/span[2]/ul/li[2]').click()

    t.sleep(5)
    soup = BeautifulSoup(driver.page_source, 'lxml')
    driver.close()
    results = soup.find(class_ = 'list')

    job_elems = results.find_all('article', class_ = 'jobTuple')

    jobs = {}
    i = 1

    for job_elems in job_elems[:5] :
        d = {'URL': None,
             'Title': None,
             'Company_Name': None,
             'Ratting': None,
             'Review_Count': None,
             'Experience': None,
             'Salary': None,
             'Key_Skills': None,
             'Location': None,
             'Posted_Time': None
             }

        URL = job_elems.find('a', class_='title ellipsis')
        if URL: d['URL'] = URL.get('href')

        Title = job_elems.find('a', class_='title ellipsis')
        if Title: d['Title'] = Title.text

        Company_name = job_elems.find('a', class_='subTitle ellipsis fleft')
        if Company_name: d['Company_Name'] = Company_name.text

        Ratting = job_elems.find('span', class_='starRating fleft')
        if Ratting: d['Ratting'] = Ratting.text

        Review_count = job_elems.find('a', class_='reviewsCount fleft')
        if Review_count: d['Review_Count'] = Review_count.text

        Experience = job_elems.find('span', class_='ellipsis fleft expwdth')
        if Experience: d['Experience'] = Experience.text

        salary = job_elems.find('span', class_='ellipsis fleft')
        if salary: d['Salary'] = salary.text

        skills = job_elems.find('ul', class_='tags has-description')
        skill = []
        [skill.append(i.text) for i in skills]
        if skill: d['Key_Skills'] = skill

        time = job_elems.find('span', class_='fleft postedDate')
        if time: d['Posted_Time'] = time.text

        locations = job_elems.find('span', class_='ellipsis fleft locWdth')
        if locations: d['Location'] = locations.text

        #     print(d)
        jobs.update({i: d})
        i += 1

    return jobs

if __name__ == '__main__' :
    uvicorn.run(app1)
