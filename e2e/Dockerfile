FROM cypress/included:3.6.0

WORKDIR /app

COPY cypress.json .

RUN npx cypress verify
