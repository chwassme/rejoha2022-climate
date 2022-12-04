library(rvest)

url <- 'https://smd.ch/SMDView/log/index.jsp'
session <- html_session(url)

forms <- html_form(read_html(url))
searchForm <- html_form(read_html(url))[[2]]
loginForm <- html_form(read_html(url))[[5]]

loginFormWithValues <- set_values(loginForm,
                          j_username = "JWidmer",
                          j_password = "NBJ3000")

session_submit(session, loginFormWithValues)



# searchForm
# SEARCH_query

searchTerm <- 'Klima'
searchFormWithValues <- set_values(searchForm, SEARCH_query = searchTerm)
session_submit(session, searchFormWithValues)

session %>% html_elements("p")
csession$response$content


# https://smd.ch/SMDView/log/index.jsp?&ajaxlogin=true&hash=%26search%3Dtrue%26sortorder%3Dscore%2520desc%26formdata%3D%255B%257B%2522name%2522%253A%2522SEARCH_mltid%2522%252C%2522value%2522%253A%2522%2522%257D%252C%257B%2522name%2522%253A%2522
# SEARCH_query%2522%252C%2522value%2522%253A%2522XXX%2522%257D%252C%257B%2522name%2522%253A%2522dateDropdown%2522%252C%2522value%2522%253A%2522365%2522%257D%252C%257B%2522name%2522%253A%2522SEARCH_pubDate_lower%2522%252C%2522value%2522%253A%25222021-11-25%2522%257D%252C%257B%2522name%2522%253A%2522SEARCH_pubDate_upper%2522%252C%2522value%2522%253A%25222022-11-25%2522%257D%252C%257B%2522name%2522%253A%2522SEARCH_tiall%2522%252C%2522value%2522%253A%2522%2522%257D%252C%257B%2522name%2522%253A%2522SEARCH_author%2522%252C%2522value%2522%253A%2522%2522%257D%255D&_=1669382085423#&search=true&filter_de=la&sortorder=score%20desc&formdata=%5B%7B%22name%22%3A%22SEARCH_mltid%22%2C%22value%22%3A%22%22%7D%2C%7B%22name%22%3A%22SEARCH_query%22%2C%22value%22%3A%22XXX%22%7D%2C%7B%22name%22%3A%22filter_de%22%2C%22value%22%3A%22de%22%7D%2C%7B%22name%22%3A%22dateDropdown%22%2C%22value%22%3A%22365%22%7D%2C%7B%22name%22%3A%22SEARCH_pubDate_lower%22%2C%22value%22%3A%222021-11-25%22%7D%2C%7B%22name%22%3A%22SEARCH_pubDate_upper%22%2C%22value%22%3A%222022-11-25%22%7D%2C%7B%22name%22%3A%22SEARCH_tiall%22%2C%22value%22%3A%22%22%7D%2C%7B%22name%22%3A%22SEARCH_source%22%2C%22value%22%3A%22%22%7D%2C%7B%22name%22%3A%22SEARCH_author%22%2C%22value%22%3A%22%22%7D%5D